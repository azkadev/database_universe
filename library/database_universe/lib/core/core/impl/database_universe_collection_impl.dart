part of database_universe;

class _DatabaseUniverseCollectionImpl<ID, OBJ> extends DatabaseUniverseCollection<ID, OBJ> {
  _DatabaseUniverseCollectionImpl(
    this.database_universe,
    this.schema,
    this.collectionIndex,
    this.converter,
  );

  @override
  final _DatabaseUniverseImpl database_universe;

  @override
  final DatabaseUniverseSchema schema;

  final int collectionIndex;
  final DatabaseUniverseObjectConverter<ID, OBJ> converter;

  @override
  int autoIncrement() {
    if (0 is ID) {
      return DatabaseUniverseCore.b.database_universe_auto_increment(database_universe.getPtr(), collectionIndex);
    } else {
      throw UnsupportedError(
        'Collections with String IDs do not support auto increment.',
      );
    }
  }

  @override
  List<OBJ?> getAll(List<ID> ids) {
    final objects = List<OBJ?>.filled(ids.length, null, growable: true);
    return database_universe.getTxn((database_universePtr, txnPtr) {
      final cursorPtrPtr = DatabaseUniverseCore.ptrPtr.cast<Pointer<CDatabaseUniverseCursor>>();

      DatabaseUniverseCore.b.database_universe_cursor(database_universePtr, txnPtr, collectionIndex, cursorPtrPtr).checkNoError();

      final cursorPtr = cursorPtrPtr.ptrValue;
      Pointer<CDatabaseUniverseReader> readerPtr = nullptr;
      for (var i = 0; i < ids.length; i++) {
        final id = _idToInt(ids[i]);
        readerPtr = DatabaseUniverseCore.b.database_universe_cursor_next(cursorPtr, id, readerPtr);
        if (!readerPtr.isNull) {
          objects[i] = converter.deserialize(readerPtr);
        }
      }
      DatabaseUniverseCore.b.database_universe_cursor_free(cursorPtr, readerPtr);
      return objects;
    });
  }

  @override
  void putAll(List<OBJ> objects) {
    if (objects.isEmpty) return;

    return database_universe.getWriteTxn(consume: true, (database_universePtr, txnPtr) {
      final writerPtrPtr = DatabaseUniverseCore.ptrPtr.cast<Pointer<CDatabaseUniverseWriter>>();

      DatabaseUniverseCore.b
          .database_universe_insert(
            database_universePtr,
            txnPtr,
            collectionIndex,
            objects.length,
            writerPtrPtr,
          )
          .checkNoError();

      final insertPtr = writerPtrPtr.ptrValue;
      try {
        for (final object in objects) {
          final id = converter.serialize(insertPtr, object);
          DatabaseUniverseCore.b.database_universe_insert_save(insertPtr, id).checkNoError();
        }
      } catch (e) {
        DatabaseUniverseCore.b.database_universe_insert_abort(insertPtr);
        rethrow;
      }

      final txnPtrPtr = DatabaseUniverseCore.ptrPtr.cast<Pointer<CDatabaseUniverseTxn>>();
      DatabaseUniverseCore.b.database_universe_insert_finish(insertPtr, txnPtrPtr).checkNoError();

      return (null, txnPtrPtr.ptrValue);
    });
  }

  @override
  int updateProperties(List<ID> ids, Map<int, dynamic> changes) {
    if (ids.isEmpty) return 0;

    final updatePtr = DatabaseUniverseCore.b.database_universe_update_new();
    for (final propertyId in changes.keys) {
      final value = _database_universeValue(changes[propertyId]);
      DatabaseUniverseCore.b.database_universe_update_add_value(updatePtr, propertyId, value);
    }

    return database_universe.getWriteTxn((database_universePtr, txnPtr) {
      var count = 0;
      final updatedPtr = DatabaseUniverseCore.boolPtr;
      for (final id in ids) {
        DatabaseUniverseCore.b
            .database_universe_update(
              database_universePtr,
              txnPtr,
              collectionIndex,
              _idToInt(id),
              updatePtr,
              updatedPtr,
            )
            .checkNoError();

        if (updatedPtr.boolValue) {
          count++;
        }
      }

      return (count, txnPtr);
    });
  }

