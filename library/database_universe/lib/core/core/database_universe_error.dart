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
