// ignore_for_file: prefer_asserts_with_message

part of database_universe;

/// The DatabaseUniverse storage engine.
enum DatabaseUniverseEngine {
  /// The native DatabaseUniverse storage engine.
  databaseUniverse,

  /// The SQLite storage engine.
  sqlite
}

/// An DatabaseUniverse database instance.
@pragma('vm:isolate-unsendable')
abstract class DatabaseUniverse {
  /// The default DatabaseUniverse instance name.
  static const String defaultName = 'default';

  /// The default max DatabaseUniverse size.
  static const int defaultMaxSizeMiB = 128;

  /// The current DatabaseUniverse version.
  static const String version = '0.0.0-placeholder';

  /// Use this value for the `directory` parameter to create an in-memory
  /// database.
  static const String sqliteInMemory = ':memory:';

  /// Initialize DatabaseUniverse manually. This is required if you target web.
  ///
  /// On native platforms you can provide a custom path
  /// to the DatabaseUniverse Core
  /// [library].
  static FutureOr<void> initialize([String? library]) {
    return DatabaseUniverseCore._initialize(library: library, explicit: true);
  }

  /// Get an already opened DatabaseUniverse instance by its name.
  ///
  /// This method is especially useful to get an
  /// DatabaseUniverse instance from an isolate.
  /// It is much faster than using [open].
  static DatabaseUniverse get({
    required List<DatabaseUniverseGeneratedSchema> schemas,
    String name = DatabaseUniverse.defaultName,
  }) {
    return _DatabaseUniverseImpl.getByName(name: name, schemas: schemas);
  }

  /// Open a new DatabaseUniverse instance.
  ///
  /// {@template database_universe_open}
  /// You have to provide a list of all collection [schemas] that you want to
  /// use in this instance as well as a [directory] where the database file
  /// should be stored.
  ///
  /// Use [DatabaseUniverse.sqliteInMemory] as the directory
  /// to create an in-memory
  /// database.
  ///
  /// You can optionally provide a [name] for this instance. This is needed if
  /// you want to open multiple instances.
  ///
  /// If [encryptionKey] is provided, the database will be encrypted with the
  /// provided key. Opening an encrypted database with an incorrect key will
  /// result in an error. Only the SQLite storage engine supports encryption.
  ///
  /// [maxSizeMiB] is the maximum size of the database file in MiB. It is
  /// recommended to set this value as low as possible. Older devices might
  /// not be able to grant the requested amount of virtual memory. In that case
  /// DatabaseUniverse will try to use as much memory as possible.
  ///
  /// [compactOnLaunch] is a condition that triggers a database compaction
  /// on launch when the specified conditions are met.
  /// Only the DatabaseUniverse storage
  /// engine supports compaction.
  ///
  /// [inspector] enables the DatabaseUniverse inspector
  /// when the app is running in debug
  /// mode. In release mode the inspector is always disabled.
  /// {@endtemplate}
  static DatabaseUniverse open({
    required List<DatabaseUniverseGeneratedSchema> schemas,
    required String directory,
    String name = DatabaseUniverse.defaultName,
    DatabaseUniverseEngine engine = DatabaseUniverseEngine.databaseUniverse,
    int? maxSizeMiB = DatabaseUniverse.defaultMaxSizeMiB,
    String? encryptionKey,
    CompactCondition? compactOnLaunch,
    bool inspector = true,
  }) {
    final databaseUniverse = _DatabaseUniverseImpl.open(
      schemas: schemas,
      directory: directory,
      name: name,
      engine: engine,
      maxSizeMiB: maxSizeMiB,
      encryptionKey: encryptionKey,
      compactOnLaunch: compactOnLaunch,
    );

    /// Tree shake the inspector for profile and release builds.
    assert(() {
      if (!DatabaseUniverseCore.kIsWeb && inspector) {
        _DatabaseUniverseConnect.initialize(databaseUniverse);
      }
      return true;
    }());

    return databaseUniverse;
  }

  /// Open a new DatabaseUniverse instance asynchronously.
  ///
  /// {@macro database_universe_open}
  static Future<DatabaseUniverse> openAsync({
    required List<DatabaseUniverseGeneratedSchema> schemas,
    required String directory,
    String name = DatabaseUniverse.defaultName,
    DatabaseUniverseEngine engine = DatabaseUniverseEngine.databaseUniverse,
    int? maxSizeMiB = DatabaseUniverse.defaultMaxSizeMiB,
    String? encryptionKey,
    CompactCondition? compactOnLaunch,
    bool inspector = true,
  }) async {
    final databaseUniverse = await _DatabaseUniverseImpl.openAsync(
      schemas: schemas,
      directory: directory,
      name: name,
      engine: engine,
      maxSizeMiB: maxSizeMiB,
      encryptionKey: encryptionKey,
      compactOnLaunch: compactOnLaunch,
    );

    /// Tree shake the inspector for profile and release builds.
    assert(() {
      if (!DatabaseUniverseCore.kIsWeb && inspector) {
        _DatabaseUniverseConnect.initialize(databaseUniverse);
      }
      return true;
    }());

    return databaseUniverse;
  }

  /// Name of the instance.
  String get name;

  /// The directory containing the database file.
  String get directory;

  /// Whether this instance is open and active.
  ///
  /// The instance is open until [close] is called. After that, all operations
  /// will throw an [DatabaseUniverseNotReadyError].
  bool get isOpen;

