part of database_universe;

/// The schema of a collection in DatabaseUniverse.
///
/// This class represents the structure of a collection. This includes the
/// collection name, the properties and indexes.
class DatabaseUniverseSchema {
  /// @nodoc
  const DatabaseUniverseSchema({
    required this.name,
    this.idName,
    required this.embedded,
    required this.properties,
    required this.indexes,
  });

  /// @nodoc
  factory DatabaseUniverseSchema.fromJson(Map<String, dynamic> json) {
    return DatabaseUniverseSchema(
      name: json['name'] as String,
      idName: json['idName'] as String?,
      embedded: json['embedded'] as bool,
      properties: (json['properties'] as List<dynamic>)
          .map((e) => DatabaseUniversePropertySchema.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      indexes: (json['indexes'] as List<dynamic>)
          .map((e) =>
              DatabaseUniverseIndexSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// The name of the collection.
  final String name;

  /// The name of the id property. Only String id properties are defined
  /// in [properties].
  final String? idName;

  /// Whether this collection is embedded in another object.
  final bool embedded;

  /// The properties of this collection.
  final List<DatabaseUniversePropertySchema> properties;

  /// The indexes of this collection.
  final List<DatabaseUniverseIndexSchema> indexes;

  /// @nodoc
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'idName': idName,
      'embedded': embedded,
      'properties': properties.map((e) => e.toJson()).toList(),
      'indexes': indexes.map((e) => e.toJson()).toList(),
    };
  }

  /// Get the index of a property in this schema.
  int getPropertyIndex(String property) {
    for (var i = 0; i < properties.length; i++) {
      if (properties[i].name == property) {
        return i + 1;
      }
    }
    if (idName == property) {
      return 0;
    }
    throw ArgumentError('Property $property not found in schema $name');
  }

  /// Get the property schema by its index.
  DatabaseUniversePropertySchema getPropertyByIndex(int index) {
    if (index == 0) {
      return DatabaseUniversePropertySchema(
        name: idName!,
        type: DatabaseUniverseType.long,
      );
    } else {
      return properties[index - 1];
    }
  }
}

/// The schema of a property in DatabaseUniverse.
class DatabaseUniversePropertySchema {
  /// @nodoc
  const DatabaseUniversePropertySchema({
    required this.name,
    required this.type,
    this.target,
    this.enumMap,
  });

  /// @nodoc
  factory DatabaseUniversePropertySchema.fromJson(Map<String, dynamic> json) {
    return DatabaseUniversePropertySchema(
      name: json['name'] as String,
      type: DatabaseUniverseType.values.firstWhere(
        (e) => e.coreName == json['type'] as String,
      ),
      target: json['target'] as String?,
      enumMap: json['enumMap'] as Map<String, dynamic>?,
    );
  }

  /// The name of the property.
  final String name;

  /// The type of the property.
  final DatabaseUniverseType type;

  /// If this property contains object(s), this is the name of the embedded
  /// collection.
  final String? target;

  /// If this property is an enum, this map contains the enum values.
  final Map<String, dynamic>? enumMap;

  /// @nodoc
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type.coreName,
      if (target != null) 'target': target,
      if (enumMap != null) 'enumMap': enumMap,
    };
  }
}

/// The schema of an index in DatabaseUniverse.
class DatabaseUniverseIndexSchema {
  /// @nodoc
  const DatabaseUniverseIndexSchema({
    required this.name,
    required this.properties,
    required this.unique,
    required this.hash,
  });

  /// @nodoc
  factory DatabaseUniverseIndexSchema.fromJson(Map<String, dynamic> json) {
    return DatabaseUniverseIndexSchema(
      name: json['name'] as String,
      properties: (json['properties'] as List).cast(),
      unique: json['unique'] as bool,
      hash: json['hash'] as bool,
    );
  }

  /// The name of the index.
  final String name;

  /// The properties of the index.
  final List<String> properties;

  /// Whether this index is unique.
  final bool unique;

  /// Whether this index should be hashed.
  final bool hash;

  /// @nodoc
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'properties': properties,
      'unique': unique,
      'hash': hash,
    };
  }
}

/// Supported DatabaseUniverse property types.
enum DatabaseUniverseType {
  /// boolean (1 byte)
  bool('Bool'),

  /// unsigned 8 bit integer (1 byte)
  byte('Byte'),

  /// signed 32 bit integer (4 bytes)
  int('Int'),

  /// 32 bit floating point (4 bytes)
  float('Float'),

  /// signed 64 bit integer (8 bytes)
  long('Long'),

  /// 64 bit floating point (8 bytes)
  double('Double'),

  /// date and time stored in UTC (8 bytes)
  dateTime('DateTime'),

