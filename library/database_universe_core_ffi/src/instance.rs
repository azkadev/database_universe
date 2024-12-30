use crate::{
    dart_fast_hash, i64_to_database_universe, database_universe_to_i64, CDatabaseUniverseCursor, CDatabaseUniverseInstance, CDatabaseUniverseTxn, DatabaseUniverseI64,
};
use database_universe_core::core::error::DatabaseUniverseError;
use database_universe_core::core::instance::{CompactCondition, DatabaseUniverseInstance};
use database_universe_core::core::schema::DatabaseUniverseSchema;
use std::os::raw::c_char;
use std::ptr;

#[cfg(feature = "native")]
use database_universe_core::native::native_instance::NativeInstance;

#[cfg(feature = "sqlite")]
use database_universe_core::sqlite::sqlite_instance::SQLiteInstance;

include!(concat!(env!("OUT_DIR"), "/version.rs"));

#[no_mangle]
pub unsafe extern "C" fn database_universe_version() -> *const c_char {
    DATABASE_UNIVERSE_VERSION.as_ptr() as *const c_char
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_get_instance(instance_id: u32, sqlite: bool) -> *const CDatabaseUniverseInstance {
    if sqlite {
        #[cfg(feature = "sqlite")]
        if let Some(instance) = SQLiteInstance::get_instance(instance_id) {
            return Box::into_raw(Box::new(CDatabaseUniverseInstance::SQLite(instance)));
        }
    } else {
        #[cfg(feature = "native")]
        if let Some(instance) = NativeInstance::get_instance(instance_id) {
            return Box::into_raw(Box::new(CDatabaseUniverseInstance::Native(instance)));
        }
    }
    ptr::null()
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_open_instance(
    database_universe: *mut *const CDatabaseUniverseInstance,
    instance_id: u32,
    name: *mut String,
    path: *mut String,
    sqlite: bool,
    schema_json: *mut String,
    max_size_mib: u32,
    encryption_key: *mut String,
    compact_min_file_size: u32,
    compact_min_bytes: u32,
    compact_min_ratio: f32,
) -> u8 {
    database_universe_try! {
        let name = *Box::from_raw(name);
        let path = *Box::from_raw(path);
        let schema_json = *Box::from_raw(schema_json);
        let schemas = DatabaseUniverseSchema::from_json(schema_json.as_bytes())?;

        let encryption_key = if encryption_key.is_null() {
            None
        } else {
            Some(*Box::from_raw(encryption_key))
        };

        let compact_condition = if compact_min_ratio.is_nan() {
            None
        } else {
            Some(CompactCondition {
                min_file_size: compact_min_file_size,
                min_bytes: compact_min_bytes,
                min_ratio: compact_min_ratio,
            })
        };

        let new_database_universe = if sqlite {
            #[cfg(feature = "sqlite")]
            {
                let instance = SQLiteInstance::open_instance(
                    instance_id,
                    &name,
                    &path,
                    schemas,
                    max_size_mib,
                    encryption_key.as_deref(),
                    compact_condition,
                )?;
                CDatabaseUniverseInstance::SQLite(instance)
            }
            #[cfg(not(feature = "sqlite"))]
            {
                return Err(DatabaseUniverseError::UnsupportedOperation {});
            }
        } else {
            #[cfg(feature = "native")]
            {
                let instance = NativeInstance::open_instance(
                    instance_id,
                    &name,
                    &path,
                    schemas,
                    max_size_mib,
                    encryption_key.as_deref(),
                    compact_condition,
                )?;
                CDatabaseUniverseInstance::Native(instance)
            }
            #[cfg(not(feature = "native"))]
            {
                return Err(DatabaseUniverseError::UnsupportedOperation {});
            }
        };
        *database_universe = Box::into_raw(Box::new(new_database_universe));
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_get_name(database_universe: &'static CDatabaseUniverseInstance, name: *mut *const u8) -> u32 {
    let value = match database_universe {
        #[cfg(feature = "native")]
        CDatabaseUniverseInstance::Native(database_universe) => database_universe.get_name(),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseInstance::SQLite(database_universe) => database_universe.get_name(),
    };
    *name = value.as_ptr();
    value.len() as u32
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_get_dir(database_universe: &'static CDatabaseUniverseInstance, dir: *mut *const u8) -> u32 {
    let value = match database_universe {
        #[cfg(feature = "native")]
        CDatabaseUniverseInstance::Native(database_universe) => database_universe.get_dir(),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseInstance::SQLite(database_universe) => database_universe.get_dir(),
    };
    *dir = value.as_ptr();
    value.len() as u32
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_change_encryption_key(
    database_universe: &'static CDatabaseUniverseInstance,
    encryption_key: *mut String,
) -> u8 {
    let encryption_key = if encryption_key.is_null() {
        None
    } else {
        Some(*Box::from_raw(encryption_key))
    };

    database_universe_try! {
        match database_universe {
            #[cfg(feature = "native")]
            CDatabaseUniverseInstance::Native(database_universe) => database_universe.change_encryption_key(encryption_key.as_deref())?,
            #[cfg(feature = "sqlite")]
            CDatabaseUniverseInstance::SQLite(database_universe) => database_universe.change_encryption_key(encryption_key.as_deref())?,
        }
    }
}

unsafe fn _database_universe_txn_begin(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: *mut *const CDatabaseUniverseTxn,
    write: bool,
) -> u8 {
    database_universe_try! {
        let new_txn = match database_universe {
            #[cfg(feature = "native")]
            CDatabaseUniverseInstance::Native(database_universe) => CDatabaseUniverseTxn::Native(database_universe.begin_txn(write)?),
            #[cfg(feature = "sqlite")]
            CDatabaseUniverseInstance::SQLite(database_universe) => CDatabaseUniverseTxn::SQLite(database_universe.begin_txn(write)?),
        };
        *txn = Box::into_raw(Box::new(new_txn));
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_txn_begin(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: *mut *const CDatabaseUniverseTxn,
    write: bool,
) -> u8 {
    database_universe_pause_isolate! {
        database_universe_try! {
            let new_txn = match database_universe {
                #[cfg(feature = "native")]
                CDatabaseUniverseInstance::Native(database_universe) => CDatabaseUniverseTxn::Native(database_universe.begin_txn(write)?),
                #[cfg(feature = "sqlite")]
                CDatabaseUniverseInstance::SQLite(database_universe) => CDatabaseUniverseTxn::SQLite(database_universe.begin_txn(write)?),
            };
            *txn = Box::into_raw(Box::new(new_txn));
        }
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_txn_commit(database_universe: &'static CDatabaseUniverseInstance, txn: *mut CDatabaseUniverseTxn) -> u8 {
    database_universe_pause_isolate! {
        database_universe_try! {
            let txn = *Box::from_raw(txn);
            match (database_universe, txn) {
                #[cfg(feature = "native")]
                (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn)) => database_universe.commit_txn(txn)?,
                #[cfg(feature = "sqlite")]
                (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn)) => database_universe.commit_txn(txn)?,
                _ => return Err(DatabaseUniverseError::IllegalArgument {}),
            }
        }
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_txn_abort(database_universe: &'static CDatabaseUniverseInstance, txn: *mut CDatabaseUniverseTxn) {
    let txn = *Box::from_raw(txn);
    match (database_universe, txn) {
        #[cfg(feature = "native")]
        (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn)) => {
            database_universe.abort_txn(txn);
        }
        #[cfg(feature = "sqlite")]
        (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn)) => {
            database_universe.abort_txn(txn);
        }
        _ => {}
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_auto_increment(
    database_universe: &'static CDatabaseUniverseInstance,
    collection_index: u16,
) -> DatabaseUniverseI64 {
    let id = match database_universe {
        #[cfg(feature = "native")]
        CDatabaseUniverseInstance::Native(database_universe) => database_universe.auto_increment(collection_index),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseInstance::SQLite(database_universe) => database_universe.auto_increment(collection_index),
    };
    i64_to_database_universe(id)
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_cursor(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: &'static CDatabaseUniverseTxn,
    collection_index: u16,
    cursor: *mut *const CDatabaseUniverseCursor,
) -> u8 {
    database_universe_try! {
        let new_cursor = match (database_universe, txn) {
            #[cfg(feature = "native")]
            (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn)) => {
                let cursor = database_universe.cursor(txn, collection_index)?;
                CDatabaseUniverseCursor::Native(cursor)
            }
            #[cfg(feature = "sqlite")]
            (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn)) => {
                let cursor = database_universe.cursor(txn, collection_index)?;
                CDatabaseUniverseCursor::SQLite(cursor)
            }
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
        *cursor = Box::into_raw(Box::new(new_cursor));
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_delete(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: &'static CDatabaseUniverseTxn,
    collection_index: u16,
    id: DatabaseUniverseI64,
    deleted: *mut bool,
) -> u8 {
    let id = database_universe_to_i64(id);
    database_universe_try! {
        *deleted = match (database_universe, txn) {
            #[cfg(feature = "native")]
            (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn)) => {
                database_universe.delete(txn, collection_index, id)?
            }
            #[cfg(feature = "sqlite")]
            (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn)) => {
                database_universe.delete(txn, collection_index, id)?
            }
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_count(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: &'static CDatabaseUniverseTxn,
    collection_index: u16,
    count: *mut u32,
) -> u8 {
    database_universe_try! {
        let new_count = match (database_universe, txn) {
            #[cfg(feature = "native")]
            (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn)) => {
                database_universe.count(txn, collection_index)?
            }
            #[cfg(feature = "sqlite")]
            (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn)) => {
                database_universe.count(txn, collection_index)?
            }
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
        *count = new_count;
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_clear(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: &'static CDatabaseUniverseTxn,
    collection_index: u16,
) -> u8 {
    database_universe_try! {
        match (database_universe, txn) {
            #[cfg(feature = "native")]
            (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn)) => {
                database_universe.clear(txn, collection_index)?
            }
            #[cfg(feature = "sqlite")]
            (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn)) => {
                database_universe.clear(txn, collection_index)?
            }
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_get_size(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: &'static CDatabaseUniverseTxn,
    collection_index: u16,
    include_indexes: bool,
) -> u32 {
    match (database_universe, txn) {
        #[cfg(feature = "native")]
        (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn)) => database_universe
            .get_size(txn, collection_index, include_indexes)
            .unwrap_or(0) as u32,
        #[cfg(feature = "sqlite")]
        (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn)) => database_universe
            .get_size(txn, collection_index, include_indexes)
            .unwrap_or(0) as u32,
        _ => 0,
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_import_json(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: *mut *mut CDatabaseUniverseTxn,
    collection_index: u16,
    json: *mut String,
    count: *mut u32,
) -> u8 {
    let json = *Box::from_raw(json);
    let mut deserializer = serde_json::Deserializer::from_str(&json);
    database_universe_try! {
        let (new_txn, new_count) = match (database_universe, *Box::from_raw(*txn)) {
            #[cfg(feature = "native")]
            (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn)) => {
                let (txn, count) = database_universe.import_json(txn, collection_index, &mut deserializer, dart_fast_hash)?;
                (CDatabaseUniverseTxn::Native(txn), count)
            }
            #[cfg(feature = "sqlite")]
            (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn)) => {
                let (txn, count) = database_universe.import_json(txn, collection_index, &mut deserializer, dart_fast_hash)?;
                (CDatabaseUniverseTxn::SQLite(txn), count)
            }
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
        *txn = Box::into_raw(Box::new(new_txn));
        *count = new_count;
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_copy(database_universe: &'static CDatabaseUniverseInstance, path: *mut String) -> u8 {
    database_universe_pause_isolate! {
        database_universe_try! {
            let path = *Box::from_raw(path);
            match database_universe {
                #[cfg(feature = "native")]
                CDatabaseUniverseInstance::Native(database_universe) => database_universe.copy(&path)?,
                #[cfg(feature = "sqlite")]
                CDatabaseUniverseInstance::SQLite(database_universe) => database_universe.copy(&path)?,
            }
        }
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_verify(database_universe: &'static CDatabaseUniverseInstance, txn: &'static CDatabaseUniverseTxn) -> u8 {
    database_universe_try! {
        return match (database_universe, txn) {
            #[cfg(feature = "native")]
            (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn)) => database_universe.verify(txn),
            #[cfg(feature = "sqlite")]
            (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn)) => database_universe.verify(txn),
            _ => Err(DatabaseUniverseError::IllegalArgument {}),
        }
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_close(database_universe: *mut CDatabaseUniverseInstance, delete: bool) -> u8 {
    database_universe_pause_isolate! {
        let database_universe = *Box::from_raw(database_universe);
        let closed = match database_universe {
            #[cfg(feature = "native")]
            CDatabaseUniverseInstance::Native(database_universe) => NativeInstance::close(database_universe, delete),
            #[cfg(feature = "sqlite")]
            CDatabaseUniverseInstance::SQLite(database_universe) => SQLiteInstance::close(database_universe, delete),
        };
        if closed {
            1
        } else {
            0
        }
    }
}
