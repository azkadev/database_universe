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
2. [Youtube](https://youtube.com/)
3. [Telegram Support Group](https://t.me/)
4. [Contact Developer](https://github.com/) (check social media or readme profile github)

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
// ignore_for_file: non_constant_identifier_names
import 'dart:io';
import 'package:database_universe/database_universe.dart';
import 'package:general_lib/general_lib.dart';
import 'package:path/path.dart' as path;

void main(List<String> args) async {
  print("start");
  /// add database
  DatabaseUniverse databaseUniverse = DatabaseUniverse(
    // change extension with your own
    extension_name: "dbu",
    // if set true if open database password wrong force open but database will empty
    is_ignore_on_error: true,
  );
  // init database
  databaseUniverse.init(crypto: Crypto(key: "od8wkk8nYbgv2na8ApaL0NMGq3rcpnF5"));
  // set database directory
  Directory directory_db = () {
    if (Dart.isWeb) {
      return Directory("");
    }
    return Directory(path.join(Directory.current.path, "db"));
  }();
  print("open");
  // open disk database
  DatabaseUniverseData<JsonScheme> databaseUniverseData = databaseUniverse.disk_open(file_name: "Slebew", directory: directory_db, valueData: JsonScheme({}));
  // change value
  print("update");
  databaseUniverseData.value["first_name"] = "change name";
  // check if key count is not int set to int 0
  if (databaseUniverseData.value["count"] is int == false) {
    databaseUniverseData.value["count"] = 0;
  }
  // increament
  databaseUniverseData.value["count"] += 1;
  // save to disk
  databaseUniverse.disk_save(databaseUniverseData: databaseUniverseData, isWithClose: true);
  print("saved");
}
``` 