  /// duration
  duration('Duration'),

  /// string (6 + length bytes)
  string('String'),

  /// embedded object (6 + size bytes)
  object('Object'),

  /// json (6 + length bytes)
  json('Json'),

  /// list of booleans (6 + length bytes)
  boolList('BoolList'),

  /// list of unsigned 8 bit integers (6 + length bytes)
  byteList('ByteList'),

  /// list of signed 32 bit integers (6 + length * 4 bytes)
  intList('IntList'),

  /// list of 32 bit floating points (6 + length * 4 bytes)
  floatList('FloatList'),

  /// list of signed 64 bit integers (6 + length * 8 bytes)
  longList('LongList'),

  /// list of 64 bit floating points (6 + length * 8 bytes)
  doubleList('DoubleList'),

  /// list of dates and times stored in UTC (6 + length * 8 bytes)
  dateTimeList('DateTimeList'),

  /// list of durations
  durationList('DurationList'),

  /// list of strings (6 + length * (6 + length) bytes)
  stringList('StringList'),

  /// list of embedded objects (6 + length * (6 + size) bytes)
  objectList('ObjectList');

  const DatabaseUniverseType(this.coreName);

  /// @nodoc
  final String coreName;
}

/// @nodoc
extension DatabaseUniverseTypeX on DatabaseUniverseType {
  /// @nodoc
  bool get isBool =>
      this == DatabaseUniverseType.bool ||
      this == DatabaseUniverseType.boolList;

  /// @nodoc
  bool get isFloat =>
      this == DatabaseUniverseType.float ||
      this == DatabaseUniverseType.floatList ||
      this == DatabaseUniverseType.double ||
      this == DatabaseUniverseType.doubleList;

  /// @nodoc
  bool get isInt =>
      this == DatabaseUniverseType.int ||
      this == DatabaseUniverseType.int ||
      this == DatabaseUniverseType.long ||
      this == DatabaseUniverseType.longList ||
      this == DatabaseUniverseType.duration ||
      this == DatabaseUniverseType.durationList;

  /// @nodoc
  bool get isNum => isFloat || isInt;

  /// @nodoc
  bool get isDate =>
      this == DatabaseUniverseType.dateTime ||
      this == DatabaseUniverseType.dateTimeList;

  /// @nodoc
  bool get isString =>
      this == DatabaseUniverseType.string ||
      this == DatabaseUniverseType.stringList;

  /// @nodoc
  bool get isObject =>
      this == DatabaseUniverseType.object ||
      this == DatabaseUniverseType.objectList;

  /// @nodoc
  bool get isList => scalarType != this;

  /// @nodoc
  DatabaseUniverseType get scalarType {
    switch (this) {
      case DatabaseUniverseType.boolList:
        return DatabaseUniverseType.bool;
      case DatabaseUniverseType.byteList:
        return DatabaseUniverseType.byte;
      case DatabaseUniverseType.intList:
        return DatabaseUniverseType.int;
      case DatabaseUniverseType.floatList:
        return DatabaseUniverseType.float;
      case DatabaseUniverseType.longList:
        return DatabaseUniverseType.long;
      case DatabaseUniverseType.doubleList:
        return DatabaseUniverseType.double;
      case DatabaseUniverseType.dateTimeList:
        return DatabaseUniverseType.dateTime;
      case DatabaseUniverseType.durationList:
        return DatabaseUniverseType.duration;
      case DatabaseUniverseType.stringList:
        return DatabaseUniverseType.string;
      case DatabaseUniverseType.objectList:
        return DatabaseUniverseType.object;
      // ignore: no_default_cases
      default:
        return this;
    }
  }

  /// @nodoc
  DatabaseUniverseType get listType {
    switch (this) {
      case DatabaseUniverseType.bool:
        return DatabaseUniverseType.boolList;
      case DatabaseUniverseType.byte:
        return DatabaseUniverseType.byteList;
      case DatabaseUniverseType.int:
        return DatabaseUniverseType.intList;
      case DatabaseUniverseType.float:
        return DatabaseUniverseType.floatList;
      case DatabaseUniverseType.long:
        return DatabaseUniverseType.longList;
      case DatabaseUniverseType.double:
        return DatabaseUniverseType.doubleList;
      case DatabaseUniverseType.dateTime:
        return DatabaseUniverseType.dateTimeList;
      case DatabaseUniverseType.duration:
        return DatabaseUniverseType.durationList;
      case DatabaseUniverseType.string:
        return DatabaseUniverseType.stringList;
      case DatabaseUniverseType.object:
        return DatabaseUniverseType.objectList;
      // ignore: no_default_cases
      default:
        return this;
    }
  }
}
