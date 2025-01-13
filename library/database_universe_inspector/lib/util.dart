import 'package:database_universe/database_universe.dart';

extension CollectionInfoX on DatabaseUniverseSchema {
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

extension TypeName on DatabaseUniverseType {
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
