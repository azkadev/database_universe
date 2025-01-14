// last property of a non-hashed composite index can be a string

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  late int id;

  @Index(composite: ['str2'], hash: false)
  String? str1;

  String? str2;
}
