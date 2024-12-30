import 'package:database_universe/database_universe.dart';
import 'package:database_universe_test/database_universe_test.dart';
import 'package:test/test.dart';

part 'filter_float_list_test.g.dart';

@collection
class FloatModel {
  FloatModel(this.id, this.list);

  final int id;

  List<float?>? list;

  @override
  bool operator ==(Object other) => other is FloatModel && id == other.id && doubleListEquals(other.list, list);
}

void main() {
  group('Float list filter', () {
    late Isar isar;
    late IsarCollection<int, FloatModel> col;

    late FloatModel objEmpty;
    late FloatModel obj1;
    late FloatModel obj2;
    late FloatModel obj3;
    late FloatModel objNull;

    setUp(() async {
      isar = await openTempIsar([FloatModelSchema]);
      col = isar.floatModels;

      objEmpty = FloatModel(0, []);
      obj1 = FloatModel(1, [1.1, 3.3]);
      obj2 = FloatModel(2, [null]);
      obj3 = FloatModel(3, [null, -1000]);
      objNull = FloatModel(4, null);

      isar.write((isar) {
        col.putAll([objEmpty, obj1, obj2, obj3, objNull]);
      });
    });

    databaseUniverseTest('.elementEqualTo()', () {
      expect(col.where().listElementEqualTo(1.1).findAll(), [obj1]);
      expect(col.where().listElementEqualTo(4).findAll(), isEmpty);
      expect(col.where().listElementEqualTo(null).findAll(), [obj2, obj3]);
    });

    databaseUniverseTest('.elementGreaterThan()', () {
      expect(col.where().listElementGreaterThan(3.3).findAll(), isEmpty);
      expect(col.where().listElementGreaterThan(4).findAll(), isEmpty);
      expect(col.where().listElementGreaterThan(null).findAll(), [obj1, obj3]);
    });

    databaseUniverseTest('.elementGreaterThanOrEqualTo()', () {
      expect(
        col.where().listElementGreaterThanOrEqualTo(3.3).findAll(),
        [obj1],
      );
      expect(
        col.where().listElementGreaterThanOrEqualTo(3.4, epsilon: 0.2).findAll(),
        [obj1],
      );
      expect(
        col.where().listElementGreaterThanOrEqualTo(null).findAll(),
        [obj1, obj2, obj3],
      );
    });

    databaseUniverseTest('.elementLessThan()', () {
      expect(col.where().listElementLessThan(1.1).findAll(), [obj2, obj3]);
      expect(col.where().listElementLessThan(null).findAll(), isEmpty);
    });

    databaseUniverseTest('.elementLessThanOrEqualTo()', () {
      expect(
        col.where().listElementLessThanOrEqualTo(1.1).findAll(),
        [obj1, obj2, obj3],
      );
      expect(
        col.where().listElementLessThanOrEqualTo(1, epsilon: 0.2).findAll(),
        [obj1, obj2, obj3],
      );
      expect(
        col.where().listElementLessThanOrEqualTo(null).findAll(),
        [obj2, obj3],
      );
    });

    databaseUniverseTest('.anyBetween()', () {
      expect(col.where().listElementBetween(1, 5).findAll(), [obj1]);
      expect(
        col.where().listElementBetween(null, 1.1).findAll(),
        [obj1, obj2, obj3],
      );
      expect(col.where().listElementBetween(5, 10).findAll(), isEmpty);
      expect(
        col.where().listElementBetween(null, null).findAll(),
        [obj2, obj3],
      );
    });

    databaseUniverseTest('.elementIsNull()', () {
      expect(col.where().listElementIsNull().findAll(), [obj2, obj3]);
    });

    databaseUniverseTest('.elementIsNotNull()', () {
      expect(col.where().listElementIsNotNull().findAll(), [obj1, obj3]);
    });

    databaseUniverseTest('.isNull()', () {
      expect(col.where().listIsNull().findAll(), [objNull]);
    });

    databaseUniverseTest('.isNotNull()', () {
      expect(
        col.where().listIsNotNull().findAll(),
        [objEmpty, obj1, obj2, obj3],
      );
    });
  });
}
