// ignore_for_file: non_constant_identifier_names, unused_import
import "package:general_lib/general_lib.dart";
// import "dart:convert";

/// Generated
class ThreadsCommentData extends JsonScheme {
  /// Generated
  ThreadsCommentData(super.rawData);

  /// return default data
  ///
  static Map get defaultData {
    return {
      "@type": "threadsCommentData",
      "id": 0,
      "threads_unique_id": "",
      "comment": 0
    };
  }

  /// check data
  /// if raw data
  /// - rawData["@type"] == threadsCommentData
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

  /// create [ThreadsCommentData]
  /// Empty
  static ThreadsCommentData empty() {
    return ThreadsCommentData({});
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
  num? get comment {
    try {
      if (rawData["comment"] is num == false) {
        return null;
      }
      return rawData["comment"] as num;
    } catch (e) {
      return null;
    }
  }

  /// Generated
  set comment(num? value) {
    rawData["comment"] = value;
  }

  /// Generated
  static ThreadsCommentData create({
    bool schemeUtilsIsSetDefaultData = false,
    String special_type = "threadsCommentData",
    num? id,
    String? threads_unique_id,
    num? comment,
  }) {
    // ThreadsCommentData threadsCommentData = ThreadsCommentData({
    final Map threadsCommentData_data_create_json = {
      "@type": special_type,
      "id": id,
      "threads_unique_id": threads_unique_id,
      "comment": comment,
    };

    threadsCommentData_data_create_json
        .removeWhere((key, value) => value == null);

    if (schemeUtilsIsSetDefaultData) {
      defaultData.forEach((key, value) {
        if (threadsCommentData_data_create_json.containsKey(key) == false) {
          threadsCommentData_data_create_json[key] = value;
        }
      });
    }
    return ThreadsCommentData(threadsCommentData_data_create_json);
  }
}
