// constructor parameter type does not match property type

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  // ignore: avoid_unused_constructor_parameters
  Model(int prop1);

  late int id;

  String prop1 = '5';
}
