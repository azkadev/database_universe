// constructor parameter does not match a property

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  // ignore: avoid_unused_constructor_parameters
  Model(this.prop1, String somethingElse);

  late int id;

  final String prop1;
}
