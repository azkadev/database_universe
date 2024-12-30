// only int and string properties can be used as id

import 'package:database_universe/database_universe.dart';

@collection
class Test {
  late TestEnum id;
}

enum TestEnum { a, b, c }
