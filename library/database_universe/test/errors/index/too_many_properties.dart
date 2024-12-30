// composite indexes cannot have more than 3 properties

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  late int id;

  @Index(composite: ['int2', 'int3', 'int4'], hash: false)
  int? int1;

  int? int2;

  int? int3;

  int? int4;
}
