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
library;

import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:database_universe/database_universe.dart';
import 'package:source_gen/source_gen.dart';

part 'code_gen/collection_schema_generator.dart';
part 'code_gen/deserialize_generator.dart';
part 'code_gen/enum_maps_generator.dart';
part 'code_gen/query_distinct_by_generator.dart';
part 'code_gen/query_filter_generator.dart';
part 'code_gen/query_object_generator.dart';
part 'code_gen/query_property_generator.dart';
part 'code_gen/query_sort_by_generator.dart';
part 'code_gen/serialize_generator.dart';
part 'code_gen/update_generator.dart';
part 'collection_generator.dart';
part 'helper.dart';
part 'database_universe_analyzer.dart';
part 'database_universe_type.dart';
part 'object_info.dart';
part 'reserved_names.dart';

const _nullInt = -2147483648;
const _nullLong = -9223372036854775808;

/// Generates the database_universe code for the annotated classes.
Builder getDatabaseUniverseGenerator(BuilderOptions options) =>
    SharedPartBuilder(
      [
        _DatabaseUniverseCollectionGenerator(),
        _DatabaseUniverseEmbeddedGenerator(),
      ],
      'database_universe_generator',
    );
