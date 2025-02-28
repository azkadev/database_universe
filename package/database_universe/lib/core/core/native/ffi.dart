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

import 'package:database_universe/core/core/native/native.dart';
import 'package:ffi/ffi.dart' as ffi;

export 'dart:ffi';

export 'package:ffi/ffi.dart';

@tryInline
Pointer<T> ptrFromAddress<T extends NativeType>(int addr) =>
    Pointer.fromAddress(addr);

extension PointerPointerX<T extends NativeType> on Pointer<Pointer<T>> {
  @tryInline
  Pointer<T> get ptrValue => value;

  @tryInline
  set ptrValue(Pointer<T> ptr) => value = ptr;

  @tryInline
  void setPtrAt(int index, Pointer<T> ptr) {
    this[index] = ptr;
  }
}

extension PointerBoolX on Pointer<Bool> {
  @tryInline
  bool get boolValue => value;
}

extension PointerU8X on Pointer<Uint8> {
  @tryInline
  Uint8List asU8List(int length) => asTypedList(length);
}

extension PointerUint16X on Pointer<Uint16> {
  @tryInline
  Uint16List asU16List(int length) => asTypedList(length);
}

extension PointerUint32X on Pointer<Uint32> {
  @tryInline
  int get u32Value => value;
}

const malloc = ffi.malloc;
final free = ffi.malloc.free;
