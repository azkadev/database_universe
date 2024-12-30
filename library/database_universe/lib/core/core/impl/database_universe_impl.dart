// ignore_for_file: non_constant_identifier_names

part of database_universe;

class _DatabaseUniverseImpl extends DatabaseUniverse {
  _DatabaseUniverseImpl._(
    this.instanceId,
    Pointer<CDatabaseUniverseInstance> ptr,
    this.generatedSchemas,
  ) : _ptr = ptr {
    for (final schema in generatedSchemas) {
      if (schema.isEmbedded) {
        continue;
      }

      collections[schema.converter.type] = schema.converter.withType(
        <ID, OBJ>(converter) {
          return _DatabaseUniverseCollectionImpl<ID, OBJ>(
            this,
            schema.schema,
            collections.length,
            converter,
          );
        },
      );
    }

    _instances[instanceId] = this;
  }

  static final _instances = <int, _DatabaseUniverseImpl>{};

  final int instanceId;
  final List<DatabaseUniverseGeneratedSchema> generatedSchemas;
  final collections = <Type, _DatabaseUniverseCollectionImpl<dynamic, dynamic>>{};

  Pointer<CDatabaseUniverseInstance>? _ptr;
  Pointer<CDatabaseUniverseTxn>? _txnPtr;
  bool _txnWrite = false;

  // ignore: sort_constructors_first
  factory _DatabaseUniverseImpl.open({
    required List<DatabaseUniverseGeneratedSchema> schemas,
    required String name,
    required DatabaseUniverseEngine engine,
    required String directory,
    required int? maxSizeMiB,
    required String? encryptionKey,
    required CompactCondition? compactOnLaunch,
    String? library,
  }) {
    DatabaseUniverseCore._initialize(library: library);

    if (engine == DatabaseUniverseEngine.databaseUniverse) {
      if (encryptionKey != null) {
        throw ArgumentError('DatabaseUniverse engine does not support encryption. Please '
            'set the engine to DatabaseUniverseEngine.sqlite.');
      }
      maxSizeMiB ??= DatabaseUniverse.defaultMaxSizeMiB;
    } else {
      if (compactOnLaunch != null) {
        throw ArgumentError('SQLite engine does not support compaction.');
      }
      maxSizeMiB ??= 0;
    }

    final allSchemas = <DatabaseUniverseGeneratedSchema>{
      ...schemas,
      ...schemas.expand((e) => e.embeddedSchemas ?? <DatabaseUniverseGeneratedSchema>[]),
    };
    final schemaJson = jsonEncode(allSchemas.map((e) => e.schema.toJson()).toList());

    final instanceId = DatabaseUniverse.fastHash(name);
    final instance = _DatabaseUniverseImpl._instances[instanceId];
    if (instance != null) {
      return instance;
    }

    final namePtr = DatabaseUniverseCore._toNativeString(name);
    final directoryPtr = DatabaseUniverseCore._toNativeString(directory);
    final schemaPtr = DatabaseUniverseCore._toNativeString(schemaJson);
    final encryptionKeyPtr = encryptionKey != null ? DatabaseUniverseCore._toNativeString(encryptionKey) : nullptr;

    final databaseUniverseptrptr = DatabaseUniverseCore.ptrPtr.cast<Pointer<CDatabaseUniverseInstance>>();
    DatabaseUniverseCore.b
        .database_universe_open_instance(
          databaseUniverseptrptr,
          instanceId,
          namePtr,
          directoryPtr,
          engine == DatabaseUniverseEngine.sqlite,
          schemaPtr,
          maxSizeMiB,
          encryptionKeyPtr,
          compactOnLaunch != null ? compactOnLaunch.minFileSize ?? 0 : -1,
          compactOnLaunch != null ? compactOnLaunch.minBytes ?? 0 : -1,
          compactOnLaunch != null ? compactOnLaunch.minRatio ?? 0 : double.nan,
        )
        .checkNoError();

    return _DatabaseUniverseImpl._(instanceId, databaseUniverseptrptr.ptrValue, allSchemas.toList());
  }

  // ignore: sort_constructors_first
  factory _DatabaseUniverseImpl.get({
    required int instanceId,
    required List<DatabaseUniverseGeneratedSchema> schemas,
    String? library,
  }) {
    DatabaseUniverseCore._initialize(library: library);
    var ptr = DatabaseUniverseCore.b.database_universe_get_instance(instanceId, false);
    if (ptr.isNull) {
      ptr = DatabaseUniverseCore.b.database_universe_get_instance(instanceId, true);
    }
    if (ptr.isNull) {
      throw DatabaseUniverseNotReadyError('Instance has not been opened yet. Make sure to '
          'call DatabaseUniverse.open() before using DatabaseUniverse.get().');
    }

    return _DatabaseUniverseImpl._(instanceId, ptr, schemas);
  }

