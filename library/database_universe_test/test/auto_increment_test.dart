import 'package:isar/isar.dart';
import 'package:database_universe_test/database_universe_test.dart';
import 'package:test/test.dart';

part 'auto_increment_test.g.dart';

@collection
class Model {
  Model(this.id);

  final int id;
}

@collection
class StringModel {
  StringModel(this.id);

  final String id;
}

void main() {
  group('Auto increment', () {
    late Isar isar;

    setUp(() async {
      isar = await openTempIsar([ModelSchema, StringModelSchema]);
    });

    databaseUniverseTest('String ids not supported', () {
      expect(() => isar.stringModels.autoIncrement(), throwsUnsupportedError);
    });

    databaseUniverseTest('increases', () {
      expect(isar.models.autoIncrement(), 1);
      expect(isar.models.autoIncrement(), 2);
      expect(isar.models.autoIncrement(), 3);
    });

    databaseUniverseTest('adjusts after insert', () {
      expect(isar.models.autoIncrement(), 1);
      expect(isar.models.autoIncrement(), 2);
      expect(isar.models.autoIncrement(), 3);

      isar.write((isar) {
        isar.models.put(Model(100));
        isar.models.put(Model(200));
        isar.models.put(Model(300));
      });

      expect(isar.models.autoIncrement(), 301);
      expect(isar.models.autoIncrement(), 302);
      expect(isar.models.autoIncrement(), 303);
    });

    databaseUniverseTest('persists', web: false, () async {
      final isarName = isar.name;

      expect(isar.models.autoIncrement(), 1);
      isar.write((isar) {
        isar.models.put(Model(isar.models.autoIncrement()));
      });
      expect(isar.close(), true);

      isar = await openTempIsar([ModelSchema], name: isarName);
      expect(isar.models.autoIncrement(), 3);
    });
  });
}
