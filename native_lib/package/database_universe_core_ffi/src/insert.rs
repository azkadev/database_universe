use crate::{database_universe_to_i64, CDatabaseUniverseInstance, CDatabaseUniverseTxn, CDatabaseUniverseWriter, DatabaseUniverseI64};
use database_universe_core::core::error::DatabaseUniverseError;
use database_universe_core::core::insert::DatabaseUniverseInsert;
use database_universe_core::core::instance::DatabaseUniverseInstance;

#[no_mangle]
pub unsafe extern "C" fn database_universe_insert(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: *mut CDatabaseUniverseTxn,
    collection_index: u16,
    count: u32,
    insert: *mut *const CDatabaseUniverseWriter,
) -> u8 {
    database_universe_try! {
        let txn = *Box::from_raw(txn);
        let new_insert = match (database_universe, txn) {
            #[cfg(feature = "native")]
            (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn)) => {
                let insert = database_universe.insert(txn, collection_index, count)?;
                CDatabaseUniverseWriter::Native(insert)
            }
            #[cfg(feature = "sqlite")]
            (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn)) => {
                let insert = database_universe.insert(txn, collection_index, count)?;
                CDatabaseUniverseWriter::SQLite(insert)
            }
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
        *insert = Box::into_raw(Box::new(new_insert));
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_insert_save(insert: &mut CDatabaseUniverseWriter<'static>, id: DatabaseUniverseI64) -> u8 {
    let id = database_universe_to_i64(id);
    database_universe_try! {
        match insert {
            #[cfg(feature = "native")]
            CDatabaseUniverseWriter::Native(insert) => insert.save(id)?,
            #[cfg(feature = "sqlite")]
            CDatabaseUniverseWriter::SQLite(insert) => insert.save(id)?,
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_insert_finish(
    insert: *mut CDatabaseUniverseWriter,
    txn: *mut *const CDatabaseUniverseTxn,
) -> u8 {
    database_universe_try! {
        let insert = *Box::from_raw(insert);
        let new_txn = match insert {
            #[cfg(feature = "native")]
            CDatabaseUniverseWriter::Native(insert) => CDatabaseUniverseTxn::Native(insert.finish()?),
            #[cfg(feature = "sqlite")]
            CDatabaseUniverseWriter::SQLite(insert) => CDatabaseUniverseTxn::SQLite(insert.finish()?),
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
        *txn = Box::into_raw(Box::new(new_txn));
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_insert_abort(insert: *mut CDatabaseUniverseWriter) {
    let _ = *Box::from_raw(insert);
}
