/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
// ignore_for_file: camel_case_types, non_constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
// ignore_for_file: type=lint
import 'package:database_universe/core/core/web/ffi.dart' as ffi;
import 'package:database_universe/core/core/web/interop.dart';

extension DatabaseUniverseBindingsX on JSDatabaseUniverse {
  @ffi.Native<
      ffi.Pointer<CString> Function(ffi.Pointer<ffi.Uint16>, ffi.Uint32)>()
  external ffi.Pointer<CString> database_universe_string(
    ffi.Pointer<ffi.Uint16> chars,
    int length,
  );

  @ffi.Native<ffi.Void Function(ffi.Pointer<ffi.Uint8>, ffi.Uint32)>()
  external void database_universe_buffer_free(
    ffi.Pointer<ffi.Uint8> value,
    int capacity,
  );

  @ffi.Native<ffi.Uint32 Function(ffi.Pointer<ffi.Pointer<ffi.Uint8>>)>()
  external int database_universe_get_error(
    ffi.Pointer<ffi.Pointer<ffi.Uint8>> value,
  );

  @ffi.Native<
      ffi.Pointer<CDatabaseUniverseReader> Function(
          ffi.Pointer<CDatabaseUniverseCursor>,
          DatabaseUniverseI64,
          ffi.Pointer<CDatabaseUniverseReader>)>()
  external ffi.Pointer<CDatabaseUniverseReader> database_universe_cursor_next(
    ffi.Pointer<CDatabaseUniverseCursor> cursor,
    int id,
    ffi.Pointer<CDatabaseUniverseReader> old_reader,
  );

  @ffi.Native<
      ffi.Void Function(ffi.Pointer<CDatabaseUniverseCursor>,
          ffi.Pointer<CDatabaseUniverseReader>)>()
  external void database_universe_cursor_free(
    ffi.Pointer<CDatabaseUniverseCursor> cursor,
    ffi.Pointer<CDatabaseUniverseReader> reader,
  );

  @ffi.Native<
      ffi.Pointer<CDatabaseUniverseReader> Function(
          ffi.Pointer<CDatabaseUniverseQueryCursor>,
          ffi.Pointer<CDatabaseUniverseReader>)>()
  external ffi.Pointer<CDatabaseUniverseReader>
      database_universe_query_cursor_next(
    ffi.Pointer<CDatabaseUniverseQueryCursor> cursor,
    ffi.Pointer<CDatabaseUniverseReader> old_reader,
  );

  @ffi.Native<
      ffi.Void Function(ffi.Pointer<CDatabaseUniverseQueryCursor>,
          ffi.Pointer<CDatabaseUniverseReader>)>()
  external void database_universe_query_cursor_free(
    ffi.Pointer<CDatabaseUniverseQueryCursor> cursor,
    ffi.Pointer<CDatabaseUniverseReader> reader,
  );

  @ffi.Native<ffi.Void Function(ffi.Pointer<ffi.Void>)>()
  external void database_universe_connect_dart_api(
    ffi.Pointer<ffi.Void> ptr,
  );

  @ffi.Native<ffi.Pointer<CFilter> Function(ffi.Uint16)>()
  external ffi.Pointer<CFilter> database_universe_filter_is_null(
    int property_index,
  );

  @ffi.Native<
      ffi.Pointer<CFilter> Function(
          ffi.Uint16, ffi.Pointer<CDatabaseUniverseValue>, ffi.Bool)>()
  external ffi.Pointer<CFilter> database_universe_filter_equal(
    int property_index,
    ffi.Pointer<CDatabaseUniverseValue> value,
    bool case_sensitive,
  );

  @ffi.Native<
      ffi.Pointer<CFilter> Function(
          ffi.Uint16, ffi.Pointer<CDatabaseUniverseValue>, ffi.Bool)>()
  external ffi.Pointer<CFilter> database_universe_filter_greater(
    int property_index,
    ffi.Pointer<CDatabaseUniverseValue> value,
    bool case_sensitive,
  );

