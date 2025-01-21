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

String _generateSortBy(ObjectInfo oi) {
  final prefix = 'QueryBuilder<${oi.dartName}, ${oi.dartName}, QAfterSortBy>';

  var code = '''
  extension ${oi.dartName}QuerySortBy on QueryBuilder<${oi.dartName}, ${oi.dartName}, QSortBy> {''';

  for (final property in oi.properties) {
    if (property.type.isList || property.type.isObject) {
      continue;
    }

    final caseSensitiveParam =
        property.type.isString ? '{bool caseSensitive = true}' : '';
    final caseSensitiveArg =
        property.type.isString ? ', caseSensitive: caseSensitive,' : '';

    code += '''
    ${prefix}sortBy${property.dartName.capitalize()}($caseSensitiveParam) {
      return QueryBuilder.apply(this, (query) {
        return query.addSortBy(${property.index} $caseSensitiveArg);
      });
    }
    
    ${prefix}sortBy${property.dartName.capitalize()}Desc($caseSensitiveParam) {
      return QueryBuilder.apply(this, (query) {
        return query.addSortBy(${property.index}, sort: Sort.desc $caseSensitiveArg);
      });
    }''';
  }

  code += '''
  }

  extension ${oi.dartName}QuerySortThenBy on QueryBuilder<${oi.dartName}, ${oi.dartName}, QSortThenBy> {''';

  for (final property in oi.properties) {
    if (property.type.isList || property.type.isObject) {
      continue;
    }

    final caseSensitiveParam =
        property.type.isString ? '{bool caseSensitive = true}' : '';
    final caseSensitiveArg =
        property.type.isString ? ', caseSensitive: caseSensitive' : '';

    code += '''
    ${prefix}thenBy${property.dartName.capitalize()}($caseSensitiveParam) {
      return QueryBuilder.apply(this, (query) {
        return query.addSortBy(${property.index} $caseSensitiveArg);
      });
    }
    
    ${prefix}thenBy${property.dartName.capitalize()}Desc($caseSensitiveParam) {
      return QueryBuilder.apply(this, (query) {
        return query.addSortBy(${property.index}, sort: Sort.desc $caseSensitiveArg);
      });
    }''';
  }

  return '$code}';
}
