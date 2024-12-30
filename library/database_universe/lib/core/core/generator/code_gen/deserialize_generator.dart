// ignore_for_file: use_string_buffers, no_default_cases,
// ignore_for_file: always_put_required_named_parameters_first

part of database_universe_generator;

String _generateDeserialize(ObjectInfo object) {
  var code = '''
  @databaseUniverseProtected
  ${object.dartName} deserialize${object.dartName}(DatabaseUniverseReader reader) {''';

  final propertiesByMode = {
    DeserializeMode.none: <PropertyInfo>[],
    DeserializeMode.assign: <PropertyInfo>[],
    DeserializeMode.positionalParam: <PropertyInfo>[],
    DeserializeMode.namedParam: <PropertyInfo>[],
  };
  for (final property in object.properties) {
    propertiesByMode[property.mode]!.add(property);
  }

  final positional = propertiesByMode[DeserializeMode.positionalParam]!;
  positional.sort(
    (p1, p2) => p1.constructorPosition!.compareTo(p2.constructorPosition!),
  );
  final named = propertiesByMode[DeserializeMode.namedParam]!;

  for (final p in [...positional, ...named]) {
    code += 'final ${p.dartType} _${p.dartName};';
    code += _deserializeProperty(object, p, (value) {
      return '_${p.dartName} = $value;';
    });
  }

  code += 'final object = ${object.dartName}(';

  for (final p in positional) {
    code += '_${p.dartName},';
  }

  for (final p in named) {
    code += '${p.dartName}: _${p.dartName},';
  }

  code += ');';

  final assign = propertiesByMode[DeserializeMode.assign]!;
  for (final p in assign) {
    code += _deserializeProperty(object, p, (value) {
      return 'object.${p.dartName} = $value;';
    });
  }

  return '''
    $code
    return object;
  }''';
}

String _generateDeserializeProp(ObjectInfo object) {
  var code = '''
    @databaseUniverseProtected
    dynamic deserialize${object.dartName}Prop(DatabaseUniverseReader reader, int property) {
      switch (property) {''';
  for (final p in object.properties) {
    final deser = _deserializeProperty(object, p, (value) {
      return 'return $value;';
    });
    code += 'case ${p.index}: $deser';
  }

  return '''
      $code
      default:
        throw ArgumentError('Unknown property: \$property');
      }
    }
    ''';
}

String _deserializeProperty(
  ObjectInfo object,
  PropertyInfo p,
  String Function(String value) result,
) {
  return _deserialize(
    index: p.index.toString(),
    isId: p.isId,
    typeClassName: p.typeClassName,
    type: p.type,
    elementDartType: p.scalarDartType,
    defaultValue: p.defaultValue,
    elementDefaultValue: p.elementDefaultValue,
    utc: p.utc,
    transform: (value) {
      if (p.isEnum && !p.type.isList && value != p.defaultValue) {
        return result(
          '${p.enumMapName(object)}[$value] ?? ${p.defaultValue}',
        );
      } else {
        return result(value);
      }
    },
    transformElement: (value) {
      if (p.isEnum && value != p.elementDefaultValue) {
        return '${p.enumMapName(object)}[$value] ?? ${p.elementDefaultValue}';
      } else {
        return value;
      }
    },
  );
}