  @ffi.Native<
      ffi.Pointer<CFilter> Function(
          ffi.Uint16, ffi.Pointer<CDatabaseUniverseValue>, ffi.Bool)>()
  external ffi.Pointer<CFilter> database_universe_filter_greater_or_equal(
    int property_index,
    ffi.Pointer<CDatabaseUniverseValue> value,
    bool case_sensitive,
  );

  @ffi.Native<
      ffi.Pointer<CFilter> Function(
          ffi.Uint16, ffi.Pointer<CDatabaseUniverseValue>, ffi.Bool)>()
  external ffi.Pointer<CFilter> database_universe_filter_less(
    int property_index,
    ffi.Pointer<CDatabaseUniverseValue> value,
    bool case_sensitive,
  );

  @ffi.Native<
      ffi.Pointer<CFilter> Function(
          ffi.Uint16, ffi.Pointer<CDatabaseUniverseValue>, ffi.Bool)>()
  external ffi.Pointer<CFilter> database_universe_filter_less_or_equal(
    int property_index,
    ffi.Pointer<CDatabaseUniverseValue> value,
    bool case_sensitive,
  );

  @ffi.Native<
      ffi.Pointer<CFilter> Function(
          ffi.Uint16,
          ffi.Pointer<CDatabaseUniverseValue>,
          ffi.Pointer<CDatabaseUniverseValue>,
          ffi.Bool)>()
  external ffi.Pointer<CFilter> database_universe_filter_between(
    int property_index,
    ffi.Pointer<CDatabaseUniverseValue> lower,
    ffi.Pointer<CDatabaseUniverseValue> upper,
    bool case_sensitive,
  );

  @ffi.Native<
      ffi.Pointer<CFilter> Function(
          ffi.Uint16, ffi.Pointer<CDatabaseUniverseValue>, ffi.Bool)>()
  external ffi.Pointer<CFilter> database_universe_filter_string_starts_with(
    int property_index,
    ffi.Pointer<CDatabaseUniverseValue> value,
    bool case_sensitive,
  );

  @ffi.Native<
      ffi.Pointer<CFilter> Function(
          ffi.Uint16, ffi.Pointer<CDatabaseUniverseValue>, ffi.Bool)>()
  external ffi.Pointer<CFilter> database_universe_filter_string_ends_with(
    int property_index,
    ffi.Pointer<CDatabaseUniverseValue> value,
    bool case_sensitive,
  );

  @ffi.Native<
      ffi.Pointer<CFilter> Function(
          ffi.Uint16, ffi.Pointer<CDatabaseUniverseValue>, ffi.Bool)>()
  external ffi.Pointer<CFilter> database_universe_filter_string_contains(
    int property_index,
    ffi.Pointer<CDatabaseUniverseValue> value,
    bool case_sensitive,
  );

  @ffi.Native<
      ffi.Pointer<CFilter> Function(
          ffi.Uint16, ffi.Pointer<CDatabaseUniverseValue>, ffi.Bool)>()
  external ffi.Pointer<CFilter> database_universe_filter_string_matches(
    int property_index,
    ffi.Pointer<CDatabaseUniverseValue> value,
    bool case_sensitive,
  );

  @ffi.Native<ffi.Pointer<CFilter> Function(ffi.Uint16, ffi.Pointer<CFilter>)>()
  external ffi.Pointer<CFilter> database_universe_filter_nested(
    int property_index,
    ffi.Pointer<CFilter> filter,
  );

  @ffi.Native<
      ffi.Pointer<CFilter> Function(
          ffi.Pointer<ffi.Pointer<CFilter>>, ffi.Uint32)>()
  external ffi.Pointer<CFilter> database_universe_filter_and(
    ffi.Pointer<ffi.Pointer<CFilter>> filters,
    int lenght,
  );

  @ffi.Native<
      ffi.Pointer<CFilter> Function(
          ffi.Pointer<ffi.Pointer<CFilter>>, ffi.Uint32)>()
  external ffi.Pointer<CFilter> database_universe_filter_or(
    ffi.Pointer<ffi.Pointer<CFilter>> filters,
    int lenght,
  );

