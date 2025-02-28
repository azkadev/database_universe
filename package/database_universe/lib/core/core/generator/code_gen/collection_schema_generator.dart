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

String _generateSchema(ObjectInfo object) {
  String generatePropertySchema(PropertyInfo p) {
    return '''
    DatabaseUniversePropertySchema(
      name: '${p.databaseUniverseName}',
      type: DatabaseUniverseType.${p.type.name},
      ${p.targetDatabaseUniverseName != null ? "target: '${p.targetDatabaseUniverseName}'," : ''}
      ${p.enumMap != null ? 'enumMap: ${jsonEncode(p.enumMap)},' : ''}
    ),''';
  }

  String generateIndexSchema(IndexInfo index) {
    return '''
    DatabaseUniverseIndexSchema(
      name: '${index.name}',
      properties: [${index.properties.map((e) => '"$e",').join()}],
      unique: ${index.unique},
      hash: ${index.hash},
    ),''';
  }

  final embeddedSchemas =
      object.embeddedDartNames.map((e) => '${e.capitalize()}Schema').join(',');
  final properties = object.properties
      .where((e) => !e.isId || e.type != DatabaseUniverseType.long)
      .map(generatePropertySchema)
      .join();
  final indexes = object.indexes.map(generateIndexSchema).join();
  return '''
    const ${object.dartName.capitalize()}Schema = DatabaseUniverseGeneratedSchema(
      schema: DatabaseUniverseSchema(
        name: '${object.databaseUniverseName}',
        ${object.idProperty != null ? "idName: '${object.idProperty!.databaseUniverseName}'," : ''}
        embedded: ${object.isEmbedded},
        properties: [$properties],
        indexes: [$indexes],
      ),
      converter: DatabaseUniverseObjectConverter<${object.idProperty?.dartType ?? 'void'}, ${object.dartName}>(
        serialize: serialize${object.dartName},
        deserialize: deserialize${object.dartName},
        ${!object.isEmbedded ? 'deserializeProperty: deserialize${object.dartName}Prop,' : ''}
      ),
      ${object.isEmbedded ? '' : 'embeddedSchemas: [$embeddedSchemas],'}
    );''';
}
