use crate::{CDatabaseUniverseInstance, CDatabaseUniverseQuery, CDatabaseUniverseQueryBuilder, CDatabaseUniverseQueryCursor, CDatabaseUniverseTxn};
use database_universe_core::core::error::DatabaseUniverseError;
use database_universe_core::core::filter::Filter;
use database_universe_core::core::instance::{Aggregation, DatabaseUniverseInstance};
use database_universe_core::core::query_builder::{DatabaseUniverseQueryBuilder, Sort};
use database_universe_core::core::value::DatabaseUniverseValue;
use std::ptr;

#[no_mangle]
pub unsafe extern "C" fn database_universe_query_new(
    database_universe: &'static CDatabaseUniverseInstance,
    collection_index: u16,
    query_builder: *mut *const CDatabaseUniverseQueryBuilder,
) -> u8 {
    database_universe_try! {
        let new_builder = match database_universe {
            #[cfg(feature = "native")]
            CDatabaseUniverseInstance::Native(database_universe) => CDatabaseUniverseQueryBuilder::Native(database_universe.query(collection_index)?),
            #[cfg(feature = "sqlite")]
            CDatabaseUniverseInstance::SQLite(database_universe) => CDatabaseUniverseQueryBuilder::SQLite(database_universe.query(collection_index)?),
        };
        *query_builder = Box::into_raw(Box::new(new_builder));
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_query_set_filter(
    builder: &'static mut CDatabaseUniverseQueryBuilder,
    filter: *mut Filter,
) {
    let filter = *Box::from_raw(filter);
    match builder {
        #[cfg(feature = "native")]
        CDatabaseUniverseQueryBuilder::Native(builder) => builder.set_filter(filter),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseQueryBuilder::SQLite(builder) => builder.set_filter(filter),
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_query_add_sort(
    builder: &'static mut CDatabaseUniverseQueryBuilder,
    property_index: u16,
    ascending: bool,
    case_sensitive: bool,
) {
    let sort = if ascending { Sort::Asc } else { Sort::Desc };
    match builder {
        #[cfg(feature = "native")]
        CDatabaseUniverseQueryBuilder::Native(builder) => {
            builder.add_sort(property_index, sort, case_sensitive)
        }
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseQueryBuilder::SQLite(builder) => {
            builder.add_sort(property_index, sort, case_sensitive)
        }
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_query_add_distinct(
    builder: &'static mut CDatabaseUniverseQueryBuilder,
    property_index: u16,
    case_sensitive: bool,
) {
    match builder {
        #[cfg(feature = "native")]
        CDatabaseUniverseQueryBuilder::Native(builder) => builder.add_distinct(property_index, case_sensitive),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseQueryBuilder::SQLite(builder) => builder.add_distinct(property_index, case_sensitive),
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_query_build(builder: *mut CDatabaseUniverseQueryBuilder) -> *mut CDatabaseUniverseQuery {
    let builder = *Box::from_raw(builder);
    match builder {
        #[cfg(feature = "native")]
        CDatabaseUniverseQueryBuilder::Native(builder) => {
            let query = builder.build();
            Box::into_raw(Box::new(CDatabaseUniverseQuery::Native(query)))
        }
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseQueryBuilder::SQLite(builder) => {
            let query = builder.build();
            Box::into_raw(Box::new(CDatabaseUniverseQuery::SQLite(query)))
        }
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_query_cursor(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: &'static CDatabaseUniverseTxn,
    query: &'static CDatabaseUniverseQuery,
    cursor: *mut *const CDatabaseUniverseQueryCursor,
    offset: u32,
    limit: u32,
) -> u8 {
    let offset = if offset == 0 { None } else { Some(offset) };
    let limit = if limit == 0 { None } else { Some(limit) };

    database_universe_try! {
        let new_cursor = match (database_universe, txn, query) {
            #[cfg(feature = "native")]
            (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn), CDatabaseUniverseQuery::Native(query)) => {
                let cursor = database_universe.query_cursor(txn, query, offset, limit)?;
                CDatabaseUniverseQueryCursor::Native(cursor)
            }
            #[cfg(feature = "sqlite")]
            (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn), CDatabaseUniverseQuery::SQLite(query)) => {
                let cursor = database_universe.query_cursor(txn, query, offset, limit)?;
                CDatabaseUniverseQueryCursor::SQLite(cursor)
            }
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
        *cursor = Box::into_raw(Box::new(new_cursor));
    }
}

pub const AGGREGATION_COUNT: u8 = 0;
pub const AGGREGATION_IS_EMPTY: u8 = 1;
pub const AGGREGATION_MIN: u8 = 2;
pub const AGGREGATION_MAX: u8 = 3;
pub const AGGREGATION_SUM: u8 = 4;
pub const AGGREGATION_AVERAGE: u8 = 5;

#[no_mangle]
pub unsafe extern "C" fn database_universe_query_aggregate(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: &'static CDatabaseUniverseTxn,
    query: &'static CDatabaseUniverseQuery,
    aggregation: u8,
    property_index: u16,
    value: *mut *const DatabaseUniverseValue,
) -> u8 {
    let aggregation = match aggregation {
        AGGREGATION_COUNT => Aggregation::Count,
        AGGREGATION_IS_EMPTY => Aggregation::IsEmpty,
        AGGREGATION_MIN => Aggregation::Min,
        AGGREGATION_MAX => Aggregation::Max,
        AGGREGATION_SUM => Aggregation::Sum,
        AGGREGATION_AVERAGE => Aggregation::Average,
        _ => {
            *value = ptr::null();
            return 0;
        }
    };
    database_universe_try! {
        let new_value = match (database_universe, txn, query) {
            #[cfg(feature = "native")]
            (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn), CDatabaseUniverseQuery::Native(query)) => {
                database_universe.query_aggregate(txn, query, aggregation, Some(property_index))?
            }
            #[cfg(feature = "sqlite")]
            (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn), CDatabaseUniverseQuery::SQLite(query)) => {
                database_universe.query_aggregate(txn, query, aggregation, Some(property_index))?
            }
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
        if let Some(new_value) = new_value {
            *value = Box::into_raw(Box::new(new_value));
        } else {
            *value = ptr::null();
        }
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_query_delete(
    database_universe: &'static CDatabaseUniverseInstance,
    txn: &'static CDatabaseUniverseTxn,
    query: &'static CDatabaseUniverseQuery,
    offset: u32,
    limit: u32,
    count: *mut u32,
) -> u8 {
    let offset = if offset == 0 { None } else { Some(offset) };
    let limit = if limit == 0 { None } else { Some(limit) };
    database_universe_try! {
        let new_count = match (database_universe, txn, query) {
            #[cfg(feature = "native")]
            (CDatabaseUniverseInstance::Native(database_universe), CDatabaseUniverseTxn::Native(txn), CDatabaseUniverseQuery::Native(query)) => {
                database_universe.query_delete(txn, query, offset, limit)?
            }
            #[cfg(feature = "sqlite")]
            (CDatabaseUniverseInstance::SQLite(database_universe), CDatabaseUniverseTxn::SQLite(txn), CDatabaseUniverseQuery::SQLite(query)) => {
                database_universe.query_delete(txn, query, offset, limit)?
            }
            _ => return Err(DatabaseUniverseError::IllegalArgument {}),
        };
        *count = new_count;
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_query_free(query: *mut CDatabaseUniverseQuery) {
    if !query.is_null() {
        drop(Box::from_raw(query));
    }
}
