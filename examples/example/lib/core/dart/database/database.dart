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
// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:database_universe/database_universe.dart';
import 'package:example/schema/database_scheme/chatbot_data_local_database.dart';
import 'package:general_framework/core/database/database_core.dart';
import 'package:general_lib/general_lib.dart';
import 'package:http/http.dart';
import "package:path/path.dart" as path;

///
class ExampleClientDatabase extends GeneralFrameworkDatabase {
  ///
  final Completer<bool> completerEnsureInitialized = Completer<bool>();
  bool _isLoadingEnsureInitialized = false;

  ///
  late final DatabaseUniverse databaseUniverseCore;

  @override
  Directory get directory_base {
    final Directory directory = Directory(path.join(currentPath, "example_database"));
    return directory;
  }

  ///
  Directory get directory_database {
    final Directory directory = Directory(path.join(directory_base.path, "general_database"));
    if (Dart.isWeb) {
      return directory;
    }
    if (directory.existsSync() == false) {
      directory.createSync(recursive: true);
    }
    return directory;
  }

  ///
  Directory get directory_files {
    final Directory directory = Directory(path.join(directory_base.path, "general_files"));
    if (Dart.isWeb) {
      return directory;
    }
    if (directory.existsSync() == false) {
      directory.createSync(recursive: true);
    }
    return directory;
  }

  ///
  Directory get directory_temp {
    final Directory directory = Directory(path.join(directory_base.path, "general_temp"));
    if (Dart.isWeb) {
      return directory;
    }
    if (directory.existsSync() == false) {
      directory.createSync(recursive: true);
    }
    return directory;
  }

  @override
  void ensureInitializedDatabase() {
    {
      directory_database;
      directory_files;
      directory_temp;
    }
  }

  @override
  FutureOr<void> ensureInitialized({required String currentPath, required Client httpClient}) async {
    if (_isLoadingEnsureInitialized) {
      if (completerEnsureInitialized.isCompleted == false) {
        await completerEnsureInitialized.future;
      }
      return;
    }
    _isLoadingEnsureInitialized = true;
    await super.ensureInitialized(
      currentPath: currentPath,
      httpClient: httpClient,
    );

    databaseUniverseCore = await openIsar(
      name: "core",
      maxSizeMiB: null,
    );
    return;
  }

  ////
  Future<DatabaseUniverse> openIsar({
    required String name,
    required int? maxSizeMiB,
  }) async {
    int try_count = 0;
    while (true) {
      await Future.delayed(Duration(milliseconds: 1));
      try_count++;
      try {
        return DatabaseUniverse.open(
          schemas: [
            ChatbotDataLocalDatabaseSchema,
          ],
          directory: directory_database.path,
          name: name,
          maxSizeMiB: maxSizeMiB ?? DatabaseUniverse.defaultMaxSizeMiB * 100,
        );
      } catch (e) {
        if (try_count > 2) {
          rethrow;
        }
        for (var element in [
          File(path.join(directory_database.path, "${name}.isar")),
          File(path.join(directory_database.path, "${name}.isar.lock")),
        ]) {
          if (element.existsSync()) {
            element.deleteSync(recursive: true);
          }
        }
      }
    }
  }
}
