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
/// Extremely fast, easy to use, and fully async NoSQL database for Flutter.
library;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:database_universe/core/core/database_universe_connect_api.dart';
import 'package:database_universe/core/core/native/native.dart'
    if (dart.library.js) 'package:database_universe/core/core/web/web.dart'
    if (dart.library.js_interop) 'package:database_universe/core/core/wasm/wasm.dart';
import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

part 'core/annotations/collection.dart';
part 'core/annotations/embedded.dart';
part 'core/annotations/enum_value.dart';
part 'core/annotations/id.dart';
part 'core/annotations/ignore.dart';
part 'core/annotations/index.dart';
part 'core/annotations/name.dart';
part 'core/annotations/type.dart';
part 'core/annotations/utc.dart';

part 'core/compact_condition.dart';

part 'core/impl/filter_builder.dart';
part 'core/impl/database_universe_collection_impl.dart';
part 'core/impl/database_universe_impl.dart';
part 'core/impl/database_universe_query_impl.dart';
part 'core/impl/native_error.dart';

part 'core/database_universe.dart';
part 'core/database_universe_collection.dart';
part 'core/database_universe_connect.dart';
part 'core/database_universe_core.dart';
part 'core/database_universe_error.dart';
part 'core/database_universe_generated_schema.dart';
part 'core/database_universe_query.dart';
part 'core/database_universe_schema.dart';

part 'core/query_builder.dart';
part 'core/query_components.dart';
part 'core/query_extensions.dart';

/// @nodoc
@protected
const databaseUniverseProtected = protected;

/// @nodoc
@protected
const databaseUniverseJsonEncode = jsonEncode;

/// @nodoc
@protected
const databaseUniverseJsonDecode = jsonDecode;
