use crate::{database_universe_to_i64, CDatabaseUniverseCursor, CDatabaseUniverseQueryCursor, CDatabaseUniverseReader, DatabaseUniverseI64};
use database_universe_core::core::cursor::{DatabaseUniverseCursor, DatabaseUniverseQueryCursor};
use std::ptr;

#[no_mangle]
pub unsafe extern "C" fn database_universe_cursor_next(
    cursor: &'static mut CDatabaseUniverseCursor,
    id: DatabaseUniverseI64,
    old_reader: *mut CDatabaseUniverseReader,
) -> *const CDatabaseUniverseReader<'static> {
    let id = database_universe_to_i64(id);

    if !old_reader.is_null() {
        drop(Box::from_raw(old_reader));
    }

    let reader = match cursor {
        #[cfg(feature = "native")]
        CDatabaseUniverseCursor::Native(cursor) => cursor.next(id).map(|reader| CDatabaseUniverseReader::Native(reader)),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseCursor::SQLite(cursor) => cursor.next(id).map(|reader| CDatabaseUniverseReader::SQLite(reader)),
    };
    if let Some(reader) = reader {
        Box::into_raw(Box::new(reader))
    } else {
        ptr::null()
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_cursor_free(cursor: *mut CDatabaseUniverseCursor, reader: *mut CDatabaseUniverseReader) {
    if !cursor.is_null() {
        drop(Box::from_raw(cursor));
    }
    if !reader.is_null() {
        drop(Box::from_raw(reader));
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_query_cursor_next(
    cursor: &'static mut CDatabaseUniverseQueryCursor,
    old_reader: *mut CDatabaseUniverseReader,
) -> *const CDatabaseUniverseReader<'static> {
    if !old_reader.is_null() {
        drop(Box::from_raw(old_reader));
    }

    let reader = match cursor {
        #[cfg(feature = "native")]
        CDatabaseUniverseQueryCursor::Native(cursor) => cursor.next().map(|reader| CDatabaseUniverseReader::Native(reader)),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseQueryCursor::SQLite(cursor) => cursor.next().map(|reader| CDatabaseUniverseReader::SQLite(reader)),
    };
    if let Some(reader) = reader {
        Box::into_raw(Box::new(reader))
    } else {
        ptr::null()
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_query_cursor_free(
    cursor: *mut CDatabaseUniverseQueryCursor,
    reader: *mut CDatabaseUniverseReader,
) {
    if !cursor.is_null() {
        drop(Box::from_raw(cursor));
    }
    if !reader.is_null() {
        drop(Box::from_raw(reader));
    }
}
