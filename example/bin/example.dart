import 'dart:developer';
import 'dart:io';

import 'package:database_universe/core/core.dart';
import 'package:example/database_scheme/email.dart';
import "package:path/path.dart" as path;

void main(List<String> arguments) async {
  await DatabaseUniverse.initialize(
    "/home/galaxeus/Documents/librarys/database_universe/libdatabase_universe_linux_x64.so",
  );
  final Directory directory_database = Directory(path.join(Directory.current.path, "db"));
  if (directory_database.existsSync() == false) {
    directory_database.createSync(recursive: true);
  }

  final db = DatabaseUniverse.open(
    schemas: [
      EmailSchema,
    ],
    directory: directory_database.path,
    name: "database",
  );
  stdin.listen((e) {});
}
