import 'dart:math';

import 'package:database_universe/database_universe.dart';
import 'package:database_universe_test/database_universe_test.dart';
import 'package:test/test.dart';

part 'filter_bool_test.g.dart';

@collection
class BoolModel {
  BoolModel(this.field);

  int id = Random().nextInt(99999);

  bool? field;

  @override
  bool operator ==(Object other) {
    return other is BoolModel && other.id == id && other.field == field;
  }
}

void main() {
  group('Bool filter', () {
    late Isar isar;
    late IsarCollection<int, BoolModel> col;

    late BoolModel objNull;
    late BoolModel objFalse;
    late BoolModel objTrue;
    late BoolModel objFalse2;

    setUp(() async {
      isar = await openTempIsar([BoolModelSchema]);
      col = isar.boolModels;

      objNull = BoolModel(null);
      objFalse = BoolModel(false);
      objTrue = BoolModel(true);
      objFalse2 = BoolModel(false);

      isar.write((isar) {
        col.putAll([objNull, objFalse, objTrue, objFalse2]);
      });
    });

    databaseUniverseTest('.equalTo()', () {
      expect(col.where().fieldEqualTo(true).findAll(), [objTrue]);
      expect(
        col.where().fieldEqualTo(false).findAll().toSet(),
        {objFalse, objFalse2},
      );
      expect(col.where().fieldEqualTo(null).findAll(), [objNull]);
    });

    databaseUniverseTest('.isNull()', () {
      expect(col.where().fieldIsNull().findAll(), [objNull]);
    });

    databaseUniverseTest('.isNotNull()', () {
      expect(
        col.where().fieldIsNotNull().findAll().toSet(),
        {objFalse, objTrue, objFalse2},
      );
    });
  });
}
