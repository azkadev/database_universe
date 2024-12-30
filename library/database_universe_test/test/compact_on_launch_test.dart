@TestOn('vm')
library;

import 'dart:io';

import 'package:database_universe/database_universe.dart';
import 'package:database_universe_test/database_universe_test.dart';
import 'package:test/test.dart';

part 'compact_on_launch_test.g.dart';

@Collection()
class Model {
  Model(this.id);

  final int id;

  List<int> buffer = List.filled(16000, 42);

  @override
  bool operator ==(Object other) => identical(this, other) || other is Model && runtimeType == other.runtimeType && id == other.id && listEquals(buffer, other.buffer);

  @override
  String toString() {
    return 'Model{id: $id}';
  }
}

void main() {
  group('Compact on launch', () {
    late Isar isar;
    late final isarName = getRandomName();
    late File file;

    setUp(() async {
      isar = await openTempIsar([ModelSchema], name: isarName);
      if (isSQLite) {
        file = File('${isar.directory}/$isarName.sqlite');
      } else {
        file = File('${isar.directory}/$isarName.isar');
      }

      isar.write(
        (isar) => isar.models.putAll(List.generate(100, Model.new)),
      );
    });

    databaseUniverseTest('No compact on launch', () async {
      isar.close();
      final size1 = file.lengthSync();

      isar = await openTempIsar([ModelSchema], name: isarName);
      isar.write((isar) => isar.models.where().deleteAll(limit: 50));
      isar.close();

      final size2 = file.lengthSync();

      isar = await openTempIsar([ModelSchema], name: isarName);

      expect(size1, size2);
    });

    databaseUniverseTest('minFileSize', sqlite: false, () async {
      isar.close();
      final size1 = file.lengthSync();

      isar = await openTempIsar([ModelSchema], name: isarName);
      isar.write((isar) => isar.models.where().deleteAll(limit: 50));
      isar.close();

      isar = await openTempIsar(
        [ModelSchema],
        name: isarName,
        compactOnLaunch: CompactCondition(minFileSize: size1 * 2),
      );
      isar.close();
      final size2 = file.lengthSync();
      expect(size1, size2);

      isar = await openTempIsar(
        [ModelSchema],
        name: isarName,
        compactOnLaunch: CompactCondition(minFileSize: size1 ~/ 2),
      );
      final size3 = file.lengthSync();
      expect(size3, lessThan(size2));
    });

    databaseUniverseTest('minBytes', sqlite: false, () async {
      isar.close();
      final size1 = file.lengthSync();

      isar = await openTempIsar([ModelSchema], name: isarName);
      isar.write((isar) => isar.models.where().deleteAll(limit: 10));
      isar.close();

      isar = await openTempIsar(
        [ModelSchema],
        name: isarName,
        compactOnLaunch: CompactCondition(minBytes: size1 ~/ 2),
      );
      isar.close();
      final size2 = file.lengthSync();
      expect(size1, size2);

      isar = await openTempIsar(
        [ModelSchema],
        name: isarName,
        compactOnLaunch: CompactCondition(minBytes: size1 ~/ 2),
      );
      isar.write((isar) => isar.models.where().deleteAll(limit: 90));
      isar.close();
      final size3 = file.lengthSync();
      expect(size3, size2);

      isar = await openTempIsar(
        [ModelSchema],
        name: isarName,
        compactOnLaunch: CompactCondition(minBytes: size1 ~/ 2),
      );
      final size4 = file.lengthSync();
      expect(size4, lessThan(size3));
    });

    databaseUniverseTest('minRatio', sqlite: false, () async {
      isar.close();
      final size1 = file.lengthSync();

      isar = await openTempIsar([ModelSchema], name: isarName);
      isar.write((isar) => isar.models.where().deleteAll(limit: 10));
      isar.close();

      isar = await openTempIsar(
        [ModelSchema],
        name: isarName,
        compactOnLaunch: const CompactCondition(minRatio: 2),
      );
      isar.close();
      final size2 = file.lengthSync();
      expect(size1, size2);

      isar = await openTempIsar(
        [ModelSchema],
        name: isarName,
        compactOnLaunch: const CompactCondition(minRatio: 2),
      );
      isar.write((isar) => isar.models.where().deleteAll(limit: 80));
      isar.close();
      final size3 = file.lengthSync();
      expect(size3, size2);

      isar = await openTempIsar(
        [ModelSchema],
        name: isarName,
        compactOnLaunch: const CompactCondition(minRatio: 2),
      );
      final size4 = file.lengthSync();
      expect(size4, lessThan(size3));
    });
  });
}