String _deserialize({
  required String index,
  required bool isId,
  required String typeClassName,
  required DatabaseUniverseType type,
  String? elementDartType,
  required String defaultValue,
  String? elementDefaultValue,
  required bool utc,
  required String Function(String value) transform,
  String Function(String value)? transformElement,
}) {
  switch (type) {
    case DatabaseUniverseType.bool:
      if (defaultValue == 'false') {
        return transform('DatabaseUniverseCore.readBool(reader, $index)');
      } else {
        return '''
        {
          if (DatabaseUniverseCore.readNull(reader, $index)) {
            ${transform(defaultValue)}
          } else {
            ${transform('DatabaseUniverseCore.readBool(reader, $index)')}
          }
        }''';
      }
    case DatabaseUniverseType.byte:
      if (defaultValue == '0') {
        return transform('DatabaseUniverseCore.readByte(reader, $index)');
      } else {
        return '''
        {
          if (DatabaseUniverseCore.readNull(reader, $index)) {
            ${transform(defaultValue)}
          } else {
            ${transform('DatabaseUniverseCore.readByte(reader, $index)')}
          }
        }''';
      }
    case DatabaseUniverseType.int:
      if (defaultValue == '$_nullInt') {
        return transform('DatabaseUniverseCore.readInt(reader, $index)');
      } else {
        return '''
        {
          final value = DatabaseUniverseCore.readInt(reader, $index);
          if (value == $_nullInt) {
            ${transform(defaultValue)}
          } else {
            ${transform('value')}
          }
        }''';
      }
    case DatabaseUniverseType.float:
      if (defaultValue == 'double.nan') {
        return transform('DatabaseUniverseCore.readFloat(reader, $index)');
      } else {
        return '''
        {
          final value = DatabaseUniverseCore.readFloat(reader, $index);
          if (value.isNaN) {
            ${transform(defaultValue)}
          } else {
            ${transform('value')}
          }
        }''';
      }
    case DatabaseUniverseType.long:
      if (isId) {
        return transform('DatabaseUniverseCore.readId(reader)');
      } else if (defaultValue == '$_nullLong') {
        return transform('DatabaseUniverseCore.readLong(reader, $index)');
      } else {
        return '''
        {
          final value = DatabaseUniverseCore.readLong(reader, $index);
          if (value == $_nullLong) {
            ${transform(defaultValue)}
          } else {
            ${transform('value')}
          }
        }''';
      }
    case DatabaseUniverseType.dateTime:
      final toLocal = utc ? '' : '.toLocal()';
      return '''
        {
          final value = DatabaseUniverseCore.readLong(reader, $index);
          if (value == $_nullLong) {
            ${transform(defaultValue)}
          } else {
            ${transform('DateTime.fromMicrosecondsSinceEpoch(value, isUtc: true)$toLocal')}
          }
        }''';
    case DatabaseUniverseType.duration:
      return '''
        {
          final value = DatabaseUniverseCore.readLong(reader, $index);
          if (value == $_nullLong) {
            ${transform(defaultValue)}
          } else {
            ${transform('Duration(milliseconds: value)')}
          }
        }''';
    case DatabaseUniverseType.double:
      if (defaultValue == 'double.nan') {
        return transform('DatabaseUniverseCore.readDouble(reader, $index)');
      } else {
        return '''
        {
          final value = DatabaseUniverseCore.readDouble(reader, $index);
          if (value.isNaN) {
            ${transform(defaultValue)}
          } else {
            ${transform('value')}
          }
        }''';
      }
    case DatabaseUniverseType.string:
      if (defaultValue == 'null') {
        return transform('DatabaseUniverseCore.readString(reader, $index)');
      } else {
        return transform(
          'DatabaseUniverseCore.readString(reader, $index) ?? $defaultValue',
        );
      }

    case DatabaseUniverseType.object:
      return '''
      {
        final objectReader = DatabaseUniverseCore.readObject(reader, $index);
        if (objectReader.isNull) {
          ${transform(defaultValue)}
        } else {
          final embedded = deserialize$typeClassName(objectReader);
          DatabaseUniverseCore.freeReader(objectReader);
          ${transform('embedded')}
        }
      }''';
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
      final deser = _deserialize(
        index: 'i',
        isId: false,
        typeClassName: typeClassName,
        type: type.scalarType,
        defaultValue: elementDefaultValue!,
        utc: utc,
        transform: (value) => 'list[i] = ${transformElement!(value)};',
      );
      return '''
      {
        final length = DatabaseUniverseCore.readList(reader, $index, DatabaseUniverseCore.readerPtrPtr);
        {
          final reader = DatabaseUniverseCore.readerPtr;
          if (reader.isNull) {
            ${transform(defaultValue)}
          } else {
            final list = List<$elementDartType>.filled(length, $elementDefaultValue, growable: true);
            for (var i = 0; i < length; i++) {
              $deser
            }
            DatabaseUniverseCore.freeReader(reader);
            ${transform('list')}
          }
        }
      }''';
    case DatabaseUniverseType.json:
      if (typeClassName == 'dynamic') {
        return transform(
          'databaseUniverseJsonDecode(DatabaseUniverseCore.readString(reader, $index) '
          "?? 'null') ?? $defaultValue",
        );
      } else {
        return '''
        {
          final json = databaseUniverseJsonDecode(DatabaseUniverseCore.readString(reader, $index) ?? 'null');
          if (json is ${typeClassName == 'List' ? 'List' : 'Map<String, dynamic>'}) {
            ${typeClassName == 'List' || typeClassName == 'Map' ? transform('json') : transform('$typeClassName.fromJson(json)')}
          } else {
            ${transform(defaultValue)}
          }
        }''';
      }
  }
}
