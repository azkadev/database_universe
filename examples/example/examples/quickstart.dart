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
// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:database_universe/database_universe.dart';
import 'package:example/schema/database_scheme/chatbot_data_local_database.dart';
import 'package:general_lib/log/log.dart';

void main() async {
  final GeneralLibraryLog generalLibraryLog = GeneralLibraryLog(logOptions: GeneralLibraryLogOptions(textTitle: "", textContext: ""));
  await DatabaseUniverse.initialize();
  final DatabaseUniverse databaseUniverse = DatabaseUniverse.open(
    schemas: [
      ChatbotDataLocalDatabaseSchema,
    ],
    directory: "temp",
  );
  final String prompt = "hello";
  final String respond = "Hello Babe";
  generalLibraryLog.printToTerminal(
    logMessage: GeneralLibraryLogMessage(
      value: "Get Data: ${prompt}",
      isForcePrint: false,
      stackTrace: StackTrace.current,
      isFullDetail: false,
      logMessageType: GeneralLibraryLogMessageType.info,
      logOptions: null,
    ),
  );

  final ChatbotDataLocalDatabase? chatbotDataLocalDatabaseOld = databaseUniverse.chatbotDataLocalDatabases.where().promptMatches(prompt, caseSensitive: false).findFirst();
  if (chatbotDataLocalDatabaseOld == null) {
    generalLibraryLog.printToTerminal(
      logMessage: GeneralLibraryLogMessage(
        value: "Data Prompt Not Found: ${prompt} ",
        isForcePrint: false,
        stackTrace: StackTrace.current,
        isFullDetail: false,
        logMessageType: GeneralLibraryLogMessageType.info,
        logOptions: null,
      ),
    );
    final ChatbotDataLocalDatabase chatbotDataLocalDatabaseNew = ChatbotDataLocalDatabase();
    chatbotDataLocalDatabaseNew.id = databaseUniverse.chatbotDataLocalDatabases.autoIncrement();
    chatbotDataLocalDatabaseNew.prompt = prompt;
    chatbotDataLocalDatabaseNew.respond = respond;
    databaseUniverse.write((databaseUniverse) {
      databaseUniverse.chatbotDataLocalDatabases.put(chatbotDataLocalDatabaseNew);
      return;
    });
  } else {
    generalLibraryLog.printToTerminal(
      logMessage: GeneralLibraryLogMessage(
        value: "Data Prompt Found: ${prompt} ",
        isForcePrint: false,
        stackTrace: StackTrace.current,
        isFullDetail: false,
        logMessageType: GeneralLibraryLogMessageType.info,
        logOptions: null,
      ),
    );
    generalLibraryLog.printToTerminal(
      logMessage: GeneralLibraryLogMessage(
        value: """
Data Detail

Prompt: ${chatbotDataLocalDatabaseOld.prompt}
Respond: ${chatbotDataLocalDatabaseOld.respond}
"""
            .trim(),
        isForcePrint: false,
        stackTrace: StackTrace.current,
        isFullDetail: false,
        logMessageType: GeneralLibraryLogMessageType.info,
        logOptions: null,
      ),
    );
  }
  exit(0);
}
