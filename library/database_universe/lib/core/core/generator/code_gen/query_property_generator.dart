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
// ignore_for_file: use_string_buffers

part of "package:database_universe/core/core/generator/database_universe_generator.dart";

String _generatePropertyQuery(ObjectInfo oi) {
  var code = '''
  extension ${oi.dartName}QueryProperty1 on QueryBuilder<${oi.dartName}, ${oi.dartName}, QProperty> {''';

  for (final property in oi.properties) {
    code += '''
      QueryBuilder<${oi.dartName}, ${property.dartType}, QAfterProperty>${property.dartName}Property() {
        return QueryBuilder.apply(this, (query) {
          return query.addProperty(${property.index});
        });
      }''';
  }

  code += '''
  }
  
  extension ${oi.dartName}QueryProperty2<R> on QueryBuilder<${oi.dartName}, R, QAfterProperty> {''';

  for (final property in oi.properties) {
    code += '''
      QueryBuilder<${oi.dartName}, (R, ${property.dartType}), QAfterProperty>${property.dartName}Property() {
        return QueryBuilder.apply(this, (query) {
          return query.addProperty(${property.index});
        });
      }''';
  }

  code += '''
  }
  
  extension ${oi.dartName}QueryProperty3<R1, R2> on QueryBuilder<${oi.dartName}, (R1, R2), QAfterProperty> {''';

  for (final property in oi.properties) {
    code += '''
      QueryBuilder<${oi.dartName}, (R1, R2, ${property.dartType}), QOperations>${property.dartName}Property() {
        return QueryBuilder.apply(this, (query) {
          return query.addProperty(${property.index});
        });
      }''';
  }

  return '$code}';
}
