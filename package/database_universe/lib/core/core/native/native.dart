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
import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:database_universe/core/core/native/bindings.dart';
import 'package:database_universe/database_universe.dart';
import 'package:ffi/ffi.dart';

export 'dart:isolate';

export 'bindings.dart';
export 'ffi.dart';

/// @nodoc
FutureOr<DatabaseUniverseCoreBindings> initializePlatformBindings(
    [String? library]) {
  late DatabaseUniverseCoreBindings bindings;
  try {
    library ??= Platform.isIOS ? null : library ?? Abi.current().localName;

    final dylib = Platform.isIOS
        ? DynamicLibrary.process()
        : DynamicLibrary.open(library!);
    bindings = DatabaseUniverseCoreBindings(dylib);
  } catch (e) {
    throw DatabaseUniverseNotReadyError(
      'Could not initialize DatabaseUniverseCore library for processor architecture '
      '"${Abi.current()}". If you create a Flutter app, make sure to add '
      'database_universe_flutter_libs to your dependencies. For Dart-only apps or unit '
      'tests, make sure to place the correct DatabaseUniverse binary in the correct '
      'directory.\n$e',
    );
  }

  final coreVersion =
      bindings.database_universe_version().cast<Utf8>().toDartString();
  if (coreVersion != DatabaseUniverse.version && coreVersion != 'debug') {
    throw DatabaseUniverseNotReadyError(
      'Incorrect DatabaseUniverse Core version: Required ${DatabaseUniverse.version} found '
      '$coreVersion. Make sure to use the latest database_universe_flutter_libs. If you '
      'have a Dart only project, make sure that old DatabaseUniverse Core binaries are '
      'deleted.',
    );
  }

  bindings.database_universe_connect_dart_api(NativeApi.initializeApiDLData);

  return bindings;
}

/// @nodoc
const tryInline = pragma('vm:prefer-inline');

extension on Abi {
  String get localName {
    switch (Abi.current()) {
      case Abi.androidArm:
      case Abi.androidArm64:
      case Abi.androidX64:
        return 'libdatabase_universe.so';
      case Abi.macosArm64:
      case Abi.macosX64:
        return 'libdatabase_universe.dylib';
      case Abi.linuxX64:
        return 'libdatabase_universe.so';
      case Abi.windowsArm64:
      case Abi.windowsX64:
        return 'database_universe.dll';
      case Abi.androidIA32:
        throw DatabaseUniverseNotReadyError(
          'Unsupported processor architecture. X86 Android emulators are not '
          'supported. Please use an x86_64 emulator instead. All physical '
          'Android devices are supported including 32bit ARM.',
        );
      default:
        throw DatabaseUniverseNotReadyError(
          'Unsupported processor architecture "${Abi.current()}". '
          'Please open an issue on GitHub to request it.',
        );
    }
  }
}

/// @nodoc
int platformFastHash(String string) {
  // ignore: avoid_js_rounded_ints
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}

/// @nodoc
@tryInline
Future<T> runIsolate<T>(
  String debugName,
  FutureOr<T> Function() computation,
) {
  return Isolate.run(computation, debugName: debugName);
}