  @override
  bool delete(ID id) {
    return database_universe.getWriteTxn((database_universePtr, txnPtr) {
      DatabaseUniverseCore.b
          .database_universe_delete(
            database_universePtr,
            txnPtr,
            collectionIndex,
            _idToInt(id),
            DatabaseUniverseCore.boolPtr,
          )
          .checkNoError();

      return (DatabaseUniverseCore.boolPtr.boolValue, txnPtr);
    });
  }

  @override
  int deleteAll(List<ID> ids) {
    if (ids.isEmpty) return 0;

    return database_universe.getWriteTxn((database_universePtr, txnPtr) {
      var count = 0;
      for (final id in ids) {
        DatabaseUniverseCore.b
            .database_universe_delete(
              database_universePtr,
              txnPtr,
              collectionIndex,
              _idToInt(id),
              DatabaseUniverseCore.boolPtr,
            )
            .checkNoError();

        if (DatabaseUniverseCore.boolPtr.boolValue) {
          count++;
        }
      }

      return (count, txnPtr);
    });
  }

  @override
  QueryBuilder<OBJ, OBJ, QStart> where() {
    return QueryBuilder(this);
  }

  @override
  int count() {
    return database_universe.getTxn((database_universePtr, txnPtr) {
      DatabaseUniverseCore.b.database_universe_count(database_universePtr, txnPtr, collectionIndex, DatabaseUniverseCore.countPtr);
      return DatabaseUniverseCore.countPtr.u32Value;
    });
  }

  @override
  int getSize({bool includeIndexes = false}) {
    return database_universe.getTxn((database_universePtr, txnPtr) {
      return DatabaseUniverseCore.b.database_universe_get_size(database_universePtr, txnPtr, collectionIndex, includeIndexes);
    });
  }

  @override
  int importJsonString(String json) {
    return database_universe.getWriteTxn(consume: true, (database_universePtr, txnPtr) {
      final txnPtrPtr = DatabaseUniverseCore.ptrPtr.cast<Pointer<CDatabaseUniverseTxn>>();
      txnPtrPtr.ptrValue = txnPtr;
      final nativeString = DatabaseUniverseCore._toNativeString(json);
      DatabaseUniverseCore.b
          .database_universe_import_json(
            database_universePtr,
            txnPtrPtr,
            collectionIndex,
            nativeString,
            DatabaseUniverseCore.countPtr,
          )
          .checkNoError();
      return (DatabaseUniverseCore.countPtr.u32Value, txnPtrPtr.ptrValue);
    });
  }

  @override
  void clear() {
    return database_universe.getWriteTxn((database_universePtr, txnPtr) {
      DatabaseUniverseCore.b.database_universe_clear(database_universePtr, txnPtr, collectionIndex);
      return (null, txnPtr);
    });
  }

  @override
  Stream<void> watchLazy({bool fireImmediately = false}) {
    if (DatabaseUniverseCore.kIsWeb) {
      throw UnsupportedError('Watchers are not supported on the web');
    }

    final port = ReceivePort();
    final handlePtrPtr = DatabaseUniverseCore.ptrPtr.cast<Pointer<CWatchHandle>>();

    DatabaseUniverseCore.b
        .database_universe_watch_collection(
          database_universe.getPtr(),
          collectionIndex,
          port.sendPort.nativePort,
          handlePtrPtr,
        )
        .checkNoError();

    final handlePtr = handlePtrPtr.ptrValue;
    final controller = StreamController<void>(
      onCancel: () {
        database_universe.getPtr(); // Make sure DatabaseUniverse is not closed
        DatabaseUniverseCore.b.database_universe_stop_watching(handlePtr);
        port.close();
      },
    );
    if (fireImmediately) {
      controller.add(null);
    }

    controller.addStream(port);
    return controller.stream;
  }

  @override
  Stream<OBJ?> watchObject(ID id, {bool fireImmediately = false}) {
    return watchObjectLazy(id, fireImmediately: fireImmediately).asyncMap((event) => getAsync(id));
  }

