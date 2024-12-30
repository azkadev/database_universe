part of database_universe_generator;

const TypeChecker _dateTimeChecker = TypeChecker.fromRuntime(DateTime);
const TypeChecker _durationChecker = TypeChecker.fromRuntime(Duration);

extension on DartType {
  bool get isDartCoreDateTime =>
      element != null && _dateTimeChecker.isExactly(element!);

  bool get isDartCoreDuration =>
      element != null && _durationChecker.isExactly(element!);

  DatabaseUniverseType? get _primitiveDatabaseUniverseType {
    if (isDartCoreBool) {
      return DatabaseUniverseType.bool;
    } else if (isDartCoreInt) {
      if (alias?.element.name == 'byte') {
        return DatabaseUniverseType.byte;
      } else if (alias?.element.name == 'short') {
        return DatabaseUniverseType.int;
      } else {
        return DatabaseUniverseType.long;
      }
    } else if (isDartCoreDouble) {
      if (alias?.element.name == 'float') {
        return DatabaseUniverseType.float;
      } else {
        return DatabaseUniverseType.double;
      }
    } else if (isDartCoreString) {
      return DatabaseUniverseType.string;
    } else if (isDartCoreDateTime) {
      return DatabaseUniverseType.dateTime;
    } else if (isDartCoreDuration) {
      return DatabaseUniverseType.duration;
    } else if (element!.embeddedAnnotation != null) {
      return DatabaseUniverseType.object;
    } else if (this is DynamicType) {
      return DatabaseUniverseType.json;
    }

    return null;
  }

  DartType get scalarType {
    if (isDartCoreList) {
      final parameterizedType = this as ParameterizedType;
      final typeArguments = parameterizedType.typeArguments;
      if (typeArguments.isNotEmpty) {
        return typeArguments[0];
      }
    }
    return this;
  }

  DatabaseUniverseType? get propertyType {
    final primitiveType = _primitiveDatabaseUniverseType;
    if (primitiveType != null) {
      return primitiveType;
    }

    if (isDartCoreList) {
      switch (scalarType._primitiveDatabaseUniverseType) {
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
        case DatabaseUniverseType.string:
          return DatabaseUniverseType.stringList;
        case DatabaseUniverseType.object:
          return DatabaseUniverseType.objectList;
        case DatabaseUniverseType.json:
          return DatabaseUniverseType.json;
        // ignore: no_default_cases
        default:
          return null;
      }
    } else if (isDartCoreMap) {
      final keyType = (this as ParameterizedType).typeArguments[0];
      final valueType = (this as ParameterizedType).typeArguments[1];
      if (keyType.isDartCoreString && valueType is DynamicType) {
        return DatabaseUniverseType.json;
      }
    }

    return null;
  }

  bool get supportsJsonConversion {
    final element = this.element;
    if (element is ClassElement) {
      // check if the class has a toJson() method returning Map<String,dynamic>
      // and a fromJson factory
      final toJson = element.getMethod('toJson');
      final fromJson = element.getNamedConstructor('fromJson');
      if (toJson != null && fromJson != null) {
        final toJsonReturnType = toJson.returnType;
        final fromJsonParameterType = fromJson.parameters.firstOrNull?.type;
        if (toJsonReturnType.isDartCoreMap &&
            toJsonReturnType is ParameterizedType &&
            toJsonReturnType.typeArguments[0].isDartCoreString &&
            toJsonReturnType.typeArguments[1] is DynamicType &&
            fromJsonParameterType != null &&
            fromJsonParameterType.isDartCoreMap &&
            fromJsonParameterType is ParameterizedType &&
            fromJsonParameterType.typeArguments[0].isDartCoreString &&
            fromJsonParameterType.typeArguments[1] is DynamicType) {
          return true;
        }
      }
    }
    return false;
  }
}
