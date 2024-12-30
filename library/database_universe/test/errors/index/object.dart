// embedded object properties cannot be indexed

import 'package:database_universe/database_universe.dart';

@collection
class Model {
  late int id;

  @Index()
  EmbeddedModel? obj;
}

@embedded
class EmbeddedModel {}
