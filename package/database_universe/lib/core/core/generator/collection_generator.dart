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
part of "package:database_universe/core/core/generator/database_universe_generator.dart";

const _ignoreLints = [
  'duplicate_ignore',
  'invalid_use_of_protected_member',
  'lines_longer_than_80_chars',
  'constant_identifier_names',
  'avoid_js_rounded_ints',
  'no_leading_underscores_for_local_identifiers',
  'require_trailing_commas',
  'unnecessary_parenthesis',
  'unnecessary_raw_strings',
  'unnecessary_null_in_if_null_operators',
  'library_private_types_in_public_api',
  'prefer_const_constructors',
];

class _DatabaseUniverseCollectionGenerator
    extends GeneratorForAnnotation<Collection> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final object = _DatabaseUniverseAnalyzer().analyzeCollection(element);
    final idType = object.idProperty!.type == DatabaseUniverseType.string
        ? 'String'
        : 'int';
    return '''
      // coverage:ignore-file
      // ignore_for_file: ${_ignoreLints.join(', ')}
      

      extension Get${object.dartName}Collection on DatabaseUniverse {
        DatabaseUniverseCollection<$idType, ${object.dartName}> get ${object.accessor} => this.collection();
      }

      ${_generateSchema(object)}

      ${_generateSerialize(object)}

      ${_generateDeserialize(object)}

      ${_generateDeserializeProp(object)}

      ${_generateUpdate(object)}

      ${_generateEnumMaps(object)}

      ${_FilterGenerator(object).generate()}

      ${_generateQueryObjects(object)}

      ${_generateSortBy(object)}

      ${_generateDistinctBy(object)}
      
      ${_generatePropertyQuery(object)}
    ''';
  }
}

class _DatabaseUniverseEmbeddedGenerator
    extends GeneratorForAnnotation<Embedded> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    final object = _DatabaseUniverseAnalyzer().analyzeEmbedded(element);
    return '''
      // coverage:ignore-file
      // ignore_for_file: ${_ignoreLints.join(', ')}
      

      ${_generateSchema(object)}

      ${_generateSerialize(object)}

      ${_generateDeserialize(object)}

      ${_generateEnumMaps(object)}

      ${_FilterGenerator(object).generate()}

      ${_generateQueryObjects(object)}
    ''';
  }
}
