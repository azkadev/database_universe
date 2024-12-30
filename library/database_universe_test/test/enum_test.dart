import 'package:database_universe/database_universe.dart';
import 'package:database_universe_test/database_universe_test.dart';
import 'package:test/test.dart';

part 'enum_test.g.dart';

enum IndexEnum {
  option1,
  option2,
  option3;
}

enum ByteEnum {
  option1(1),
  option2(2),
  option3(3);

  const ByteEnum(this.value);

  @enumValue
  final byte value;
}

enum ByteEnum2 {
  option1(2),
  option2(4),
  option3(6),
  option4(8);

  const ByteEnum2(this.value);

  @enumValue
  final byte value;
}

enum ShortEnum {
  option1(5),
  option2(6),
  option3(77);

  const ShortEnum(this.value);

  @enumValue
  final short value;
}

enum IntEnum {
  option1(-1),
  option2(0),
  option3(1);

  const IntEnum(this.value);

  @enumValue
  final int value;
}

enum StringEnum {
  option1('a'),
  option2('b'),
  option3('c');

  const StringEnum(this.value);

  @enumValue
  final String value;
}

@collection
class EnumModel {
  EnumModel(
    this.id,
    this.ordinalEnum,
    this.byteEnum,
    this.shortEnum,
    this.intEnum,
    this.stringEnum,
  );

  final int id;

  final IndexEnum ordinalEnum;

  final ByteEnum byteEnum;

  final ShortEnum shortEnum;

  final IntEnum intEnum;

  final StringEnum stringEnum;

  @override
  bool operator ==(Object other) => other is EnumModel && other.ordinalEnum == ordinalEnum && other.byteEnum == byteEnum && other.shortEnum == shortEnum && other.intEnum == intEnum && other.stringEnum == stringEnum;
}

void main() {
  group('Enum', () {
    databaseUniverseTest('Verify property types', () {});

    databaseUniverseTest('.get() / .put()', () async {});

    databaseUniverseTest('DateTime Enum', () {});

    databaseUniverseTest('Added value', () {});

    databaseUniverseTest('Removed value', () {});

    databaseUniverseTest('.exportJson()', () {});

    databaseUniverseTest('.importJson()', () {});
  });
}