  @override
  Stream<void> watchObjectLazy(ID id, {bool fireImmediately = false}) {
    if (DatabaseUniverseCore.kIsWeb) {
      throw UnsupportedError('Watchers are not supported on the web');
    }

    final port = ReceivePort();
    final handlePtrPtr = DatabaseUniverseCore.ptrPtr.cast<Pointer<CWatchHandle>>();

    DatabaseUniverseCore.b
        .database_universe_watch_object(
          database_universe.getPtr(),
          collectionIndex,
          _idToInt(id),
          port.sendPort.nativePort,
          handlePtrPtr,
        )
        .checkNoError();

    final handlePtr = handlePtrPtr.ptrValue;
    final controller = StreamController<void>(
      onCancel: () {
        database_universe.getPtr(); // Make sure DatabaseUniverse is not closed
        DatabaseUniverseCore.b.database_universe_stop_watching(handlePtr);
        port.close();
      },
    );

    if (fireImmediately) {
      controller.add(null);
    }

    controller.addStream(port);
    return controller.stream;
  }

  @override
  DatabaseUniverseQuery<R> buildQuery<R>({
    Filter? filter,
    List<SortProperty>? sortBy,
    List<DistinctProperty>? distinctBy,
    List<int>? properties,
  }) {
    if (properties != null && properties.length > 3) {
      throw ArgumentError('Only up to 3 properties are supported');
    }

    final builderPtrPtr = malloc<Pointer<CDatabaseUniverseQueryBuilder>>();
    DatabaseUniverseCore.b.database_universe_query_new(database_universe.getPtr(), collectionIndex, builderPtrPtr).checkNoError();

    final builderPtr = builderPtrPtr.ptrValue;
    if (filter != null) {
      final pointers = <Pointer<Never>>[];
      try {
        final filterPtr = _buildFilter(filter, pointers);
        DatabaseUniverseCore.b.database_universe_query_set_filter(builderPtr, filterPtr);
      } finally {
        for (final ptr in pointers) {
          free(ptr);
        }
      }
    }

    if (sortBy != null) {
      for (final sort in sortBy) {
        DatabaseUniverseCore.b.database_universe_query_add_sort(
          builderPtr,
          sort.property,
          sort.sort == Sort.asc,
          sort.caseSensitive,
        );
      }
    }

    if (distinctBy != null) {
      for (final distinct in distinctBy) {
        DatabaseUniverseCore.b.database_universe_query_add_distinct(
          builderPtr,
          distinct.property,
          distinct.caseSensitive,
        );
      }
    }

    late final R Function(Pointer<CDatabaseUniverseReader>) deserialize;
    switch (properties?.length ?? 0) {
      case 0:
        deserialize = converter.deserialize as R Function(Pointer<CDatabaseUniverseReader>);
      case 1:
        final property = properties![0];
        final deserializeProp = converter.deserializeProperty!;
        deserialize = (reader) => deserializeProp(reader, property) as R;
      case 2:
        final property1 = properties![0];
        final property2 = properties[1];
        final deserializeProp = converter.deserializeProperty!;
        deserialize = (reader) => (deserializeProp(reader, property1), deserializeProp(reader, property2)) as R;
      case 3:
        final property1 = properties![0];
        final property2 = properties[1];
        final property3 = properties[2];
        final deserializeProp = converter.deserializeProperty!;
        deserialize = (reader) => (
              deserializeProp(reader, property1),
              deserializeProp(reader, property2),
              deserializeProp(reader, property3),
            ) as R;
    }

    final queryPtr = DatabaseUniverseCore.b.database_universe_query_build(builderPtr);
    return _DatabaseUniverseQueryImpl(
      instanceId: database_universe.instanceId,
      ptrAddress: queryPtr.address,
      properties: properties,
      deserialize: deserialize,
    );
  }
}

@tryInline
int _idToInt<OBJ>(OBJ id) {
  if (id is int) {
    return id;
  } else {
    return DatabaseUniverse.fastHash(id as String);
  }
}
