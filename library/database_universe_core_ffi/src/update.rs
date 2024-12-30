use crate::{database_universe_to_i64, CDatabaseUniverseInstance, CDatabaseUniverseQuery, CDatabaseUniverseTxn, CDatabaseUniverseUpdate, DatabaseUniverseI64};
use database_universe_core::core::error::DatabaseUniverseError;
use database_universe_core::core::instance::DatabaseUniverseInstance;
use database_universe_core::core::value::DatabaseUniverseValue;

#[no_mangle]
pub unsafe extern "C" fn database_universe_update(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: &CDatabaseUniverseTxn,
    collection_index: u16,
    id: DatabaseUniverseI64,
    update: *mut CDatabaseUniverseUpdate,
    updated: *mut bool,
) -> u8 {
    let id = database_universe_to_i64(id);
    let update = Box::from_raw(update);
    database_universe_try! {
        match (database_universe, txn) {
            #[cfg(feature = "native")]
            (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn)) => {
                *updated = database_universe.update(txn, collection_index, id, &update.0)?;
            }
            #[cfg(feature = "sqlite")]
            (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn)) => {
                *updated = database_universe.update(txn, collection_index, id, &update.0)?;
            }
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_query_update(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: &'static CDatabaseUniverseTxn,
    query: &'static CDatabaseUniverseQuery,
    offset: u32,
    limit: u32,
    update: *mut CDatabaseUniverseUpdate,
    updated: *mut u32,
) -> u8 {
    let offset = if offset == 0 { None } else { Some(offset) };
    let limit = if limit == 0 { None } else { Some(limit) };

    let update = Box::from_raw(update);

    database_universe_try! {
        match (database_universe, txn, query) {
            #[cfg(feature = "native")]
            (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn), CDatabaseUniverseQuery::Native(query)) => {
                *updated = database_universe.query_update(txn, query, offset, limit, &update.0)?;
            }
            #[cfg(feature = "sqlite")]
            (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn), CDatabaseUniverseQuery::SQLite(query)) => {
                *updated = database_universe.query_update(txn, query, offset, limit, &update.0)?;
            }
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_update_new() -> *mut CDatabaseUniverseUpdate {
    Box::into_raw(Box::new(CDatabaseUniverseUpdate(Vec::new())))
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_update_add_value(
    update: &'static mut CDatabaseUniverseUpdate,
    property_index: u16,
    value: *mut DatabaseUniverseValue,
) {
    let value = if !value.is_null() {
        Some(*Box::from_raw(value))
    } else {
        None
    };
    update.0.push((property_index, value));
}
