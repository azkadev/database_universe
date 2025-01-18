import 'dart:convert';

import 'package:example/core/dart/database/database.dart';
import 'package:general_framework/core/core.dart';
import 'package:general_lib/general_lib.dart';

///
class ExampleClient extends GeneralFrameworkClient<ExampleClientDatabase> {
  ///
  ExampleClient({
    required super.generalFrameworkDatabase,
    required super.generalLibrary,
    required super.generalFrameworkClientInvokeOptions,
    super.eventEmitter,
    super.eventInvoke,
    super.eventUpdate,
    super.httpClient,
  }) : super(
          apiUrl: "",
          networkClientConnectionType: NetworkClientConnectionType.http,
          pathApi: "",
          pathWebSocket: "",
        );

  @override
  String decryptData({required String data}) {
    return json.decode(data);
  }

  @override
  String encryptData({required Map data}) {
    return json.encode(data);
  }
}
