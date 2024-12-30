use database_universe_core::core::{error::DatabaseUniverseError, instance::DatabaseUniverseInstance, watcher::WatchHandle};

use crate::dart::{dart_post_int, DartPort};
use crate::{CDatabaseUniverseInstance, CDatabaseUniverseQuery};

#[no_mangle]
pub unsafe extern "C" fn database_universe_watch_collection(
    database_universe: &'static CDatabaseUniverseInstance,
    collection_index: u16,
    port: DartPort,
    handle: *mut *mut WatchHandle,
) -> u8 {
    let callback = Box::new(move || {
        dart_post_int(port, 1);
    });
    database_universe_try! {
        let new_handle = match database_universe {
            #[cfg(feature = "native")]
            CDatabaseUniverseInstance::Native(database_universe) => database_universe.watch(collection_index, callback)?,
            #[cfg(feature = "sqlite")]
            CDatabaseUniverseInstance::SQLite(database_universe) => database_universe.watch(collection_index, callback)?,
        };
        *handle = Box::into_raw(Box::new(new_handle));
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_watch_object(
    database_universe: &'static CDatabaseUniverseInstance,
    collection_index: u16,
    id: i64,
    port: DartPort,
    handle: *mut *mut WatchHandle,
) -> u8 {
    let callback = Box::new(move || {
        dart_post_int(port, 1);
    });
    database_universe_try! {
        let new_handle = match database_universe {
            #[cfg(feature = "native")]
            CDatabaseUniverseInstance::Native(database_universe) => database_universe.watch_object(collection_index, id, callback)?,
            #[cfg(feature = "sqlite")]
            CDatabaseUniverseInstance::SQLite(database_universe) => database_universe.watch_object(collection_index, id, callback)?,
        };
        *handle = Box::into_raw(Box::new(new_handle));
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_watch_query(
    database_universe: &'static CDatabaseUniverseInstance,
    query: &CDatabaseUniverseQuery,
    port: DartPort,
    handle: *mut *mut WatchHandle,
) -> u8 {
    let callback = Box::new(move || {
        dart_post_int(port, 1);
    });
    database_universe_try! {
        let new_handle = match (database_universe, query) {
            #[cfg(feature = "native")]
            (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseQuery::Native(query)) => {
                database_universe.watch_query(query, callback)?
            }
            #[cfg(feature = "sqlite")]
            (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseQuery::SQLite(query)) => {
                database_universe.watch_query(query, callback)?
            }
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
        *handle = Box::into_raw(Box::new(new_handle));
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_stop_watching(handle: *mut WatchHandle) {
    Box::from_raw(handle).stop();
}
