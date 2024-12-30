// property does not exist

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  late int id;

  @Index(composite: ['myProp'])
  int? value;
}