  // ignore: sort_constructors_first
  factory _DatabaseUniverseImpl.getByName({
    required String name,
    required List<DatabaseUniverseGeneratedSchema> schemas,
  }) {
    final instanceId = DatabaseUniverse.fastHash(name);
    final instance = _DatabaseUniverseImpl._instances[instanceId];
    if (instance != null) {
      return instance;
    }

    return _DatabaseUniverseImpl.get(
      instanceId: instanceId,
      schemas: schemas,
    );
  }

  static Future<DatabaseUniverse> openAsync({
    required List<DatabaseUniverseGeneratedSchema> schemas,
    required String directory,
    String name = DatabaseUniverse.defaultName,
    DatabaseUniverseEngine engine = DatabaseUniverseEngine.databaseUniverse,
    int? maxSizeMiB = DatabaseUniverse.defaultMaxSizeMiB,
    String? encryptionKey,
    CompactCondition? compactOnLaunch,
  }) async {
    final library = DatabaseUniverseCore._library;

    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    final isolate = runIsolate(
      'DatabaseUniverse open async',
      () async {
        try {
          final databaseUniverse = _DatabaseUniverseImpl.open(
            schemas: schemas,
            directory: directory,
            name: name,
            engine: engine,
            maxSizeMiB: maxSizeMiB,
            encryptionKey: encryptionKey,
            compactOnLaunch: compactOnLaunch,
            library: library,
          );

          final receivePort = ReceivePort();
          sendPort.send(receivePort.sendPort);
          await receivePort.first;
          databaseUniverse.close();
        } catch (e) {
          sendPort.send(e);
        }
      },
    );

    final response = await receivePort.first;
    if (response is SendPort) {
      final databaseUniverse = DatabaseUniverse.get(schemas: schemas, name: name);
      response.send(null);
      await isolate;
      return databaseUniverse;
    } else {
      // ignore: only_throw_errors
      throw response as Object;
    }
  }

  static _DatabaseUniverseImpl instance(int instanceId) {
    final instance = _instances[instanceId];
    if (instance == null) {
      throw DatabaseUniverseNotReadyError(
        'DatabaseUniverse instance has not been opened yet in this isolate. Call '
        'DatabaseUniverse.get() or DatabaseUniverse.open() before trying to access DatabaseUniverse for the first '
        'time in a new isolate.',
      );
    }
    return instance;
  }

  @tryInline
  Pointer<CDatabaseUniverseInstance> getPtr() {
    final ptr = _ptr;
    if (ptr == null) {
      throw DatabaseUniverseNotReadyError('DatabaseUniverse instance has already been closed.');
    } else {
      return ptr;
    }
  }

  @override
  late final String name = () {
    final length = DatabaseUniverseCore.b.database_universe_get_name(getPtr(), DatabaseUniverseCore.stringPtrPtr);
    return utf8.decode(DatabaseUniverseCore.stringPtr.asU8List(length));
  }();

  @override
  late final String directory = () {
    final length = DatabaseUniverseCore.b.database_universe_get_dir(getPtr(), DatabaseUniverseCore.stringPtrPtr);
    return utf8.decode(DatabaseUniverseCore.stringPtr.asU8List(length));
  }();

  @override
  late final List<DatabaseUniverseSchema> schemas = generatedSchemas.map((e) => e.schema).toList();

  @override
  bool get isOpen => _ptr != null;

  @override
  DatabaseUniverseCollection<ID, OBJ> collection<ID, OBJ>() {
    final collection = collections[OBJ];
    if (collection is _DatabaseUniverseCollectionImpl<ID, OBJ>) {
      return collection;
    } else {
      throw ArgumentError('Collection for type $OBJ not found');
    }
  }

  @override
  DatabaseUniverseCollection<ID, OBJ> collectionByIndex<ID, OBJ>(int index) {
    final collection = collections.values.elementAt(index);
    if (collection is _DatabaseUniverseCollectionImpl<ID, OBJ>) {
      return collection;
    } else {
      throw ArgumentError('Invalid type parameters for collection');
    }
  }

  @tryInline
  T getTxn<T>(
    T Function(
      Pointer<CDatabaseUniverseInstance> databaseUniverseptr,
      Pointer<CDatabaseUniverseTxn> txnPtr,
    ) callback,
  ) {
    final txnPtr = _txnPtr;
    if (txnPtr != null) {
      return callback(_ptr!, txnPtr);
    } else {
      return read((databaseUniverse) => callback(_ptr!, _txnPtr!));
    }
  }

  @tryInline
  T getWriteTxn<T>(
    (T, Pointer<CDatabaseUniverseTxn>?) Function(
      Pointer<CDatabaseUniverseInstance> databaseUniverseptr,
      Pointer<CDatabaseUniverseTxn> txnPtr,
    ) callback, {
    bool consume = false,
  }) {
    final txnPtr = _txnPtr;
    if (txnPtr != null) {
      if (_txnWrite) {
        if (consume) {
          _txnPtr = null;
        }
        final (result, returnedPtr) = callback(_ptr!, txnPtr);
        _txnPtr = returnedPtr;
        return result;
      }
    }
    throw WriteTxnRequiredError();
  }

  void _checkNotInTxn() {
    if (_txnPtr != null) {
      throw UnsupportedError('Nested transactions are not supported');
    }
  }