  /// Get the schemas of all collections and embedded objects in this instance.
  List<DatabaseUniverseSchema> get schemas;

  /// Get a collection by its type.
  ///
  /// You should use the generated extension methods instead. A collection
  /// `User` can be accessed with `database_universe.users`.
  DatabaseUniverseCollection<ID, OBJ> collection<ID, OBJ>();

  /// Get a collection by its index.
  ///
  /// The index is the order in which the collections were defined when opening
  /// the instance.
  ///
  /// It is not recommended to use this method. Use the generated extension
  /// methods instead. A collection `User` can
  /// be accessed with `database_universe.users`.
  @experimental
  DatabaseUniverseCollection<ID, OBJ> collectionByIndex<ID, OBJ>(int index);

  /// Create a synchronous read transaction.
  ///
  /// Explicit read transactions are optional, but they allow you to do atomic
  /// reads and rely on a consistent state of the database inside the
  /// transaction. Internally DatabaseUniverse always
  /// uses implicit read transactions for
  /// all read operations.
  ///
  /// It is recommended to use an explicit read transactions when you want to
  /// perform multiple subsequent read operations.
  ///
  /// Example:
  /// ```dart
  /// final (user, workspace) = database_universe.read((database_universe) {
  ///   final user = database_universe.users.where().findFirst();
  ///   final workspace = database_universe.workspaces.where().findFirst();
  ///   return (user, workspace);
  /// });
  /// ```
  T read<T>(T Function(DatabaseUniverse databaseUniverse) callback);

  /// Create a synchronous read-write transaction.
  ///
  /// Unlike read operations, write operations
  /// in DatabaseUniverse must be wrapped in an
  /// explicit transaction.
  ///
  /// When a write transaction finishes successfully, it is automatically
  /// committed, and all changes are written to disk. If an error occurs, the
  /// transaction is aborted, and all the changes are rolled back. Transactions
  /// are “all or nothing”: either all the writes within a transaction succeed,
  /// or none of them take effect to guarantee data consistency.
  ///
  /// Example:
  /// ```dart
  /// database_universe.write((database_universe) {
  ///   final user = User(name: 'John');
  ///   database_universe.users.put(user);
  /// });
  /// ```
  T write<T>(T Function(DatabaseUniverse databaseUniverse) callback);

  /// Create an asynchronous read transaction.
  ///
  /// The code inside the callback will be executed in a separate isolate.
  ///
  /// Check out the [read] method for more information.
  Future<T> readAsync<T>(
    T Function(DatabaseUniverse databaseUniverse) callback, {
    String? debugName,
  }) {
    return readAsyncWith(
      null,
      (databaseUniverse, _) {
        return callback(databaseUniverse);
      },
      debugName: debugName,
    );
  }

  /// Create an asynchronous read transaction and pass a parameter to the
  /// callback.
  ///
  /// The code inside the callback will be executed in a separate isolate.
  ///
  /// Check out the [read] method for more information.
  Future<T> readAsyncWith<T, P>(
    P param,
    T Function(DatabaseUniverse databaseUniverse, P param) callback, {
    String? debugName,
  });

  /// Create an asynchronous read-write transaction.
  ///
  /// The code inside the callback will be executed in a separate isolate.
  ///
  /// Check out the [write] method for more information.
  Future<T> writeAsync<T>(
    T Function(DatabaseUniverse databaseUniverse) callback, {
    String? debugName,
  }) {
    return writeAsyncWith(
      null,
      (databaseUniverse, _) {
        return callback(databaseUniverse);
      },
      debugName: debugName,
    );
  }

  /// Create an asynchronous read-write transaction and pass a parameter to the
  /// callback.
  ///
  /// The code inside the callback will be executed in a separate isolate.
  ///
  /// Check out the [write] method for more information.
  Future<T> writeAsyncWith<T, P>(
    P param,
    T Function(DatabaseUniverse databaseUniverse, P param) callback, {
    String? debugName,
  });

  /// Returns the size of all the collections in bytes.
  ///
  /// For the native DatabaseUniverse
  /// storage engine this method is extremely fast and
  /// independent of the number of objects in the instance.
  int getSize({bool includeIndexes = false});

  /// Copy a compacted version of the database to the specified file.
  ///
  /// If you want to backup your database, you should always use a compacted
  /// version. Compacted does not mean compressed.
  ///
  /// Do not run this method while other transactions are active to avoid
  /// unnecessary growth of the database.
  void copyToFile(String path);

  /// Remove all data in this instance.
  void clear();

  /// Releases an DatabaseUniverse instance.
  ///
  /// If this is the only isolate that holds a reference to this instance, the
  /// DatabaseUniverse instance will be closed.
  /// [deleteFromDisk] additionally removes all
  /// database files if enabled.
  ///
  /// Returns whether the instance was actually closed.
  bool close({bool deleteFromDisk = false});

  /// Verifies the integrity of the database. This method is not intended to be
  /// used by end users and should only be
  /// used by DatabaseUniverse tests. Never call this
  /// method on a production database.
  @visibleForTesting
  void verify();

  /// Changes the encryption key for an encrypted database.
  /// Only supported on engines with encryption encryption support,
  /// and for databases that are already encrypted.
  void changeEncryptionKey(String encryptionKey);

  /// FNV-1a 64bit hash algorithm optimized for Dart Strings
  static int fastHash(String string) {
    return platformFastHash(string);
  }
}
