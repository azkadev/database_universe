# Database Universe
 
**Database Universe** this open source project is free 

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