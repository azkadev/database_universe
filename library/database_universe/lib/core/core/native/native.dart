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
FutureOr<DatabaseUniverseCoreBindings> initializePlatformBindings([String? library]) {
  late DatabaseUniverseCoreBindings bindings;
  try {
    library ??= Platform.isIOS ? null : library ?? Abi.current().localName;

    final dylib = Platform.isIOS ? DynamicLibrary.process() : DynamicLibrary.open(library!);
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

  final coreVersion = bindings.database_universe_version().cast<Utf8>().toDartString();
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