  @ffi.Native<ffi.Pointer<CFilter> Function(ffi.Pointer<CFilter>)>()
  external ffi.Pointer<CFilter> database_universe_filter_not(
    ffi.Pointer<CFilter> filter,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>,
          ffi.Uint16,
          ffi.Uint32,
          ffi.Pointer<ffi.Pointer<CDatabaseUniverseWriter>>)>()
  external int database_universe_insert(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
    int collection_index,
    int count,
    ffi.Pointer<ffi.Pointer<CDatabaseUniverseWriter>> insert,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseWriter>, DatabaseUniverseI64)>()
  external int database_universe_insert_save(
    ffi.Pointer<CDatabaseUniverseWriter> insert,
    int id,
  );

  @ffi.Native<
      ffi.Uint8 Function(ffi.Pointer<CDatabaseUniverseWriter>,
          ffi.Pointer<ffi.Pointer<CDatabaseUniverseTxn>>)>()
  external int database_universe_insert_finish(
    ffi.Pointer<CDatabaseUniverseWriter> insert,
    ffi.Pointer<ffi.Pointer<CDatabaseUniverseTxn>> txn,
  );

  @ffi.Native<ffi.Void Function(ffi.Pointer<CDatabaseUniverseWriter>)>()
  external void database_universe_insert_abort(
    ffi.Pointer<CDatabaseUniverseWriter> insert,
  );

  @ffi.Native<ffi.Pointer<ffi.Char> Function()>()
  external ffi.Pointer<ffi.Char> database_universe_version();

  @ffi.Native<
      ffi.Pointer<CDatabaseUniverseInstance> Function(ffi.Uint32, ffi.Bool)>()
  external ffi.Pointer<CDatabaseUniverseInstance>
      database_universe_get_instance(
    int instance_id,
    bool sqlite,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<ffi.Pointer<CDatabaseUniverseInstance>>,
          ffi.Uint32,
          ffi.Pointer<CString>,
          ffi.Pointer<CString>,
          ffi.Bool,
          ffi.Pointer<CString>,
          ffi.Uint32,
          ffi.Pointer<CString>,
          ffi.Uint32,
          ffi.Uint32,
          ffi.Float)>()
  external int database_universe_open_instance(
    ffi.Pointer<ffi.Pointer<CDatabaseUniverseInstance>> database_universe,
    int instance_id,
    ffi.Pointer<CString> name,
    ffi.Pointer<CString> path,
    bool sqlite,
    ffi.Pointer<CString> schema_json,
    int max_size_mib,
    ffi.Pointer<CString> encryption_key,
    int compact_min_file_size,
    int compact_min_bytes,
    double compact_min_ratio,
  );

  @ffi.Native<
      ffi.Uint32 Function(ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<ffi.Pointer<ffi.Uint8>>)>()
  external int database_universe_get_name(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<ffi.Pointer<ffi.Uint8>> name,
  );

  @ffi.Native<
      ffi.Uint32 Function(ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<ffi.Pointer<ffi.Uint8>>)>()
  external int database_universe_get_dir(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<ffi.Pointer<ffi.Uint8>> dir,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseInstance>, ffi.Pointer<CString>)>()
  external int database_universe_change_encryption_key(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CString> encryption_key,
  );

  @ffi.Native<
      ffi.Uint8 Function(ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<ffi.Pointer<CDatabaseUniverseTxn>>, ffi.Bool)>()
  external int database_universe_txn_begin(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<ffi.Pointer<CDatabaseUniverseTxn>> txn,
    bool write,
  );

  @ffi.Native<
      ffi.Uint8 Function(ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>)>()
  external int database_universe_txn_commit(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
  );

  @ffi.Native<
      ffi.Void Function(ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>)>()
  external void database_universe_txn_abort(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
  );

  @ffi.Native<
      DatabaseUniverseI64 Function(
          ffi.Pointer<CDatabaseUniverseInstance>, ffi.Uint16)>()
  external int database_universe_auto_increment(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    int collection_index,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>,
          ffi.Uint16,
          ffi.Pointer<ffi.Pointer<CDatabaseUniverseCursor>>)>()
  external int database_universe_cursor(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
    int collection_index,
    ffi.Pointer<ffi.Pointer<CDatabaseUniverseCursor>> cursor,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>,
          ffi.Uint16,
          DatabaseUniverseI64,
          ffi.Pointer<ffi.Bool>)>()
  external int database_universe_delete(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
    int collection_index,
    int id,
    ffi.Pointer<ffi.Bool> deleted,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>,
          ffi.Uint16,
          ffi.Pointer<ffi.Uint32>)>()
  external int database_universe_count(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
    int collection_index,
    ffi.Pointer<ffi.Uint32> count,
  );

