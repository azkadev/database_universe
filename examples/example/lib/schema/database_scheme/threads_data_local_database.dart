// ignore_for_file: non_constant_identifier_names, unnecessary_this, public_member_api_docs

// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:convert';
import 'package:database_universe/database_universe.dart';
part "threads_data_local_database.g.dart";

@collection
class ThreadsDataLocalDatabase {
  // Id id = DatabaseUniverse.autoIncrement;

  /// Generated Document Database Universe By General Lib
  String special_type = "threadsData";

  /// Generated Document Database Universe By General Lib
  int id = 0;

  /// Generated Document Database Universe By General Lib
  String threads_unique_id = "";

  /// Generated Document Database Universe By General Lib
  String thread = "";

  /// Generated Document Database Universe By General Lib
  int view_count = 0;

  /// Generated Document Database Universe By General Lib
  int thread_create_date = 0;

  /// Generated Document Database Universe By General Lib
  int thread_update_date = 0;

  /// operator map data
  operator [](key) {
    return toJson()[key];
  }

  /// operator map data
  void operator []=(key, value) {
    if (key == "@type") {
      this.special_type = value;
    }

    if (key == "id") {
      this.id = value;
    }

    if (key == "threads_unique_id") {
      this.threads_unique_id = value;
    }

    if (key == "thread") {
      this.thread = value;
    }

    if (key == "view_count") {
      this.view_count = value;
    }

    if (key == "thread_create_date") {
      this.thread_create_date = value;
    }

    if (key == "thread_update_date") {
      this.thread_update_date = value;
    }
  }

  /// return original data json
  Map utils_remove_values_null() {
    Map rawData = toJson();
    rawData.forEach((key, value) {
      if (value == null) {
        rawData.remove(key);
      }
    });
    return rawData;
  }

  /// return original data json
  Map utils_remove_by_values(List values) {
    Map rawData = toJson();
    rawData.forEach((key, value) {
      for (var element in values) {
        if (value == element) {
          rawData.remove(key);
        }
      }
    });

    return rawData;
  }

  /// return original data json
  Map utils_remove_by_keys(List keys) {
    Map rawData = toJson();
    for (var element in keys) {
      rawData.remove(element);
    }
    return rawData;
  }

  /// return original data json
  Map utils_filter_by_keys(List keys) {
    Map rawData = toJson();
    Map jsonData = {};
    for (var key in keys) {
      jsonData[key] = rawData[key];
    }
    return jsonData;
  }

  /// return original data json
  Map toMap() {
    return toJson();
  }

  /// return original data json
  Map toJson() {
    return {
      "@type": special_type,
      "id": id,
      "threads_unique_id": threads_unique_id,
      "thread": thread,
      "view_count": view_count,
      "thread_create_date": thread_create_date,
      "thread_update_date": thread_update_date,
    };
  }

  /// return string data encode json original data
  String toStringPretty() {
    return JsonEncoder.withIndent(" " * 2).convert(toJson());
  }

  /// return string data encode json original data
  @override
  String toString() {
    return json.encode(toJson());
  }

  /// return original data json
  static Map get defaultData {
    return {"@type": "threadsData", "id": 0, "threads_unique_id": "", "thread": "", "view_count": 0, "thread_create_date": 0, "thread_update_date": 0};
  }

  /// Generated Document Database Universe By General Lib
  static ThreadsDataLocalDatabase create({
    bool utils_is_print_data = false,
  }) {
    ThreadsDataLocalDatabase threadsDataLocalDatabase_data_create = ThreadsDataLocalDatabase();

    if (utils_is_print_data) {
      // print(threadsDataLocalDatabase_data_create.toStringPretty());
    }

    return threadsDataLocalDatabase_data_create;
  }
}
