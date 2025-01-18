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
""".trim(),
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
