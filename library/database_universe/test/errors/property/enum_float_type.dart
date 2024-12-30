// unsupported enum property type

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  late int id;

  late MyEnum field;
}

enum MyEnum {
  optionA;

  @enumValue
  final float value = 5.5;
}
