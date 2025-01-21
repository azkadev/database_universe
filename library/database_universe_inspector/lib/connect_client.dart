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
// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:convert';

import 'package:database_universe/database_universe.dart';
import 'package:database_universe/core/core/database_universe_connect_api.dart';
import 'package:vm_service/vm_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

export 'package:database_universe/core/core/database_universe_connect_api.dart';

///
class ConnectClient {
  ///
  ConnectClient(this.vmService, this.isolateId);

  ///
  static const Duration kNormalTimeout = Duration(seconds: 4);

  ///
  static const Duration kLongTimeout = Duration(seconds: 10);

  ///
  final VmService vmService;

  ///
  final String isolateId;

  ///
  final collectionInfo = <String, ConnectCollectionInfoPayload>{};

  final _instancesChangedController = StreamController<void>.broadcast();
  final _collectionInfoChangedController = StreamController<void>.broadcast();
  final _queryChangedController = StreamController<void>.broadcast();

  ///
  Stream<void> get instancesChanged => _instancesChangedController.stream;

  ///
  Stream<void> get collectionInfoChanged =>
      _collectionInfoChangedController.stream;

  ///
  Stream<void> get queryChanged => _queryChangedController.stream;

  ///
  static Future<ConnectClient> connect(String port, String secret) async {
    final wsUrl = Uri.parse('ws://127.0.0.1:$port/$secret=/ws');
    final channel = WebSocketChannel.connect(wsUrl);

    // ignore: avoid_print
    final stream = channel.stream.handleError(print);

    final service = VmService(
      stream,
      channel.sink.add,
      disposeHandler: channel.sink.close,
    );
    final vm = await service.getVM();
    final isolateId = vm.isolates!.where((e) => e.name == 'main').first.id!;
    await service.streamListen(EventStreams.kExtension);

    final client = ConnectClient(service, isolateId);
    final handlers = {
      ConnectEvent.instancesChanged.event: (_) {
        client._instancesChangedController.add(null);
      },
      ConnectEvent.collectionInfoChanged.event: (Map<String, dynamic> json) {
        final collectionInfo = ConnectCollectionInfoPayload.fromJson(json);
        client.collectionInfo[collectionInfo.collection] = collectionInfo;
        client._collectionInfoChangedController.add(null);
      },
      ConnectEvent.queryChanged.event: (_) {
        client._queryChangedController.add(null);
      },
    };
    service.onExtensionEvent.listen((Event event) {
      final data = event.extensionData?.data ?? {};
      handlers[event.extensionKind]?.call(data);
    });

    return client;
  }

  Future<Map<String, dynamic>?> _call(
    ConnectAction action, {
    Duration? timeout = kNormalTimeout,
    dynamic param,
  }) async {
    var responseFuture = vmService.callServiceExtension(
      action.method,
      isolateId: isolateId,
      args: {
        if (param != null) 'args': jsonEncode(param),
      },
    );
    if (timeout != null) {
      responseFuture = responseFuture.timeout(timeout);
    }

    final response = await responseFuture;
    return response.json?['result'] as Map<String, dynamic>?;
  }

  ///

  Future<List<DatabaseUniverseSchema>> getSchemas(String instance) async {
    final json = await _call(
      ConnectAction.getSchemas,
      param: ConnectInstancePayload(instance),
    );
    return ConnectSchemasPayload.fromJson(json!).schemas;
  }

  ///
  Future<List<String>> listInstances() async {
    final json = await _call(ConnectAction.listInstances);
    return ConnectInstanceNamesPayload.fromJson(json!).instances;
  }

  ///
  Future<void> watchInstance(String instance) async {
    collectionInfo.clear();
    await _call(
      ConnectAction.watchInstance,
      param: ConnectInstancePayload(instance),
    );
  }

  ///
  Future<ConnectObjectsPayload> executeQuery(ConnectQueryPayload query) async {
    final json = await _call(
      ConnectAction.executeQuery,
      param: query,
      timeout: kLongTimeout,
    );
    return ConnectObjectsPayload.fromJson(json!);
  }

  ///
  Future<void> deleteQuery(ConnectQueryPayload query) async {
    await _call(
      ConnectAction.deleteQuery,
      param: query,
      timeout: kLongTimeout,
    );
  }

  ///
  Future<void> importJson(ConnectObjectsPayload objects) async {
    await _call(ConnectAction.importJson, param: objects);
  }

  ///

  Future<ConnectObjectsPayload> exportJson(ConnectQueryPayload query) async {
    final json = await _call(
      ConnectAction.exportJson,
      param: query,
      timeout: kLongTimeout,
    );
    return ConnectObjectsPayload.fromJson(json!);
  }

  ///

  Future<void> editProperty(ConnectEditPayload edit) async {
    await _call(
      ConnectAction.editProperty,
      param: edit,
      timeout: kLongTimeout,
    );
  }

  ///

  Future<void> disconnect() async {
    await vmService.dispose();
  }
}
