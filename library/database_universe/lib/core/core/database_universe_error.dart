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
part of "package:database_universe/core/core.dart";

/// Superclass of all DatabaseUniverse errors.
sealed class DatabaseUniverseError extends Error {
  /// Name of the error.
  String get name;

  /// Error message.
  String get message;

  @override
  String toString() {
    return '$name: $message';
  }
}

/// Invalid or protected path error.
class PathError extends DatabaseUniverseError {
  @override
  final name = 'PathError';

  @override
  final message =
      'The specified path does not exist or cannot be used by DatabaseUniverse '
      'for example because it is a file.';
}

/// An active write transaction is required for this operation.
class WriteTxnRequiredError extends DatabaseUniverseError {
  @override
  String get name => 'WriteTxnRequiredError';

  @override
  String get message => 'This operation requires an active write transaction.';
}

/// Database file is incompatible with this version of DatabaseUniverse.
class VersionError extends DatabaseUniverseError {
  @override
  String get name => 'VersionError';

  @override
  String get message => 'The database version is not compatible with this '
      'version of DatabaseUniverse. Please check if you need to migrate the database.';
}

/// The object is too large to be stored in DatabaseUniverse.
class ObjectLimitReachedError extends DatabaseUniverseError {
  @override
  String get name => 'ObjectLimitReachedError';

  @override
  String get message => 'The maximum size of an object was exceeded. All '
      'objects in DatabaseUniverse including all nested lists and objects must be smaller '
      'than 16MB.';
}

/// Invalid DatabaseUniverse instance.
class InstanceMismatchError extends DatabaseUniverseError {
  @override
  String get name => 'InstanceMismatchError';

  @override
  String get message =>
      'Provided resources do not belong to this DatabaseUniverse '
      'instance. This can happen when you try to use a query or transaction '
      'from a different DatabaseUniverse instance.';
}

/// Something went wrong during encryption/decryption. Most likely the
/// encryption key is wrong.
class EncryptionError extends DatabaseUniverseError {
  @override
  String get name => 'EncryptionError';

  @override
  String get message => 'Could not encrypt/decrypt the database. Make sure '
      'that the encryption key is correct and that the database is not '
      'corrupted.';
}

/// The database is full.
class DatabaseFullError extends DatabaseUniverseError {
  @override
  final name = 'DatabaseFullError';

  @override
  final message =
      'The database is full. Pleas increase the maxSizeMiB parameter '
      'when opening DatabaseUniverse. Alternatively you can compact the database by '
      'specifying a CompactCondition when opening DatabaseUniverse.';
}

/// DatabaseUniverse has not been initialized correctly.
class DatabaseUniverseNotReadyError extends DatabaseUniverseError {
  /// @nodoc
  @protected
  DatabaseUniverseNotReadyError(this.message);

  @override
  String get name => 'DatabaseUniverseNotReadyError';

  @override
  final String message;
}

/// Unknown error returned by the database engine.
class DatabaseError extends DatabaseUniverseError {
  /// @nodoc
  @protected
  DatabaseError(this.message);

  @override
  String get name => 'DatabaseUniverseError';

  @override
  final String message;
}
