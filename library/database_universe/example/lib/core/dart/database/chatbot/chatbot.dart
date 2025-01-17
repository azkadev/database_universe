import 'package:database_universe/database_universe.dart';
import 'package:example/core/dart/database/database.dart';
import 'package:example/schema/database_scheme/chatbot_data_local_database.dart';

///
extension ChatbotExtensionExampleClientFlutter on ExampleClientDatabase {
  ///
  /// ```dart
  /// final respond = getRespondFromPromptText(
  ///   text: "Hello"
  /// );
  /// if (respond.isNotEmpty){
  ///
  /// }
  /// ```
  ///
  String getRespondFromPromptText({
    required String prompt,
  }) {
    final dataOld =
        databaseUniverseCore.chatbotDataLocalDatabases.where().anyOf([
      prompt,
    ], (e, value) {
      return e.promptMatches(value, caseSensitive: false).respondIsNotEmpty();
    }).findFirst();
    if (dataOld == null) {
      return "";
    }
    return dataOld.respond.trim();
  }

  ///
  bool savePromptAndRespond({
    required String prompt,
    required String respond,
  }) {
    final chatbotDataLocalDatabaseOld = databaseUniverseCore
        .chatbotDataLocalDatabases
        .where()
        .promptMatches(prompt, caseSensitive: false)
        .findFirst();
    if (chatbotDataLocalDatabaseOld == null) {
      final ChatbotDataLocalDatabase chatbotDataLocalDatabaseNew =
          ChatbotDataLocalDatabase();
      chatbotDataLocalDatabaseNew.id =
          databaseUniverseCore.chatbotDataLocalDatabases.autoIncrement();
      chatbotDataLocalDatabaseNew.prompt = prompt;
      chatbotDataLocalDatabaseNew.respond = respond;
      databaseUniverseCore.write((databaseUniverseCore) {
        databaseUniverseCore.chatbotDataLocalDatabases
            .put(chatbotDataLocalDatabaseNew);
        return;
      });
      return true;
    }
    chatbotDataLocalDatabaseOld.respond = respond;
    databaseUniverseCore.write((databaseUniverseCore) {
      databaseUniverseCore.chatbotDataLocalDatabases
          .put(chatbotDataLocalDatabaseOld);
      return;
    });
    return true;
  }
}
