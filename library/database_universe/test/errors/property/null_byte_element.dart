// bytes must not be nullable

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  late int id;

  late List<byte?> prop;
}
