import 'package:isar/isar.dart';
import 'package:database_universe_test/database_universe_test.dart';
import 'package:test/test.dart';

part 'filter_int_test.g.dart';

@collection
class IntModel {
  IntModel(this.id, this.field);

  final int id;

  short? field = 0;

  @override
  bool operator ==(Object other) {
    return other is IntModel && id == other.id && other.field == field;
  }
}

void main() {
  group('Int filter', () {
    late Isar isar;
    late IsarCollection<int, IntModel> col;

    late IntModel obj0;
    late IntModel obj1;
    late IntModel obj2;
    late IntModel obj3;
    late IntModel objNull;

    setUp(() async {
      isar = await openTempIsar([IntModelSchema]);
      col = isar.intModels;

      obj0 = IntModel(0, -1234);
      obj1 = IntModel(1, 1);
      obj2 = IntModel(2, 2);
      obj3 = IntModel(3, 1);
      objNull = IntModel(4, null);

      isar.write((isar) {
        isar.intModels.putAll([obj0, obj1, obj2, obj3, objNull]);
      });
    });

    databaseUniverseTest('.equalTo()', () {
      expect(col.where().fieldEqualTo(2).findAll(), [obj2]);
      expect(col.where().fieldEqualTo(null).findAll(), [objNull]);
      expect(col.where().fieldEqualTo(5).findAll(), isEmpty);
    });

    databaseUniverseTest('.greaterThan()', () {
      expect(col.where().fieldGreaterThan(1).findAll(), [obj2]);
      expect(
        col.where().fieldGreaterThan(null).findAll(),
        [obj0, obj1, obj2, obj3],
      );
      expect(col.where().fieldGreaterThan(4).findAll(), isEmpty);
    });

    databaseUniverseTest('.greaterThanOrEqualTo()', () {
      expect(
        col.where().fieldGreaterThanOrEqualTo(1).findAll(),
        [obj1, obj2, obj3],
      );
      expect(
        col.where().fieldGreaterThanOrEqualTo(null).findAll(),
        [obj0, obj1, obj2, obj3, objNull],
      );
    });

    databaseUniverseTest('.lessThan()', () {
      expect(col.where().fieldLessThan(1).findAll(), [obj0, objNull]);
      expect(col.where().fieldLessThan(null).findAll(), isEmpty);
    });

    databaseUniverseTest('.lessThanOrEqualTo()', () {
      expect(col.where().fieldLessThanOrEqualTo(null).findAll(), [objNull]);
    });

    databaseUniverseTest('.between()', () {
      expect(col.where().fieldBetween(1, 2).findAll(), [obj1, obj2, obj3]);
      expect(
        col.where().fieldBetween(null, 1).findAll(),
        [obj0, obj1, obj3, objNull],
      );
      expect(col.where().fieldBetween(5, 6).findAll(), isEmpty);
    });

    databaseUniverseTest('.isNull()', () {
      expect(col.where().fieldIsNull().findAll(), [objNull]);
    });

    databaseUniverseTest('.isNotNull()', () {
      expect(col.where().fieldIsNotNull().findAll(), [obj0, obj1, obj2, obj3]);
    });
  });
}