  @override
  T read<T>(T Function(DatabaseUniverse databaseUniverse) callback) {
    _checkNotInTxn();

    final ptr = getPtr();
    final txnPtrPtr = DatabaseUniverseCore.ptrPtr.cast<Pointer<CDatabaseUniverseTxn>>();
    DatabaseUniverseCore.b.database_universe_txn_begin(ptr, txnPtrPtr, false).checkNoError();
    try {
      _txnPtr = txnPtrPtr.ptrValue;
      _txnWrite = false;
      return callback(this);
    } finally {
      DatabaseUniverseCore.b.database_universe_txn_abort(ptr, _txnPtr!);
      _txnPtr = null;
    }
  }

  @override
  T write<T>(T Function(DatabaseUniverse databaseUniverse) callback) {
    _checkNotInTxn();

    final ptr = getPtr();
    final txnPtrPtr = DatabaseUniverseCore.ptrPtr.cast<Pointer<CDatabaseUniverseTxn>>();
    DatabaseUniverseCore.b.database_universe_txn_begin(ptr, txnPtrPtr, true).checkNoError();
    try {
      _txnPtr = txnPtrPtr.ptrValue;
      _txnWrite = true;
      final result = callback(this);
      DatabaseUniverseCore.b.database_universe_txn_commit(ptr, _txnPtr!).checkNoError();
      return result;
    } catch (_) {
      final txnPtr = _txnPtr;
      if (txnPtr != null) {
        DatabaseUniverseCore.b.database_universe_txn_abort(ptr, txnPtr);
      }
      rethrow;
    } finally {
      _txnPtr = null;
    }
  }

  @override
  Future<T> readAsyncWith<T, P>(
    P param,
    T Function(DatabaseUniverse databaseUniverse, P param) callback, {
    String? debugName,
  }) {
    if (DatabaseUniverseCore.kIsWeb) {
      throw UnsupportedError('Watchers are not supported on the web');
    }

    _checkNotInTxn();

    final instance = instanceId;
    final library = DatabaseUniverseCore._library;
    final schemas = generatedSchemas;
    return runIsolate(
      debugName ?? 'DatabaseUniverse async read',
      () => _database_universeAsync(
        instanceId: instance,
        schemas: schemas,
        write: false,
        param: param,
        callback: callback,
        library: library,
      ),
    );
  }

  @override
  Future<T> writeAsyncWith<T, P>(
    P param,
    T Function(DatabaseUniverse databaseUniverse, P param) callback, {
    String? debugName,
  }) async {
    if (DatabaseUniverseCore.kIsWeb) {
      throw UnsupportedError('Watchers are not supported on the web');
    }

    _checkNotInTxn();

    final instance = instanceId;
    final library = DatabaseUniverseCore._library;
    final schemas = generatedSchemas.toList();
    return runIsolate(
      debugName ?? 'DatabaseUniverse async write',
      () {
        return _database_universeAsync(
          instanceId: instance,
          schemas: schemas,
          write: true,
          param: param,
          callback: callback,
          library: library,
        );
      },
    );
  }

  @override
  int getSize({bool includeIndexes = false}) {
    var size = 0;
    for (final collection in collections.values) {
      size += collection.getSize(includeIndexes: includeIndexes);
    }
    return size;
  }

  @override
  void copyToFile(String path) {
    final string = DatabaseUniverseCore._toNativeString(path);
    DatabaseUniverseCore.b.database_universe_copy(getPtr(), string).checkNoError();
  }

  @override
  void clear() {
    for (final collection in collections.values) {
      collection.clear();
    }
  }

  @override
  void changeEncryptionKey(String encryptionKey) {
    final string = DatabaseUniverseCore._toNativeString(encryptionKey);
    DatabaseUniverseCore.b.database_universe_change_encryption_key(getPtr(), string);
  }

  @override
  bool close({bool deleteFromDisk = false}) {
    final closed = DatabaseUniverseCore.b.database_universe_close(getPtr(), deleteFromDisk);
    _ptr = null;
    _instances.remove(instanceId);
    return closed != 0;
  }

  @override
  void verify() {
    getTxn(
      (databaseUniverseptr, txnPtr) => DatabaseUniverseCore.b.database_universe_verify(databaseUniverseptr, txnPtr).checkNoError(),
    );
  }
}

T _database_universeAsync<T, P>({
  required int instanceId,
  required List<DatabaseUniverseGeneratedSchema> schemas,
  required bool write,
  required P param,
  required T Function(DatabaseUniverse databaseUniverse, P param) callback,
  String? library,
}) {
  final databaseUniverse = _DatabaseUniverseImpl.get(
    instanceId: instanceId,
    schemas: schemas,
    library: library,
  );
  try {
    if (write) {
      return databaseUniverse.write((databaseUniverse) => callback(databaseUniverse, param));
    } else {
      return databaseUniverse.read((databaseUniverse) => callback(databaseUniverse, param));
    }
  } finally {
    databaseUniverse.close();
    DatabaseUniverseCore._free();
  }
}
