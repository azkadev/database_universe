// ids cannot be indexed

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  late String id;

  @Index(composite: ['id'])
  int? value;
}
