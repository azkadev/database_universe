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
// ignore_for_file: public_member_api_docs

part of "package:database_universe/core/core/generator/database_universe_generator.dart";

class ObjectInfo {
  const ObjectInfo({
    required this.dartName,
    required this.databaseUniverseName,
    required this.properties,
    this.indexes = const [],
    this.accessor,
    this.embeddedDartNames = const {},
  });

  final String dartName;
  final String databaseUniverseName;
  final String? accessor;
  final List<PropertyInfo> properties;
  final List<IndexInfo> indexes;
  final Set<String> embeddedDartNames;

  bool get isEmbedded => accessor == null;

  PropertyInfo? get idProperty => properties.where((it) => it.isId).firstOrNull;
}

enum DeserializeMode {
  none,
  assign,
  positionalParam,
  namedParam,
}

class PropertyInfo {
  PropertyInfo({
    required this.index,
    required this.dartName,
    required this.databaseUniverseName,
    required this.typeClassName,
    required this.targetDatabaseUniverseName,
    required this.type,
    required this.isId,
    required this.enumMap,
    required this.enumProperty,
    required this.nullable,
    required this.elementNullable,
    required this.defaultValue,
    required this.elementDefaultValue,
    required this.utc,
    required this.mode,
    required this.assignable,
    required this.constructorPosition,
  });

  final int index;

  final String dartName;
  final String databaseUniverseName;
  final String typeClassName;
  final String? targetDatabaseUniverseName;

  final DatabaseUniverseType type;
  final bool isId;
  final Map<String, dynamic>? enumMap;
  final String? enumProperty;

  final bool nullable;
  final bool? elementNullable;
  final String defaultValue;
  final String? elementDefaultValue;
  final bool utc;

  final DeserializeMode mode;
  final bool assignable;
  final int? constructorPosition;

  bool get isEnum => enumMap != null;

  String get scalarDartTypeNotNull {
    if (isEnum) {
      return typeClassName;
    }

    switch (type) {
      case DatabaseUniverseType.bool:
      case DatabaseUniverseType.boolList:
        return 'bool';
      case DatabaseUniverseType.byte:
      case DatabaseUniverseType.byteList:
      case DatabaseUniverseType.int:
      case DatabaseUniverseType.intList:
      case DatabaseUniverseType.long:
      case DatabaseUniverseType.longList:
        return 'int';
      case DatabaseUniverseType.float:
      case DatabaseUniverseType.floatList:
      case DatabaseUniverseType.double:
      case DatabaseUniverseType.doubleList:
        return 'double';
      case DatabaseUniverseType.dateTime:
      case DatabaseUniverseType.dateTimeList:
        return 'DateTime';
      case DatabaseUniverseType.duration:
      case DatabaseUniverseType.durationList:
        return 'Duration';
      case DatabaseUniverseType.object:
      case DatabaseUniverseType.objectList:
        return typeClassName;
      case DatabaseUniverseType.string:
      case DatabaseUniverseType.stringList:
        return 'String';
      case DatabaseUniverseType.json:
        if (typeClassName == 'List') {
          return 'List<dynamic>';
        } else if (typeClassName == 'Map') {
          return 'Map<String, dynamic>';
        } else {
          return 'dynamic';
        }
    }
  }

  String get scalarDartType {
    final sNN = scalarDartTypeNotNull;
    return type.isList
        ? '$sNN${elementNullable! && typeClassName != 'dynamic' ? '?' : ''}'
        : '$sNN${nullable && typeClassName != 'dynamic' ? '?' : ''}';
  }

  String get dartType => type.isList
      ? 'List<$scalarDartType>${nullable ? '?' : ''}'
      : scalarDartType;

  String enumMapName(ObjectInfo object) =>
      '_${object.dartName.decapitalize()}${dartName.capitalize()}';
}

class IndexInfo {
  IndexInfo({
    required this.name,
    required this.properties,
    required this.unique,
    required this.hash,
  });

  final String name;
  final List<String> properties;
  final bool unique;
  final bool hash;
}