  @ffi.Native<
      ffi.Uint8 Function(ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>, ffi.Uint16)>()
  external int database_universe_clear(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
    int collection_index,
  );

  @ffi.Native<
      ffi.Uint32 Function(ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>, ffi.Uint16, ffi.Bool)>()
  external int database_universe_get_size(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
    int collection_index,
    bool include_indexes,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<ffi.Pointer<CDatabaseUniverseTxn>>,
          ffi.Uint16,
          ffi.Pointer<CString>,
          ffi.Pointer<ffi.Uint32>)>()
  external int database_universe_import_json(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<ffi.Pointer<CDatabaseUniverseTxn>> txn,
    int collection_index,
    ffi.Pointer<CString> json,
    ffi.Pointer<ffi.Uint32> count,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseInstance>, ffi.Pointer<CString>)>()
  external int database_universe_copy(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CString> path,
  );

  @ffi.Native<
      ffi.Uint8 Function(ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>)>()
  external int database_universe_verify(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
  );

  @ffi.Native<
      ffi.Uint8 Function(ffi.Pointer<CDatabaseUniverseInstance>, ffi.Bool)>()
  external int database_universe_close(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    bool delete_,
  );

  @ffi.Native<
      ffi.Uint8 Function(ffi.Pointer<CDatabaseUniverseInstance>, ffi.Uint16,
          ffi.Pointer<ffi.Pointer<CDatabaseUniverseQueryBuilder>>)>()
  external int database_universe_query_new(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    int collection_index,
    ffi.Pointer<ffi.Pointer<CDatabaseUniverseQueryBuilder>> query_builder,
  );

  @ffi.Native<
      ffi.Void Function(
          ffi.Pointer<CDatabaseUniverseQueryBuilder>, ffi.Pointer<CFilter>)>()
  external void database_universe_query_set_filter(
    ffi.Pointer<CDatabaseUniverseQueryBuilder> builder,
    ffi.Pointer<CFilter> filter,
  );

  @ffi.Native<
      ffi.Void Function(ffi.Pointer<CDatabaseUniverseQueryBuilder>, ffi.Uint16,
          ffi.Bool, ffi.Bool)>()
  external void database_universe_query_add_sort(
    ffi.Pointer<CDatabaseUniverseQueryBuilder> builder,
    int property_index,
    bool ascending,
    bool case_sensitive,
  );

  @ffi.Native<
      ffi.Void Function(
          ffi.Pointer<CDatabaseUniverseQueryBuilder>, ffi.Uint16, ffi.Bool)>()
  external void database_universe_query_add_distinct(
    ffi.Pointer<CDatabaseUniverseQueryBuilder> builder,
    int property_index,
    bool case_sensitive,
  );

  @ffi.Native<
      ffi.Pointer<CDatabaseUniverseQuery> Function(
          ffi.Pointer<CDatabaseUniverseQueryBuilder>)>()
  external ffi.Pointer<CDatabaseUniverseQuery> database_universe_query_build(
    ffi.Pointer<CDatabaseUniverseQueryBuilder> builder,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>,
          ffi.Pointer<CDatabaseUniverseQuery>,
          ffi.Pointer<ffi.Pointer<CDatabaseUniverseQueryCursor>>,
          ffi.Uint32,
          ffi.Uint32)>()
  external int database_universe_query_cursor(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
    ffi.Pointer<CDatabaseUniverseQuery> query,
    ffi.Pointer<ffi.Pointer<CDatabaseUniverseQueryCursor>> cursor,
    int offset,
    int limit,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>,
          ffi.Pointer<CDatabaseUniverseQuery>,
          ffi.Uint8,
          ffi.Uint16,
          ffi.Pointer<ffi.Pointer<CDatabaseUniverseValue>>)>()
  external int database_universe_query_aggregate(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
    ffi.Pointer<CDatabaseUniverseQuery> query,
    int aggregation,
    int property_index,
    ffi.Pointer<ffi.Pointer<CDatabaseUniverseValue>> value,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>,
          ffi.Pointer<CDatabaseUniverseQuery>,
          ffi.Uint32,
          ffi.Uint32,
          ffi.Pointer<ffi.Uint32>)>()
  external int database_universe_query_delete(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
    ffi.Pointer<CDatabaseUniverseQuery> query,
    int offset,
    int limit,
    ffi.Pointer<ffi.Uint32> count,
  );

