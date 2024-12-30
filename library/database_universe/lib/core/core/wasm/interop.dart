// ignore_for_file: public_member_api_docs, non_constant_identifier_names

import 'dart:js_interop';
import 'dart:typed_data';

@JS()
@staticInterop
class JSWindow {}

extension JSWIndowX on JSWindow {
  external JSDatabaseUniverse get database_universe;

  external JSWasm get WebAssembly;

  // external Object fetch(String url);
}

@JS()
@staticInterop
class JSWasm {}

// extension JSWasmX on JSWasm {
//   external Object instantiateStreaming(Object source, dynamic importObject);
// }

@JS()
@staticInterop
class JSWasmModule {}

extension JSWasmModuleX on JSWasmModule {
  external JSWasmInstance get instance;
}

@JS()
@staticInterop
class JSWasmInstance {}

extension JSWasmInstanceX on JSWasmInstance {
  external JSDatabaseUniverse get exports;
}

@JS()
@staticInterop
class JSDatabaseUniverse {}

extension JSDatabaseUniverseX on JSDatabaseUniverse {
  external JsMemory get memory;

  Uint8List get u8Heap => throw UnimplementedError();

  Uint16List get u16Heap => throw UnimplementedError();

  Uint32List get u32Heap => throw UnimplementedError();

  external int malloc(int byteCount);

  external void free(int ptrAddress);
}

@JS()
@staticInterop
class JsMemory {}

// @JS()
// @staticInterop
// extension on JsMemory {
//   external ByteBuffer get buffer;
// }
