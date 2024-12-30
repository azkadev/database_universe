// unsupported enum property type

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  late int id;

  late MyEnum prop;
}

enum MyEnum {
  optionA;

  @enumValue
  final value = EmbeddedModel();
}

@embedded
class EmbeddedModel {}