  @ffi.Native<ffi.Void Function(ffi.Pointer<CDatabaseUniverseQuery>)>()
  external void database_universe_query_free(
    ffi.Pointer<CDatabaseUniverseQuery> query,
  );

  @ffi.Native<
      DatabaseUniverseI64 Function(ffi.Pointer<CDatabaseUniverseReader>)>()
  external int database_universe_read_id(
    ffi.Pointer<CDatabaseUniverseReader> reader,
  );

  @ffi.Native<
      ffi.Uint8 Function(ffi.Pointer<CDatabaseUniverseReader>, ffi.Uint32)>()
  external int database_universe_read_null(
    ffi.Pointer<CDatabaseUniverseReader> reader,
    int index,
  );

  @ffi.Native<
      ffi.Uint8 Function(ffi.Pointer<CDatabaseUniverseReader>, ffi.Uint32)>()
  external int database_universe_read_bool(
    ffi.Pointer<CDatabaseUniverseReader> reader,
    int index,
  );

  @ffi.Native<
      ffi.Uint8 Function(ffi.Pointer<CDatabaseUniverseReader>, ffi.Uint32)>()
  external int database_universe_read_byte(
    ffi.Pointer<CDatabaseUniverseReader> reader,
    int index,
  );

  @ffi.Native<
      ffi.Int32 Function(ffi.Pointer<CDatabaseUniverseReader>, ffi.Uint32)>()
  external int database_universe_read_int(
    ffi.Pointer<CDatabaseUniverseReader> reader,
    int index,
  );

  @ffi.Native<
      ffi.Float Function(ffi.Pointer<CDatabaseUniverseReader>, ffi.Uint32)>()
  external double database_universe_read_float(
    ffi.Pointer<CDatabaseUniverseReader> reader,
    int index,
  );

  @ffi.Native<
      DatabaseUniverseI64 Function(
          ffi.Pointer<CDatabaseUniverseReader>, ffi.Uint32)>()
  external int database_universe_read_long(
    ffi.Pointer<CDatabaseUniverseReader> reader,
    int index,
  );

  @ffi.Native<
      ffi.Double Function(ffi.Pointer<CDatabaseUniverseReader>, ffi.Uint32)>()
  external double database_universe_read_double(
    ffi.Pointer<CDatabaseUniverseReader> reader,
    int index,
  );

  @ffi.Native<
      ffi.Uint32 Function(ffi.Pointer<CDatabaseUniverseReader>, ffi.Uint32,
          ffi.Pointer<ffi.Pointer<ffi.Uint8>>, ffi.Pointer<ffi.Bool>)>()
  external int database_universe_read_string(
    ffi.Pointer<CDatabaseUniverseReader> reader,
    int index,
    ffi.Pointer<ffi.Pointer<ffi.Uint8>> value,
    ffi.Pointer<ffi.Bool> is_ascii,
  );

  @ffi.Native<
      ffi.Pointer<CDatabaseUniverseReader> Function(
          ffi.Pointer<CDatabaseUniverseReader>, ffi.Uint32)>()
  external ffi.Pointer<CDatabaseUniverseReader> database_universe_read_object(
    ffi.Pointer<CDatabaseUniverseReader> reader,
    int index,
  );

  @ffi.Native<
      ffi.Uint32 Function(ffi.Pointer<CDatabaseUniverseReader>, ffi.Uint32,
          ffi.Pointer<ffi.Pointer<CDatabaseUniverseReader>>)>()
  external int database_universe_read_list(
    ffi.Pointer<CDatabaseUniverseReader> reader,
    int index,
    ffi.Pointer<ffi.Pointer<CDatabaseUniverseReader>> list_reader,
  );

