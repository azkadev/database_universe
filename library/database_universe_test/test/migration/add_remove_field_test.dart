import 'package:database_universe/database_universe.dart';
import 'package:database_universe_test/database_universe_test.dart';
import 'package:test/test.dart';

part 'add_remove_field_test.g.dart';

@collection
@Name('Col')
class Col1 {
  Col1(this.id, this.value);

  int id;

  String? value;

  @override
  bool operator ==(Object other) => other is Col1 && id == other.id && value == other.value;
}

@collection
@Name('Col')
class Col2 {
  Col2(this.id, this.value, this.newValues);

  int id;

  String? value;

  List<String>? newValues;

  @override
  bool operator ==(Object other) => other is Col2 && id == other.id && value == other.value && listEquals(newValues, other.newValues);
}

void main() {
  databaseUniverseTest('Add field', web: false, () async {
    final isar1 = await openTempIsar([Col1Schema]);
    final isarName = isar1.name;
    isar1.write((isar) {
      return isar.col1s.putAll([Col1(1, 'value1'), Col1(2, 'value2')]);
    });
    expect(isar1.close(), true);

    final isar2 = await openTempIsar([Col2Schema], name: isarName);
    expect(isar2.col2s.where().findAll(), [
      Col2(1, 'value1', null),
      Col2(2, 'value2', null),
    ]);
    isar2.write((isar) {
      return isar.col2s.putAll([
        Col2(1, 'value3', ['hi']),
        Col2(3, 'value4', []),
      ]);
    });
    expect(isar2.col2s.where().findAll(), [
      Col2(1, 'value3', ['hi']),
      Col2(2, 'value2', null),
      Col2(3, 'value4', []),
    ]);
    expect(isar2.close(), true);

    final isar3 = await openTempIsar([Col1Schema], name: isarName);
    expect(isar3.col1s.where().findAll(), [
      Col1(1, 'value3'),
      Col1(2, 'value2'),
      Col1(3, 'value4'),
    ]);
  });

  databaseUniverseTest('Remove field', web: false, () async {
    final isar1 = await openTempIsar([Col2Schema]);
    final isarName = isar1.name;
    isar1.write((isar) {
      return isar.col2s.putAll([
        Col2(1, 'value1', ['hi']),
        Col2(2, 'value2', ['val2', 'val22']),
      ]);
    });
    expect(isar1.close(), true);

    final isar2 = await openTempIsar([Col1Schema], name: isarName);
    expect(isar2.col1s.where().findAll(), [
      Col1(1, 'value1'),
      Col1(2, 'value2'),
    ]);
    isar2.write((isar) {
      return isar.col1s.put(Col1(1, 'value3'));
    });
    expect(isar2.col1s.where().findAll(), [
      Col1(1, 'value3'),
      Col1(2, 'value2'),
    ]);
  });
}
