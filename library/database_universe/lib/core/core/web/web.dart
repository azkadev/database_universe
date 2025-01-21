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
// ignore_for_file: public_member_api_docs, avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html';
import 'dart:js_util';

import 'package:database_universe/core/core/web/interop.dart';

export 'bindings.dart';
export 'ffi.dart';
export 'interop.dart';

FutureOr<DatabaseUniverseCoreBindings> initializePlatformBindings([
  String? library,
]) async {
  final url = library ?? 'database_universe.wasm';
  final w = window as JSWindow;
  final promise = w.WebAssembly.instantiateStreaming(
    w.fetch(url),
    jsify({'env': <String, String>{}}),
  );
  final wasm = await promiseToFuture<JSWasmModule>(promise);
  return wasm.instance.exports;
}

typedef DatabaseUniverseCoreBindings = JSDatabaseUniverse;

const tryInline = pragma('dart2js:tryInline');

class ReceivePort extends Stream<dynamic> {
  final sendPort = SendPort();

  @override
  StreamSubscription<void> listen(
    void Function(dynamic event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    throw UnimplementedError();
  }

  void close() {
    throw UnimplementedError();
  }
}

class SendPort {
  int get nativePort => 0;

  void send(dynamic message) {
    throw UnimplementedError();
  }
}

int platformFastHash(String str) {
  var i = 0;
  var t0 = 0;
  var v0 = 0x2325;
  var t1 = 0;
  var v1 = 0x8422;
  var t2 = 0;
  var v2 = 0x9ce4;
  var t3 = 0;
  var v3 = 0xcbf2;

  while (i < str.length) {
    v0 ^= str.codeUnitAt(i++);
    t0 = v0 * 435;
    t1 = v1 * 435;
    t2 = v2 * 435;
    t3 = v3 * 435;
    t2 += v0 << 8;
    t3 += v1 << 8;
    t1 += t0 >>> 16;
    v0 = t0 & 65535;
    t2 += t1 >>> 16;
    v1 = t1 & 65535;
    v3 = (t3 + (t2 >>> 16)) & 65535;
    v2 = t2 & 65535;
  }

  return (v3 & 15) * 281474976710656 +
      v2 * 4294967296 +
      v1 * 65536 +
      (v0 ^ (v3 >> 4));
}

@tryInline
Future<T> runIsolate<T>(
  String debugName,
  FutureOr<T> Function() computation,
) async {
  return computation();
}