  @ffi.Native<
      ffi.Uint32 Function(ffi.Pointer<CDatabaseUniverseReader>,
          ffi.Pointer<ffi.Pointer<ffi.Uint8>>, ffi.Pointer<ffi.Uint32>)>()
  external int database_universe_read_to_json(
    ffi.Pointer<CDatabaseUniverseReader> reader,
    ffi.Pointer<ffi.Pointer<ffi.Uint8>> buffer,
    ffi.Pointer<ffi.Uint32> buffer_size,
  );

  @ffi.Native<ffi.Void Function(ffi.Pointer<CDatabaseUniverseReader>)>()
  external void database_universe_read_free(
    ffi.Pointer<CDatabaseUniverseReader> reader,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>,
          ffi.Uint16,
          DatabaseUniverseI64,
          ffi.Pointer<CDatabaseUniverseUpdate>,
          ffi.Pointer<ffi.Bool>)>()
  external int database_universe_update(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
    int collection_index,
    int id,
    ffi.Pointer<CDatabaseUniverseUpdate> update,
    ffi.Pointer<ffi.Bool> updated,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseTxn>,
          ffi.Pointer<CDatabaseUniverseQuery>,
          ffi.Uint32,
          ffi.Uint32,
          ffi.Pointer<CDatabaseUniverseUpdate>,
          ffi.Pointer<ffi.Uint32>)>()
  external int database_universe_query_update(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseTxn> txn,
    ffi.Pointer<CDatabaseUniverseQuery> query,
    int offset,
    int limit,
    ffi.Pointer<CDatabaseUniverseUpdate> update,
    ffi.Pointer<ffi.Uint32> updated,
  );

  @ffi.Native<ffi.Pointer<CDatabaseUniverseUpdate> Function()>()
  external ffi.Pointer<CDatabaseUniverseUpdate> database_universe_update_new();

  @ffi.Native<
      ffi.Void Function(ffi.Pointer<CDatabaseUniverseUpdate>, ffi.Uint16,
          ffi.Pointer<CDatabaseUniverseValue>)>()
  external void database_universe_update_add_value(
    ffi.Pointer<CDatabaseUniverseUpdate> update,
    int property_index,
    ffi.Pointer<CDatabaseUniverseValue> value,
  );

  @ffi.Native<ffi.Pointer<CDatabaseUniverseValue> Function(ffi.Bool)>()
  external ffi.Pointer<CDatabaseUniverseValue> database_universe_value_bool(
    bool value,
  );

  @ffi.Native<
      ffi.Pointer<CDatabaseUniverseValue> Function(DatabaseUniverseI64)>()
  external ffi.Pointer<CDatabaseUniverseValue> database_universe_value_integer(
    int value,
  );

  @ffi.Native<ffi.Pointer<CDatabaseUniverseValue> Function(ffi.Double)>()
  external ffi.Pointer<CDatabaseUniverseValue> database_universe_value_real(
    double value,
  );

  @ffi.Native<
      ffi.Pointer<CDatabaseUniverseValue> Function(ffi.Pointer<CString>)>()
  external ffi.Pointer<CDatabaseUniverseValue> database_universe_value_string(
    ffi.Pointer<CString> value,
  );

  @ffi.Native<ffi.Uint8 Function(ffi.Pointer<CDatabaseUniverseValue>)>()
  external int database_universe_value_get_bool(
    ffi.Pointer<CDatabaseUniverseValue> value,
  );

  @ffi.Native<
      DatabaseUniverseI64 Function(ffi.Pointer<CDatabaseUniverseValue>)>()
  external int database_universe_value_get_integer(
    ffi.Pointer<CDatabaseUniverseValue> value,
  );

  @ffi.Native<ffi.Double Function(ffi.Pointer<CDatabaseUniverseValue>)>()
  external double database_universe_value_get_real(
    ffi.Pointer<CDatabaseUniverseValue> value,
  );

