# Database Universe
<p align="center">
  <img src="https://raw.githubusercontent.com/azkadev/database_universe/refs/heads/main/package/database_universe/assets/database_universe.png" width="350px">
</p>
<h2 align="center">Ultra Fast, Enjoyable & Cross Platform Database Universe</h2>

[![](https://raw.githubusercontent.com/globalcorporation/.github/main/.github/logo/powered.png)](https://www.youtube.com/@Global_Corporation)

[![Pub Version](https://img.shields.io/pub/v/database_universe?label=pub.dev&labelColor=333940&logo=dart)](https://pub.dev/packages/database_universe)


**Database Universe**  Library for help you save any data in anywhere with high performance speed, easy feature and ready for scala business

## Features

- 🚀 **Work On Cross Platform**: Mobile, Desktop, Browser, Server Side
- ⚡ **Good Performance and efficient**
- ❤️ **Simple, Easey Powerfull, Can Extend To Scala Bussiness**

### Information

This Library only update if there ae feature that i want, if you want library with full documentation so it usually **makes things easier DEVELOP PROGRAM** you just need to buy / donate at [Azkadev](https://github.com/sponsors/azkadev)

## <img src="https://raw.githubusercontent.com/azkadev/telegram_client/main/.github/assets/bluetick.png" width="30px" height="30px" align="center" > Fact

- This library is **very fast** and can be created on a business scale

## Example Project Use This Library

## Demo

## 📚️ Docs

1. [Documentation](/docs/)
2. [Youtube](https://youtube.com/@azkadev)
3. [Telegram Support Group](https://t.me/DEVELOPER_GLOBAL_PUBLIC)
4. [Contact Developer](https://github.com/azkadev) (check social media or readme profile github)

## 🔖️ Features

1. [x] 📱️ **Cross Platform** support (Device, Web)
2. [x] 📜️ **Standarization** Style Code
3. [x] ⌨️ **Cli** (Terminal for help you use this library or create project)
4. [x] 🔥️ **Api** (If you developer bot / userbot you can use this library without interact cli just add library and use 🚀️)
5. [ ] 🧩️ **Customizable Extension** (if you want add extension so you can more speed up on development)
6. [ ] ✨️ **Pretty Information** (user friendly for newbie)
 
## ❔️ Fun Fact

**This library 100%** use on every my create project (**App, Server, Bot, Userbot**)
 
## 📈️ Proggres
 
- **2024-05-11**

## Guide on how to use this library

Before using this library, make sure you know basic coding
And your laptop has the programming language installed [dart](https://dart.dev)

### 📥️ Install Library

1. **Dart**

```bash
dart pub add database_universe
```

## 🚀️ Quick Start

Example Quickstart script minimal for insight you or make you use this library because very simple 
 
```dart
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
``` 

Example Generate Schema script minimal for insight you or make you use this library because very simple 
 
```dart
import 'dart:io';
import 'package:general_lib/general_lib.dart';
import "package:path/path.dart" as path;

void main(List<String> args) async {
  final Directory directoryCurrent = Directory.current;
  final Directory directorySchemes = Directory(path.join(directoryCurrent.path, "lib", "schema"));
  directorySchemes.generalLibUtilsDangerRecreate();
  {
    final Directory directoryDatabaseScheme = Directory(path.join(directorySchemes.path, "database_scheme")).generalLibUtilsDangerRecreate();
    for (final element in schemes) {
      final generateSchema = jsonToDatabaseUniverse(
        element,
        className: "${element["@type"]}${GeneralLibSchemeType.local.toSpesialType()}",
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

``` 