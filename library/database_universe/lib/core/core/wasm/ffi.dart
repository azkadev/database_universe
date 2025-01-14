// ignore_for_file: public_member_api_docs, invalid_runtime_check_with_js_interop_types

// import 'dart:typed_data';

import 'dart:typed_data';

import 'package:database_universe/core/core/wasm/wasm.dart';
import 'package:database_universe/database_universe.dart';

typedef Pointer<T> = int;

class NativeType {}

@tryInline
Pointer<T> ptrFromAddress<T>(int addr) => addr;

// ignore: unnecessary_late
late final JSDatabaseUniverse b = DatabaseUniverseCore.b as JSDatabaseUniverse;

extension PointerX on int {
  @tryInline
  Pointer<T> cast<T>() => this;

  @tryInline
  Pointer<void> get ptrValue => throw UnimplementedError();

  @tryInline
  set ptrValue(Pointer<void> ptr) {}

  @tryInline
  void setPtrAt(int index, Pointer<void> ptr) {
    // b.u32Heap[address ~/ 4 + index] = ptr;
  }

  @tryInline
  bool get boolValue {
    return true;
  }

  @tryInline
  int get u32Value {
    return 0;
  }

  @tryInline
  int get address => this;

  @tryInline
  Uint8List asU8List(int length) {
    throw UnimplementedError();
  }

  @tryInline
  Uint16List asU16List(int length) {
    throw UnimplementedError();
  }
}

const nullptr = 0;

class Native<T> {
  // ignore: avoid_unused_constructor_parameters
  const Native({String? symbol});
}

class Void {}

class Bool {}

class Uint8 {}

class Int8 {}

class Uint16 {}

class Uint32 {}

typedef Char = Uint8;

class Int32 {}

class Int64 {}

class Float {}

class Double {}

class Opaque {}

class NativeFunction<T> {}

const _sizes = {
  int: 4, // pointer
  Void: 0,
  Bool: 1,
  Uint8: 1,
  Int8: 1,
  Uint16: 2,
  Uint32: 4,
  Int32: 4,
  Int64: 8,
  Float: 4,
  Double: 8,
};

Pointer<T> malloc<T>([int length = 1]) {
  final addr = b.malloc(length * _sizes[T]!);
  return addr;
}

void free(Pointer<void> ptr) {
  b.free(ptr.address);
}
