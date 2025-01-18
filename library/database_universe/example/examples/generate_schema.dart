import 'dart:io';
import 'package:general_lib/general_lib.dart';
import "package:path/path.dart" as path;

void main(List<String> args) async {
  final Directory directoryCurrent = Directory.current;
  final Directory directorySchemes =
      Directory(path.join(directoryCurrent.path, "lib", "schema"));
  directorySchemes.generalLibUtilsDangerRecreate();
  {
    final Directory directoryDatabaseScheme =
        Directory(path.join(directorySchemes.path, "database_scheme"))
            .generalLibUtilsDangerRecreate();
    for (final element in schemes) {
      final generateSchema = jsonToDatabaseUniverse(
        element,
        className:
            "${element["@type"]}${GeneralLibSchemeType.local.toSpesialType()}",
      );
      await generateSchema.saveToFile(directoryDatabaseScheme);
    }
  }
  {
    Process.runSync(
      "dart",
      ["pub", "get", "--offline"],
      workingDirectory: directoryCurrent.path,
    );
    Process.runSync(
      "dart",
      [
        "format",
        ".",
      ],
      workingDirectory: directoryCurrent.path,
    );
    final result = await Process.start(
      "dart",
      [
        "run",
        "build_runner",
        "build",
        "--delete-conflicting-outputs",
      ],
      workingDirectory: directoryCurrent.path,
    );
    result.stderr.listen(stderr.add);
    result.stdout.listen(stdout.add);
    int exitCode = await result.exitCode;
    exit(exitCode);
  }
}

final List<Map<String, dynamic>> schemes = [
  {
    "@type": "chatbotData",
    "id": 0,
    "prompt": "",
    "respond": "",
  },
];
