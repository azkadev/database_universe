// double properties cannot be indexed

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  late int id;

  @index
  double? val1;

  String? val2;
}
