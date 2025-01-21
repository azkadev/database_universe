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
import 'package:database_universe/database_universe.dart';

///
extension CollectionInfoX on DatabaseUniverseSchema {
  ///
  List<DatabaseUniversePropertySchema> get idAndProperties {
    final props = [
      if (!this.embedded && !properties.any((e) => e.name == idName))
        DatabaseUniversePropertySchema(
            name: idName!, type: DatabaseUniverseType.long),
      ...properties,
    ];
    props.sort((a, b) {
      if (a.name == idName) {
        return -1;
      } else if (b.name == idName) {
        return 1;
      } else {
        return a.name.compareTo(b.name);
      }
    });
    return props;
  }
}

///
extension TypeName on DatabaseUniverseType {
  ///
  String get typeName {
    switch (this) {
      case DatabaseUniverseType.bool:
        return 'bool';
      case DatabaseUniverseType.byte:
        return 'byte';
      case DatabaseUniverseType.int:
        return 'short';
      case DatabaseUniverseType.long:
        return 'int';
      case DatabaseUniverseType.float:
        return 'float';
      case DatabaseUniverseType.double:
        return 'double';
      case DatabaseUniverseType.dateTime:
        return 'DateTime';
      case DatabaseUniverseType.duration:
        return 'Duration';
      case DatabaseUniverseType.string:
        return 'String';
      case DatabaseUniverseType.object:
        return 'Object';
      case DatabaseUniverseType.json:
        return 'Json';
      case DatabaseUniverseType.boolList:
        return 'List<bool>';
      case DatabaseUniverseType.byteList:
        return 'List<byte>';
      case DatabaseUniverseType.intList:
        return 'List<short>';
      case DatabaseUniverseType.longList:
        return 'List<int>';
      case DatabaseUniverseType.floatList:
        return 'List<float>';
      case DatabaseUniverseType.doubleList:
        return 'List<double>';
      case DatabaseUniverseType.dateTimeList:
        return 'List<DateTime>';
      case DatabaseUniverseType.durationList:
        return 'List<Duration>';
      case DatabaseUniverseType.stringList:
        return 'List<String>';
      case DatabaseUniverseType.objectList:
        return 'List<Object>';
    }
  }
}
