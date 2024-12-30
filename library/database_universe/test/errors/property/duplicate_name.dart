// same name

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  late int id;

  String? prop1;

  @Name('prop1')
  String? prop2;
}
