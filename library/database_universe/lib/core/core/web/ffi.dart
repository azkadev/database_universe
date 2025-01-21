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
// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:database_universe/core/core/web/web.dart';
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
  Pointer<void> get ptrValue => b.u32Heap[address ~/ 4];

  @tryInline
  set ptrValue(Pointer<void> ptr) => b.u32Heap[address ~/ 4] = ptr;

  @tryInline
  void setPtrAt(int index, Pointer<void> ptr) {
    b.u32Heap[address ~/ 4 + index] = ptr;
  }

  @tryInline
  bool get boolValue => b.u8Heap[address] != 0;

  @tryInline
  int get u32Value => b.u32Heap[address ~/ 4];

  @tryInline
  int get address => this;

  @tryInline
  Uint8List asU8List(int length) =>
      b.u8Heap.buffer.asUint8List(address, length);

  @tryInline
  Uint16List asU16List(int length) =>
      b.u16Heap.buffer.asUint16List(address, length);
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
