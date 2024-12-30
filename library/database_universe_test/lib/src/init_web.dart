import 'package:database_universe/database_universe.dart';

Future<void> prepareTest() async {
  await Isar.initialize('http://localhost:3000/isar.wasm');
}
