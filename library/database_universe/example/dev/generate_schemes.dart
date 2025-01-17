import 'dart:io';
import 'package:general_lib/general_lib.dart';
import "package:path/path.dart" as path;

void main(List<String> args) async {
  final Directory directoryCurrent = Directory.current;
  final Directory directorySchemes =
      Directory(path.join(directoryCurrent.path, "lib", "schema"));
  directorySchemes.generalLibUtilsDangerRecreate();
  {
    await jsonToScripts(
      schemes,
      directory: Directory(path.join(directorySchemes.path, "scheme"))
          .generalLibUtilsDangerRecreate(),
    );
  }
  {
    final Directory directoryDatabaseScheme =
        Directory(path.join(directorySchemes.path, "database_scheme"))
            .generalLibUtilsDangerRecreate();
    for (final element in schemes) {
      final generateSchema = jsonToDatabaseUniverse(
        element,
        className:
            "${element["@type"]}${GeneralLibSchemeType.local.toSpesialType()}",
        isarVersion: 4,
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
  {
    "@type": "threadsData",
    "id": 0,
    "threads_unique_id": "",
    "thread": "",
    "view_count": 0,
    "thread_create_date": 0,
    "thread_update_date": 0,
  },
  {
    "@type": "threadsCommentData",
    "id": 0,
    "threads_unique_id": "",
    "comment": 0,
  },
];
