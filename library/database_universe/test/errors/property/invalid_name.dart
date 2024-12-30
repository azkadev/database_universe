// names must not be blank or start with "_"

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  late int id;

  @Name('_prop')
  String? prop;
}
