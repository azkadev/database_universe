// ignore_for_file: public_member_api_docs

part of database_universe_generator;

class ObjectInfo {
  const ObjectInfo({
    required this.dartName,
    required this.database_universeName,
    required this.properties,
    this.indexes = const [],
    this.accessor,
    this.embeddedDartNames = const {},
  });

  final String dartName;
  final String database_universeName;
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
    required this.database_universeName,
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
  final String database_universeName;
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