  @ffi.Native<
      ffi.Uint32 Function(ffi.Pointer<CDatabaseUniverseValue>,
          ffi.Pointer<ffi.Pointer<ffi.Uint8>>)>()
  external int database_universe_value_get_string(
    ffi.Pointer<CDatabaseUniverseValue> value,
    ffi.Pointer<ffi.Pointer<ffi.Uint8>> str,
  );

  @ffi.Native<ffi.Void Function(ffi.Pointer<CDatabaseUniverseValue>)>()
  external void database_universe_value_free(
    ffi.Pointer<CDatabaseUniverseValue> value,
  );

  @ffi.Native<
      ffi.Uint8 Function(ffi.Pointer<CDatabaseUniverseInstance>, ffi.Uint16,
          DartPort, ffi.Pointer<ffi.Pointer<CWatchHandle>>)>()
  external int database_universe_watch_collection(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    int collection_index,
    int port,
    ffi.Pointer<ffi.Pointer<CWatchHandle>> handle,
  );

  @ffi.Native<
      ffi.Uint8 Function(ffi.Pointer<CDatabaseUniverseInstance>, ffi.Uint16,
          ffi.Int64, DartPort, ffi.Pointer<ffi.Pointer<CWatchHandle>>)>()
  external int database_universe_watch_object(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    int collection_index,
    int id,
    int port,
    ffi.Pointer<ffi.Pointer<CWatchHandle>> handle,
  );

  @ffi.Native<
      ffi.Uint8 Function(
          ffi.Pointer<CDatabaseUniverseInstance>,
          ffi.Pointer<CDatabaseUniverseQuery>,
          DartPort,
          ffi.Pointer<ffi.Pointer<CWatchHandle>>)>()
  external int database_universe_watch_query(
    ffi.Pointer<CDatabaseUniverseInstance> database_universe,
    ffi.Pointer<CDatabaseUniverseQuery> query,
    int port,
    ffi.Pointer<ffi.Pointer<CWatchHandle>> handle,
  );

  @ffi.Native<ffi.Void Function(ffi.Pointer<CWatchHandle>)>()
  external void database_universe_stop_watching(
    ffi.Pointer<CWatchHandle> handle,
  );

  @ffi.Native<
      ffi.Void Function(ffi.Pointer<CDatabaseUniverseWriter>, ffi.Uint32)>()
  external void database_universe_write_null(
    ffi.Pointer<CDatabaseUniverseWriter> writer,
    int index,
  );

  @ffi.Native<
      ffi.Void Function(
          ffi.Pointer<CDatabaseUniverseWriter>, ffi.Uint32, ffi.Bool)>()
  external void database_universe_write_bool(
    ffi.Pointer<CDatabaseUniverseWriter> writer,
    int index,
    bool value,
  );

  @ffi.Native<
      ffi.Void Function(
          ffi.Pointer<CDatabaseUniverseWriter>, ffi.Uint32, ffi.Uint8)>()
  external void database_universe_write_byte(
    ffi.Pointer<CDatabaseUniverseWriter> writer,
    int index,
    int value,
  );

  @ffi.Native<
      ffi.Void Function(
          ffi.Pointer<CDatabaseUniverseWriter>, ffi.Uint32, ffi.Int32)>()
  external void database_universe_write_int(
    ffi.Pointer<CDatabaseUniverseWriter> writer,
    int index,
    int value,
  );

  @ffi.Native<
      ffi.Void Function(
          ffi.Pointer<CDatabaseUniverseWriter>, ffi.Uint32, ffi.Float)>()
  external void database_universe_write_float(
    ffi.Pointer<CDatabaseUniverseWriter> writer,
    int index,
    double value,
  );

  @ffi.Native<
      ffi.Void Function(ffi.Pointer<CDatabaseUniverseWriter>, ffi.Uint32,
          DatabaseUniverseI64)>()
  external void database_universe_write_long(
    ffi.Pointer<CDatabaseUniverseWriter> writer,
    int index,
    int value,
  );

  @ffi.Native<
      ffi.Void Function(
          ffi.Pointer<CDatabaseUniverseWriter>, ffi.Uint32, ffi.Double)>()
  external void database_universe_write_double(
    ffi.Pointer<CDatabaseUniverseWriter> writer,
    int index,
    double value,
  );

