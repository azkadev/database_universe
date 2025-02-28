// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

/// Generated
class ThreadsData extends JsonScheme {
  /// Generated
  ThreadsData(super.rawData);

  /// return default data
  ///
  static Map get defaultData {
    return {"@type": "threadsData", "id": 0, "threads_unique_id": "", "thread": "", "view_count": 0, "thread_create_date": 0, "thread_update_date": 0};
  }

  /// check data
  /// if raw data
  /// - rawData["@type"] == threadsData
  /// if same return true
  bool json_scheme_utils_checkDataIsSameBySpecialType() {
    return rawData["@type"] == defaultData["@type"];
  }

  /// check value data whatever do yout want
  bool json_scheme_utils_checkDataIsSameBuilder({
    required bool Function(Map rawData, Map defaultData) onResult,
  }) {
    return onResult(rawData["@type"], defaultData["@type"]);
  }

  /// create [ThreadsData]
  /// Empty
  static ThreadsData empty() {
    return ThreadsData({});
  }

  /// Generated
  String? get special_type {
    try {
      if (rawData["@type"] is String == false) {
        return null;
      }
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set special_type(String? value) {
    rawData["@type"] = value;
  }

  /// Generated
  num? get id {
    try {
      if (rawData["id"] is num == false) {
        return null;
      }
      return rawData["id"] as num;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set id(num? value) {
    rawData["id"] = value;
  }

  /// Generated
  String? get threads_unique_id {
    try {
      if (rawData["threads_unique_id"] is String == false) {
        return null;
      }
      return rawData["threads_unique_id"] as String;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set threads_unique_id(String? value) {
    rawData["threads_unique_id"] = value;
  }

  /// Generated
  String? get thread {
    try {
      if (rawData["thread"] is String == false) {
        return null;
      }
      return rawData["thread"] as String;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set thread(String? value) {
    rawData["thread"] = value;
  }

  /// Generated
  num? get view_count {
    try {
      if (rawData["view_count"] is num == false) {
        return null;
      }
      return rawData["view_count"] as num;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set view_count(num? value) {
    rawData["view_count"] = value;
  }

  /// Generated
  num? get thread_create_date {
    try {
      if (rawData["thread_create_date"] is num == false) {
        return null;
      }
      return rawData["thread_create_date"] as num;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set thread_create_date(num? value) {
    rawData["thread_create_date"] = value;
  }

  /// Generated
  num? get thread_update_date {
    try {
      if (rawData["thread_update_date"] is num == false) {
        return null;
      }
      return rawData["thread_update_date"] as num;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set thread_update_date(num? value) {
    rawData["thread_update_date"] = value;
  }

  /// Generated
  static ThreadsData create({
    bool schemeUtilsIsSetDefaultData = false,
    String special_type = "threadsData",
    num? id,
    String? threads_unique_id,
    String? thread,
    num? view_count,
    num? thread_create_date,
    num? thread_update_date,
  }) {
    // ThreadsData threadsData = ThreadsData({
    final Map threadsData_data_create_json = {
      "@type": special_type,
      "id": id,
      "threads_unique_id": threads_unique_id,
      "thread": thread,
      "view_count": view_count,
      "thread_create_date": thread_create_date,
      "thread_update_date": thread_update_date,
    };

    threadsData_data_create_json.removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (threadsData_data_create_json.containsKey(key) == false) {
          threadsData_data_create_json[key] = value;
        }
      });
    }
    return ThreadsData(threadsData_data_create_json);
  }
}
