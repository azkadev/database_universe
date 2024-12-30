import 'package:database_universe/database_universe.dart';
import 'package:database_universe_test/database_universe_test.dart';
import 'package:test/test.dart';

part 'name_test.g.dart';

@collection
@Name('NameModelN')
class NameModel {
  NameModel(this.id);

  @Name('idN')
  int id;

  @Index()
  @Name('valueN')
  String? value;

  //@Index(composite: [CompositeIndex('value')])
  @Name('otherValueN')
  String? otherValue;
}

void main() {
  group('Name', () {
    late Isar isar;

    setUp(() async {
      isar = await openTempIsar([NameModelSchema]);
    });

    databaseUniverseTest('json', () {
      isar.write(
        (isar) => isar.nameModels.put(
          NameModel(1)
            ..value = 'test'
            ..otherValue = 'test2',
        ),
      );

      expect(isar.nameModels.where().exportJson(), [
        {
          'idN': 1,
          'valueN': 'test',
          'otherValueN': 'test2',
        },
      ]);
    });
  });
}
