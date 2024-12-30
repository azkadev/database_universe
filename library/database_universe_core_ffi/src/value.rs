use crate::{i64_to_database_universe, database_universe_to_i64, DatabaseUniverseI64};
use database_universe_core::core::value::DatabaseUniverseValue;
use std::ptr;

#[no_mangle]
pub unsafe extern "C" fn database_universe_value_bool(value: bool) -> *const DatabaseUniverseValue {
    Box::into_raw(Box::new(DatabaseUniverseValue::Bool(value)))
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_value_integer(value: DatabaseUniverseI64) -> *const DatabaseUniverseValue {
    let value = database_universe_to_i64(value);
    Box::into_raw(Box::new(DatabaseUniverseValue::Integer(value)))
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_value_real(value: f64) -> *const DatabaseUniverseValue {
    Box::into_raw(Box::new(DatabaseUniverseValue::Real(value)))
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_value_string(value: *mut String) -> *const DatabaseUniverseValue {
    Box::into_raw(Box::new(DatabaseUniverseValue::String(*Box::from_raw(value))))
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_value_get_bool(value: *const DatabaseUniverseValue) -> u8 {
    let value = value.as_ref().map(|v| v.bool()).flatten().unwrap_or(false);
    if value {
        1
    } else {
        0
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_value_get_integer(value: *const DatabaseUniverseValue) -> DatabaseUniverseI64 {
    let value = value
        .as_ref()
        .map(|v| v.i64())
        .flatten()
        .unwrap_or(i64::MIN);
    i64_to_database_universe(value)
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_value_get_real(value: *const DatabaseUniverseValue) -> f64 {
    value
        .as_ref()
        .map(|v| v.real())
        .flatten()
        .unwrap_or(f64::NAN)
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_value_get_string(
    value: *const DatabaseUniverseValue,
    str: *mut *const u8,
) -> u32 {
    *str = ptr::null();
    if let Some(value) = value.as_ref().map(|v| v.string()).flatten() {
        *str = value.as_bytes().as_ptr();
        return value.len() as u32;
    }
    0
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_value_free(value: *mut DatabaseUniverseValue) {
    if !value.is_null() {
        drop(Box::from_raw(value));
    }
}
