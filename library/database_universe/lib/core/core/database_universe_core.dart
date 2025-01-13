// ignore_for_file: public_member_api_docs
part of "package:database_universe/core/core.dart";
// part of "package:database_universe/core/core.dart";

/// @nodoc
abstract final class DatabaseUniverseCore {
  static const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

  static var _initialized = false;
  static String? _library;

  static late final DatabaseUniverseCoreBindings b;

  static Pointer<Pointer<NativeType>> ptrPtr = malloc<Pointer<NativeType>>();
  static Pointer<Uint32> countPtr = malloc<Uint32>();
  static Pointer<Bool> boolPtr = malloc<Bool>();

  static final Pointer<Pointer<Uint8>> stringPtrPtr =
      ptrPtr.cast<Pointer<Uint8>>();
  static Pointer<Uint8> get stringPtr => stringPtrPtr.ptrValue;

  static final Pointer<Pointer<CDatabaseUniverseReader>> readerPtrPtr =
      ptrPtr.cast<Pointer<CDatabaseUniverseReader>>();
  static Pointer<CDatabaseUniverseReader> get readerPtr =>
      readerPtrPtr.ptrValue;

  static Pointer<Uint16> _nativeStringPtr = nullptr;
  static int _nativeStringPtrLength = 0;

  static FutureOr<void> _initialize({
    String? library,
    bool explicit = false,
  }) {
    if (_initialized) {
      return null;
    }

    if (kIsWeb && !explicit) {
      throw DatabaseUniverseNotReadyError(
          'On web you have to call DatabaseUniverse.initialize() '
          'manually before using DatabaseUniverse.');
    }

    final result = initializePlatformBindings(library);
    if (result is Future) {
      return (result as Future<DatabaseUniverseCoreBindings>).then((bindings) {
        b = bindings;
        _library = library;
        _initialized = true;
      });
    } else {
      b = result;
      _library = library;
      _initialized = true;
    }
  }

  static void _free() {
    free(ptrPtr);
    free(countPtr);
    free(boolPtr);
    if (!_nativeStringPtr.isNull) {
      free(_nativeStringPtr);
    }
  }

  static Pointer<CString> _toNativeString(String str) {
    if (_nativeStringPtrLength < str.length) {
      if (_nativeStringPtr != nullptr) {
        free(_nativeStringPtr);
      }
      _nativeStringPtr = malloc<Uint16>(str.length);
      _nativeStringPtrLength = str.length;
    }

    final list = _nativeStringPtr.asU16List(str.length);
    for (var i = 0; i < str.length; i++) {
      list[i] = str.codeUnitAt(i);
    }

    return b.database_universe_string(_nativeStringPtr, str.length);
  }

  @tryInline
  static int readId(Pointer<CDatabaseUniverseReader> reader) {
    return b.database_universe_read_id(reader);
  }

  @tryInline
  static bool readNull(Pointer<CDatabaseUniverseReader> reader, int index) {
    return b.database_universe_read_null(reader, index) != 0;
  }

  @tryInline
  static bool readBool(Pointer<CDatabaseUniverseReader> reader, int index) {
    return b.database_universe_read_bool(reader, index) != 0;
  }

  @tryInline
  static int readByte(Pointer<CDatabaseUniverseReader> reader, int index) {
    return b.database_universe_read_byte(reader, index);
  }

  @tryInline
  static int readInt(Pointer<CDatabaseUniverseReader> reader, int index) {
    return b.database_universe_read_int(reader, index);
  }

  @tryInline
  static double readFloat(Pointer<CDatabaseUniverseReader> reader, int index) {
    return b.database_universe_read_float(reader, index);
  }

  @tryInline
  static int readLong(Pointer<CDatabaseUniverseReader> reader, int index) {
    return b.database_universe_read_long(reader, index);
  }