  @ffi.Native<
      ffi.Void Function(ffi.Pointer<CDatabaseUniverseWriter>, ffi.Uint32,
          ffi.Pointer<CString>)>()
  external void database_universe_write_string(
    ffi.Pointer<CDatabaseUniverseWriter> writer,
    int index,
    ffi.Pointer<CString> value,
  );

  @ffi.Native<
      ffi.Void Function(ffi.Pointer<CDatabaseUniverseWriter>, ffi.Uint32,
          ffi.Pointer<ffi.Uint8>, ffi.Uint32)>()
  external void database_universe_write_byte_list(
    ffi.Pointer<CDatabaseUniverseWriter> writer,
    int index,
    ffi.Pointer<ffi.Uint8> value,
    int length,
  );

  @ffi.Native<
      ffi.Pointer<CDatabaseUniverseWriter> Function(
          ffi.Pointer<CDatabaseUniverseWriter>, ffi.Uint32)>()
  external ffi.Pointer<CDatabaseUniverseWriter> database_universe_write_object(
    ffi.Pointer<CDatabaseUniverseWriter> writer,
    int index,
  );

  @ffi.Native<
      ffi.Void Function(ffi.Pointer<CDatabaseUniverseWriter>,
          ffi.Pointer<CDatabaseUniverseWriter>)>()
  external void database_universe_write_object_end(
    ffi.Pointer<CDatabaseUniverseWriter> writer,
    ffi.Pointer<CDatabaseUniverseWriter> embedded_writer,
  );

  @ffi.Native<
      ffi.Pointer<CDatabaseUniverseWriter> Function(
          ffi.Pointer<CDatabaseUniverseWriter>, ffi.Uint32, ffi.Uint32)>()
  external ffi.Pointer<CDatabaseUniverseWriter> database_universe_write_list(
    ffi.Pointer<CDatabaseUniverseWriter> writer,
    int index,
    int length,
  );

  @ffi.Native<
      ffi.Void Function(ffi.Pointer<CDatabaseUniverseWriter>,
          ffi.Pointer<CDatabaseUniverseWriter>)>()
  external void database_universe_write_list_end(
    ffi.Pointer<CDatabaseUniverseWriter> writer,
    ffi.Pointer<CDatabaseUniverseWriter> list_writer,
  );
}

final class CDatabaseUniverseCursor extends ffi.Opaque {}

final class CDatabaseUniverseInstance extends ffi.Opaque {}

final class CDatabaseUniverseQuery extends ffi.Opaque {}

final class CDatabaseUniverseQueryBuilder extends ffi.Opaque {}

final class CDatabaseUniverseReader extends ffi.Opaque {}

final class CDatabaseUniverseTxn extends ffi.Opaque {}

final class CDatabaseUniverseWriter extends ffi.Opaque {}

final class CDatabaseUniverseValue extends ffi.Opaque {}

final class CString extends ffi.Opaque {}

typedef DatabaseUniverseI64 = ffi.Int64;
typedef DartDatabaseUniverseI64 = int;

final class CDatabaseUniverseQueryCursor extends ffi.Opaque {}

final class CFilter extends ffi.Opaque {}

final class CDatabaseUniverseUpdate extends ffi.Opaque {}

typedef DartPort = ffi.Int64;
typedef DartDartPort = int;

final class CWatchHandle extends ffi.Opaque {}

const int ERROR_PATH = 1;

const int ERROR_WRITE_TXN_REQUIRED = 2;

const int ERROR_VERSION = 3;

const int ERROR_OBJECT_LIMIT_REACHED = 4;

const int ERROR_INSTANCE_MISMATCH = 5;

const int ERROR_ENCRYPTION = 6;

const int ERROR_DB_FULL = 7;

const int AGGREGATION_COUNT = 0;

const int AGGREGATION_IS_EMPTY = 1;

const int AGGREGATION_MIN = 2;

const int AGGREGATION_MAX = 3;

const int AGGREGATION_SUM = 4;

const int AGGREGATION_AVERAGE = 5;
