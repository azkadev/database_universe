// ids cannot be indexed

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  late int id;

  @Index(composite: ['id'])
  int? str;
}
