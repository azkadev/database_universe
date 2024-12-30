// two or more properties are annotated with @id

import 'package:database_universe/database_universe.dart';

@collection
class Test {
  @id
  late int id1;

  @id
  late int id2;
}
