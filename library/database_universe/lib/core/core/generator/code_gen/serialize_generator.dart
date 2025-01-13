// ignore_for_file: use_string_buffers
// ignore_for_file: always_put_required_named_parameters_first

part of "package:database_universe/core/core/generator/database_universe_generator.dart";

String _generateSerialize(ObjectInfo object) {
  var code = '''
  @databaseUniverseProtected
  int serialize${object.dartName}(DatabaseUniverseWriter writer, ${object.dartName} object) {''';

  for (final property in object.properties) {
    if (property.isId && property.type == DatabaseUniverseType.long) {
      continue;
    }

    code += _writeProperty(
      index: property.index.toString(),
      type: property.type,
      nullable: property.nullable,
      elementNullable: property.elementNullable,
      typeClassName: property.typeClassName,
      value: 'object.${property.dartName}',
      enumProperty: property.enumProperty,
    );
  }

  final idProp = object.idProperty;
  if (idProp != null) {
    if (idProp.type == DatabaseUniverseType.long) {
      code += 'return object.${idProp.dartName};';
    } else {
      code += 'return DatabaseUniverse.fastHash(object.${idProp.dartName});';
    }
  } else {
    code += 'return 0;';
  }

  return '$code}';
}

String _writeProperty({
  String writer = 'writer',
  required String index,
  required DatabaseUniverseType type,
  required bool nullable,
  bool? elementNullable,
  required String typeClassName,
  required String value,
  required String? enumProperty,
}) {
  final enumGetter = enumProperty != null
      ? nullable
          ? '?.$enumProperty'
          : '.$enumProperty'
      : '';
  switch (type) {
    case DatabaseUniverseType.bool:
      if (nullable) {
        return '''
        {
          final value = $value$enumGetter;
          if (value == null) {
            DatabaseUniverseCore.writeNull($writer, $index);
          } else {
            DatabaseUniverseCore.writeBool($writer, $index, value);
          }
        }''';
      } else {
        return 'DatabaseUniverseCore.writeBool($writer, $index, $value$enumGetter);';
      }
    case DatabaseUniverseType.byte:
      return 'DatabaseUniverseCore.writeByte($writer, $index, $value$enumGetter);';
    case DatabaseUniverseType.int:
      final orNull = nullable ? '?? $_nullInt' : '';
      return 'DatabaseUniverseCore.writeInt($writer, $index, $value$enumGetter $orNull);';
    case DatabaseUniverseType.float:
      final orNull = nullable ? '?? double.nan' : '';
      return 'DatabaseUniverseCore.writeFloat($writer, $index, $value$enumGetter $orNull);';
    case DatabaseUniverseType.long:
      final orNull = nullable ? '?? $_nullLong' : '';
      return 'DatabaseUniverseCore.writeLong($writer, $index, $value$enumGetter $orNull);';
    case DatabaseUniverseType.dateTime:
      final converted = nullable
          ? '$value$enumGetter?.toUtc().microsecondsSinceEpoch ?? $_nullLong'
          : '$value$enumGetter.toUtc().microsecondsSinceEpoch';
      return 'DatabaseUniverseCore.writeLong($writer, $index, $converted);';
    case DatabaseUniverseType.duration:
      final converted = nullable
          ? '$value$enumGetter?.inMicroseconds ?? $_nullLong'
          : '$value$enumGetter?.inMicroseconds';
      return 'DatabaseUniverseCore.writeLong($writer, $index, $converted);';
    case DatabaseUniverseType.double:
      final orNull = nullable ? '?? double.nan' : '';
      return 'DatabaseUniverseCore.writeDouble($writer, $index, $value$enumGetter$orNull);';
    case DatabaseUniverseType.string:
      if (nullable) {
        return '''
        {
          final value = $value$enumGetter;
          if (value == null) {
            DatabaseUniverseCore.writeNull($writer, $index);
          } else {
            DatabaseUniverseCore.writeString($writer, $index, value);
          }
        }''';
      } else {
        return '''
        DatabaseUniverseCore.writeString($writer, $index, $value$enumGetter);''';
      }
    case DatabaseUniverseType.object:
      var code = '''
      {
        final value = $value;''';
      if (nullable) {
        code += '''
        if (value == null) {
          DatabaseUniverseCore.writeNull($writer, $index);
        } else {''';
      }
      code += '''
      final objectWriter = DatabaseUniverseCore.beginObject($writer, $index);
      serialize$typeClassName(objectWriter, value);
      DatabaseUniverseCore.endObject($writer, objectWriter);''';
      if (nullable) {
        code += '}';
      }
      return '$code}';
    case DatabaseUniverseType.json:
      return 'DatabaseUniverseCore.writeString($writer, $index, databaseUniverseJsonEncode($value));';
    case DatabaseUniverseType.boolList:
    case DatabaseUniverseType.byteList:
    case DatabaseUniverseType.intList:
    case DatabaseUniverseType.floatList:
    case DatabaseUniverseType.longList:
    case DatabaseUniverseType.dateTimeList:
    case DatabaseUniverseType.durationList:
    case DatabaseUniverseType.doubleList:
    case DatabaseUniverseType.stringList:
    case DatabaseUniverseType.objectList:
      var code = '''
      {
        final list = $value;''';
      if (nullable) {
        code += '''
        if (list == null) {
          DatabaseUniverseCore.writeNull($writer, $index);
        } else {''';
      }
      code += '''
      final listWriter = DatabaseUniverseCore.beginList(writer, $index, list.length);
      for (var i = 0; i < list.length; i++) {
        ${_writeProperty(
        writer: 'listWriter',
        index: 'i',
        type: type.scalarType,
        nullable: elementNullable!,
        typeClassName: typeClassName,
        value: 'list[i]',
        enumProperty: enumProperty,
      )}
      }
      DatabaseUniverseCore.endList(writer, listWriter);
      ''';
      if (nullable) {
        code += '}';
      }
      return '$code}';
  }
}
