import 'package:database_universe/database_universe.dart';

part 'common.g.dart';

enum MyEnum {
  value1(1),
  value2(2),
  value3(3);

  const MyEnum(this.value);

  @enumValue
  final int value;
}

@embedded
class MyEmbedded {
  const MyEmbedded([this.test = '']);

  final String test;

  @override
  bool operator ==(Object other) => other is MyEmbedded && other.test == test;
}

@Name('Col')
@collection
class EmptyModel {
  EmptyModel(this.id);

  final int id;
}
