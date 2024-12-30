use crate::{database_universe_to_i64, CDatabaseUniverseWriter, DatabaseUniverseI64};
use database_universe_core::core::writer::DatabaseUniverseWriter;
use std::slice;

#[no_mangle]
pub unsafe extern "C" fn database_universe_write_null(writer: &'static mut CDatabaseUniverseWriter, index: u32) {
    match writer {
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::Native(writer) => writer.write_null(index),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeObject(writer) => writer.write_null(index),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeList(writer) => writer.write_null(index),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLite(writer) => writer.write_null(index),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteObject(writer) => writer.write_null(index),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteList(writer) => writer.write_null(index),
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_write_bool(
    writer: &'static mut CDatabaseUniverseWriter,
    index: u32,
    value: bool,
) {
    match writer {
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::Native(writer) => writer.write_bool(index, value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeObject(writer) => writer.write_bool(index, value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeList(writer) => writer.write_bool(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLite(writer) => writer.write_bool(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteObject(writer) => writer.write_bool(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteList(writer) => writer.write_bool(index, value),
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_write_byte(writer: &'static mut CDatabaseUniverseWriter, index: u32, value: u8) {
    match writer {
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::Native(writer) => writer.write_byte(index, value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeObject(writer) => writer.write_byte(index, value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeList(writer) => writer.write_byte(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLite(writer) => writer.write_byte(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteObject(writer) => writer.write_byte(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteList(writer) => writer.write_byte(index, value),
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_write_int(writer: &'static mut CDatabaseUniverseWriter, index: u32, value: i32) {
    match writer {
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::Native(writer) => writer.write_int(index, value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeObject(writer) => writer.write_int(index, value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeList(writer) => writer.write_int(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLite(writer) => writer.write_int(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteObject(writer) => writer.write_int(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteList(writer) => writer.write_int(index, value),
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_write_float(
    writer: &'static mut CDatabaseUniverseWriter,
    index: u32,
    value: f32,
) {
    match writer {
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::Native(writer) => writer.write_float(index, value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeObject(writer) => writer.write_float(index, value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeList(writer) => writer.write_float(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLite(writer) => writer.write_float(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteObject(writer) => writer.write_float(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteList(writer) => writer.write_float(index, value),
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_write_long(
    writer: &'static mut CDatabaseUniverseWriter,
    index: u32,
    value: DatabaseUniverseI64,
) {
    let value = database_universe_to_i64(value);
    match writer {
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::Native(writer) => writer.write_long(index, value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeObject(writer) => writer.write_long(index, value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeList(writer) => writer.write_long(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLite(writer) => writer.write_long(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteObject(writer) => writer.write_long(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteList(writer) => writer.write_long(index, value),
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_write_double(
    writer: &'static mut CDatabaseUniverseWriter,
    index: u32,
    value: f64,
) {
    match writer {
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::Native(writer) => writer.write_double(index, value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeObject(writer) => writer.write_double(index, value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeList(writer) => writer.write_double(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLite(writer) => writer.write_double(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteObject(writer) => writer.write_double(index, value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteList(writer) => writer.write_double(index, value),
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_write_string(
    writer: &'static mut CDatabaseUniverseWriter,
    index: u32,
    value: *mut String,
) {
    let value = *Box::from_raw(value);
    match writer {
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::Native(writer) => writer.write_string(index, &value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeObject(writer) => writer.write_string(index, &value),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeList(writer) => writer.write_string(index, &value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLite(writer) => writer.write_string(index, &value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteObject(writer) => writer.write_string(index, &value),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteList(writer) => writer.write_string(index, &value),
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_write_byte_list(
    writer: &'static mut CDatabaseUniverseWriter,
    index: u32,
    value: *const u8,
    length: u32,
) {
    let bytes = slice::from_raw_parts(value, length as usize);
    match writer {
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::Native(writer) => writer.write_byte_list(index, bytes),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeObject(writer) => writer.write_byte_list(index, bytes),
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeList(writer) => writer.write_byte_list(index, bytes),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLite(writer) => writer.write_byte_list(index, bytes),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteObject(writer) => writer.write_byte_list(index, bytes),
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteList(writer) => writer.write_byte_list(index, bytes),
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_write_object(
    writer: &'static mut CDatabaseUniverseWriter,
    index: u32,
) -> *mut CDatabaseUniverseWriter<'static> {
    let writer = match writer {
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::Native(writer) => {
            CDatabaseUniverseWriter::NativeObject(writer.begin_object(index).unwrap())
        }
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeObject(writer) => {
            CDatabaseUniverseWriter::NativeObject(writer.begin_object(index).unwrap())
        }
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeList(writer) => {
            CDatabaseUniverseWriter::NativeObject(writer.begin_object(index).unwrap())
        }
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLite(writer) => {
            CDatabaseUniverseWriter::SQLiteObject(writer.begin_object(index).unwrap())
        }
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteObject(writer) => {
            CDatabaseUniverseWriter::SQLiteObject(writer.begin_object(index).unwrap())
        }
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteList(writer) => {
            CDatabaseUniverseWriter::SQLiteObject(writer.begin_object(index).unwrap())
        }
    };
    Box::into_raw(Box::new(writer))
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_write_object_end(
    writer: &'static mut CDatabaseUniverseWriter,
    embedded_writer: *mut CDatabaseUniverseWriter<'static>,
) {
    let embedded_writer = *Box::from_raw(embedded_writer);
    match (writer, embedded_writer) {
        #[cfg(feature = "native")]
        (CDatabaseUniverseWriter::Native(writer), CDatabaseUniverseWriter::NativeObject(embedded_writer)) => {
            writer.end_object(embedded_writer)
        }
        #[cfg(feature = "native")]
        (CDatabaseUniverseWriter::NativeObject(writer), CDatabaseUniverseWriter::NativeObject(embedded_writer)) => {
            writer.end_object(embedded_writer)
        }
        #[cfg(feature = "native")]
        (CDatabaseUniverseWriter::NativeList(writer), CDatabaseUniverseWriter::NativeObject(embedded_writer)) => {
            writer.end_object(embedded_writer)
        }
        #[cfg(feature = "sqlite")]
        (CDatabaseUniverseWriter::SQLite(writer), CDatabaseUniverseWriter::SQLiteObject(embedded_writer)) => {
            writer.end_object(embedded_writer)
        }
        #[cfg(feature = "sqlite")]
        (CDatabaseUniverseWriter::SQLiteObject(writer), CDatabaseUniverseWriter::SQLiteObject(embedded_writer)) => {
            writer.end_object(embedded_writer)
        }
        #[cfg(feature = "sqlite")]
        (CDatabaseUniverseWriter::SQLiteList(writer), CDatabaseUniverseWriter::SQLiteObject(embedded_writer)) => {
            writer.end_object(embedded_writer)
        }
        _ => {}
    }
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_write_list(
    writer: &'static mut CDatabaseUniverseWriter,
    index: u32,
    length: u32,
) -> *mut CDatabaseUniverseWriter<'static> {
    let writer = match writer {
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::Native(writer) => {
            CDatabaseUniverseWriter::NativeList(writer.begin_list(index, length).unwrap())
        }
        #[cfg(feature = "native")]
        CDatabaseUniverseWriter::NativeObject(writer) => {
            CDatabaseUniverseWriter::NativeList(writer.begin_list(index, length).unwrap())
        }
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLite(writer) => {
            CDatabaseUniverseWriter::SQLiteList(writer.begin_list(index, length).unwrap())
        }
        #[cfg(feature = "sqlite")]
        CDatabaseUniverseWriter::SQLiteObject(writer) => {
            CDatabaseUniverseWriter::SQLiteList(writer.begin_list(index, length).unwrap())
        }
        _ => panic!("Cannot write nested list"),
    };
    Box::into_raw(Box::new(writer))
}

#[no_mangle]
pub unsafe extern "C" fn database_universe_write_list_end(
    writer: &'static mut CDatabaseUniverseWriter,
    list_writer: *mut CDatabaseUniverseWriter<'static>,
) {
    let list_writer = *Box::from_raw(list_writer);
    match (writer, list_writer) {
        #[cfg(feature = "native")]
        (CDatabaseUniverseWriter::Native(writer), CDatabaseUniverseWriter::NativeList(list_writer)) => {
            writer.end_list(list_writer)
        }
        #[cfg(feature = "native")]
        (CDatabaseUniverseWriter::NativeObject(writer), CDatabaseUniverseWriter::NativeList(list_writer)) => {
            writer.end_list(list_writer)
        }
        #[cfg(feature = "native")]
        (CDatabaseUniverseWriter::NativeList(writer), CDatabaseUniverseWriter::NativeList(list_writer)) => {
            writer.end_list(list_writer)
        }
        #[cfg(feature = "sqlite")]
        (CDatabaseUniverseWriter::SQLite(writer), CDatabaseUniverseWriter::SQLiteList(list_writer)) => {
            writer.end_list(list_writer)
        }
        #[cfg(feature = "sqlite")]
        (CDatabaseUniverseWriter::SQLiteObject(writer), CDatabaseUniverseWriter::SQLiteList(list_writer)) => {
            writer.end_list(list_writer)
        }
        #[cfg(feature = "sqlite")]
        (CDatabaseUniverseWriter::SQLiteList(writer), CDatabaseUniverseWriter::SQLiteList(list_writer)) => {
            writer.end_list(list_writer)
        }
        _ => {}
    }
}