  @tryInline
  static double readDouble(Pointer<CDatabaseUniverseReader> reader, int index) {
    return b.database_universe_read_double(reader, index);
  }

  @tryInline
  static String? readString(
    Pointer<CDatabaseUniverseReader> reader,
    int index,
  ) {
    final length =
        b.database_universe_read_string(reader, index, stringPtrPtr, boolPtr);
    if (stringPtr.isNull) {
      return null;
    } else {
      final bytes = stringPtr.asU8List(length);
      if (boolPtr.boolValue) {
        return String.fromCharCodes(bytes);
      } else {
        return utf8.decode(bytes);
      }
    }
  }

  @tryInline
  static Pointer<CDatabaseUniverseReader> readObject(
    Pointer<CDatabaseUniverseReader> reader,
    int index,
  ) {
    return b.database_universe_read_object(reader, index);
  }

  @tryInline
  static int readList(
    Pointer<CDatabaseUniverseReader> reader,
    int index,
    Pointer<Pointer<CDatabaseUniverseReader>> listReader,
  ) {
    return b.database_universe_read_list(reader, index, listReader);
  }

  @tryInline
  static void freeReader(Pointer<CDatabaseUniverseReader> reader) {
    b.database_universe_read_free(reader);
  }

  @tryInline
  static void writeNull(Pointer<CDatabaseUniverseWriter> writer, int index) {
    b.database_universe_write_null(writer, index);
  }

  @tryInline
  static void writeBool(
    Pointer<CDatabaseUniverseWriter> writer,
    int index,
    bool value,
  ) {
    b.database_universe_write_bool(writer, index, value);
  }

  @tryInline
  static void writeByte(
    Pointer<CDatabaseUniverseWriter> writer,
    int index,
    int value,
  ) {
    b.database_universe_write_byte(writer, index, value);
  }

  @tryInline
  static void writeInt(
    Pointer<CDatabaseUniverseWriter> writer,
    int index,
    int value,
  ) {
    b.database_universe_write_int(writer, index, value);
  }

  @tryInline
  static void writeFloat(
    Pointer<CDatabaseUniverseWriter> writer,
    int index,
    double value,
  ) {
    b.database_universe_write_float(writer, index, value);
  }

  @tryInline
  static void writeLong(
    Pointer<CDatabaseUniverseWriter> writer,
    int index,
    int value,
  ) {
    b.database_universe_write_long(writer, index, value);
  }

  @tryInline
  static void writeDouble(
    Pointer<CDatabaseUniverseWriter> writer,
    int index,
    double value,
  ) {
    b.database_universe_write_double(writer, index, value);
  }

  @tryInline
  static void writeString(
    Pointer<CDatabaseUniverseWriter> writer,
    int index,
    String value,
  ) {
    final valuePtr = _toNativeString(value);
    b.database_universe_write_string(writer, index, valuePtr);
  }

  @tryInline
  static Pointer<CDatabaseUniverseWriter> beginObject(
    Pointer<CDatabaseUniverseWriter> writer,
    int index,
  ) {
    return b.database_universe_write_object(writer, index);
  }

  @tryInline
  static void endObject(
    Pointer<CDatabaseUniverseWriter> writer,
    Pointer<CDatabaseUniverseWriter> objectWriter,
  ) {
    b.database_universe_write_object_end(writer, objectWriter);
  }

  @tryInline
  static Pointer<CDatabaseUniverseWriter> beginList(
    Pointer<CDatabaseUniverseWriter> writer,
    int index,
    int length,
  ) {
    return b.database_universe_write_list(writer, index, length);
  }

  @tryInline
  static void endList(
    Pointer<CDatabaseUniverseWriter> writer,
    Pointer<CDatabaseUniverseWriter> listWriter,
  ) {
    b.database_universe_write_list_end(writer, listWriter);
  }
}

/// @nodoc
extension PointerX on Pointer<void> {
  @tryInline
  bool get isNull => address == 0;
}
