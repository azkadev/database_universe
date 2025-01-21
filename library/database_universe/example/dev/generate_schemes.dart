/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
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
