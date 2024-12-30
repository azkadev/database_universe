// same name

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  late int id;

  @Index(name: 'myindex')
  String? prop1;

  @Index(name: 'myindex')
  String? prop2;
}
