// ignore_for_file: non_constant_identifier_names

part of "package:database_universe/core/core.dart";

class _DatabaseUniverseQueryImpl<T> extends DatabaseUniverseQuery<T> {
  _DatabaseUniverseQueryImpl({
    required int instanceId,
    required int ptrAddress,
    required Deserialize<T> deserialize,
    List<int>? properties,
  })  : _instanceId = instanceId,
        _ptrAddress = ptrAddress,
        _properties = properties,
        _deserialize = deserialize;

  final int _instanceId;
  final List<int>? _properties;
  final Deserialize<T> _deserialize;
  int _ptrAddress;

  Pointer<CDatabaseUniverseQuery> get _ptr {
    final ptr = ptrFromAddress<CDatabaseUniverseQuery>(_ptrAddress);
    if (ptr.isNull) {
      throw StateError('Query has already been closed.');
    }
    return ptr;
  }

  @override
  _DatabaseUniverseImpl get databaseUniverse =>
      _DatabaseUniverseImpl.instance(_instanceId);

  List<E> _findAll<E>(Deserialize<E> deserialize, {int? offset, int? limit}) {
    if (limit == 0) {
      throw ArgumentError('Limit must be greater than 0.');
    }

    return databaseUniverse.getTxn((databaseUniverseptr, txnPtr) {
      final cursorPtrPtr = DatabaseUniverseCore.ptrPtr
          .cast<Pointer<CDatabaseUniverseQueryCursor>>();
      DatabaseUniverseCore.b
          .database_universe_query_cursor(
            databaseUniverseptr,
            txnPtr,
            _ptr,
            cursorPtrPtr,
            offset ?? 0,
            limit ?? 0,
          )
          .checkNoError();
      final cursorPtr = cursorPtrPtr.ptrValue;

      Pointer<CDatabaseUniverseReader> readerPtr = nullptr;
      final values = <E>[];
      while (true) {
        readerPtr = DatabaseUniverseCore.b
            .database_universe_query_cursor_next(cursorPtr, readerPtr);
        if (readerPtr.isNull) break;
        values.add(deserialize(readerPtr));
      }
      DatabaseUniverseCore.b
          .database_universe_query_cursor_free(cursorPtr, readerPtr);
      return values;
    });
  }

  @override
  List<T> findAll({int? offset, int? limit}) {
    return _findAll(_deserialize, offset: offset, limit: limit);
  }

  @override
  int updateProperties(Map<int, dynamic> changes, {int? offset, int? limit}) {
    if (limit == 0) {
      throw ArgumentError('Limit must be greater than 0.');
    }

    return databaseUniverse.getWriteTxn((databaseUniverseptr, txnPtr) {
      final updatePtr = DatabaseUniverseCore.b.database_universe_update_new();
      for (final propertyId in changes.keys) {
        final value = _database_universeValue(changes[propertyId]);
        DatabaseUniverseCore.b
            .database_universe_update_add_value(updatePtr, propertyId, value);
      }

      DatabaseUniverseCore.b
          .database_universe_query_update(
            databaseUniverseptr,
            txnPtr,
            _ptr,
            offset ?? 0,
            limit ?? 0,
            updatePtr,
            DatabaseUniverseCore.countPtr,
          )
          .checkNoError();

      return (DatabaseUniverseCore.countPtr.u32Value, txnPtr);
    });
  }

  @override
  int deleteAll({int? offset, int? limit}) {
    if (limit == 0) {
      throw ArgumentError('Limit must be greater than 0.');
    }

    return databaseUniverse.getWriteTxn((databaseUniverseptr, txnPtr) {
      DatabaseUniverseCore.b
          .database_universe_query_delete(
            databaseUniverseptr,
            txnPtr,
            _ptr,
            offset ?? 0,
            limit ?? 0,
            DatabaseUniverseCore.countPtr,
          )
          .checkNoError();
      return (DatabaseUniverseCore.countPtr.u32Value, txnPtr);
    });
  }

  @override
  List<Map<String, dynamic>> exportJson({int? offset, int? limit}) {
    final bufferPtrPtr = malloc<Pointer<Uint8>>();
    bufferPtrPtr.ptrValue = nullptr;
    final bufferSizePtr = malloc<Uint32>();

    Map<String, dynamic> deserialize(DatabaseUniverseReader reader) {
      final jsonSize = DatabaseUniverseCore.b
          .database_universe_read_to_json(reader, bufferPtrPtr, bufferSizePtr);
      final bufferPtr = bufferPtrPtr.ptrValue;
      if (bufferPtr == nullptr) {
        throw StateError('Error while exporting JSON.');
      } else {
        final jsonBytes = bufferPtr.asU8List(jsonSize);
        return jsonDecode(utf8.decode(jsonBytes)) as Map<String, dynamic>;
      }
    }

    try {
      return _findAll(deserialize, offset: offset, limit: limit);
    } finally {
      DatabaseUniverseCore.b.database_universe_buffer_free(
        bufferPtrPtr.ptrValue,
        bufferSizePtr.u32Value,
      );
      free(bufferPtrPtr);
      free(bufferSizePtr);
    }
  }

  @override
  R? aggregate<R>(Aggregation op) {
    final aggregation = switch (op) {
      Aggregation.count => AGGREGATION_COUNT,
      Aggregation.isEmpty => AGGREGATION_IS_EMPTY,
      Aggregation.min => AGGREGATION_MIN,
      Aggregation.max => AGGREGATION_MAX,
      Aggregation.sum => AGGREGATION_SUM,
      Aggregation.average => AGGREGATION_AVERAGE,
    };

    return databaseUniverse.getTxn((databaseUniverseptr, txnPtr) {
      final valuePtrPtr =
          DatabaseUniverseCore.ptrPtr.cast<Pointer<CDatabaseUniverseValue>>();
      DatabaseUniverseCore.b
          .database_universe_query_aggregate(
            databaseUniverseptr,
            txnPtr,
            _ptr,
            aggregation,
            _properties?.firstOrNull ?? 0,
            valuePtrPtr,
          )
          .checkNoError();

      final valuePtr = valuePtrPtr.ptrValue;
      if (valuePtr == nullptr) return null;

      try {
        if (true is R) {
          return (DatabaseUniverseCore.b
                  .database_universe_value_get_bool(valuePtr) !=
              0) as R;
        } else if (0.5 is R) {
          return DatabaseUniverseCore.b
              .database_universe_value_get_real(valuePtr) as R;
        } else if (0 is R) {
          return DatabaseUniverseCore.b
              .database_universe_value_get_integer(valuePtr) as R;
        } else if (DateTime.now() is R) {
          return DateTime.fromMillisecondsSinceEpoch(
            DatabaseUniverseCore.b
                .database_universe_value_get_integer(valuePtr),
            isUtc: true,
          ).toLocal() as R;
        } else if ('' is R) {
          final length =
              DatabaseUniverseCore.b.database_universe_value_get_string(
            valuePtr,
            DatabaseUniverseCore.stringPtrPtr,
          );
          if (DatabaseUniverseCore.stringPtr.isNull) {
            return null;
          } else {
            return utf8.decode(DatabaseUniverseCore.stringPtr.asU8List(length))
                as R;
          }
        } else {
          throw ArgumentError('Unsupported aggregation type: $R');
        }
      } finally {
        DatabaseUniverseCore.b.database_universe_value_free(valuePtr);
      }
    });
  }

  @override
  Stream<List<T>> watch({
    bool fireImmediately = false,
    int? offset,
    int? limit,
  }) {
    return watchLazy(fireImmediately: fireImmediately)
        .asyncMap((event) => findAllAsync(offset: offset, limit: limit));
  }

  @override
  Stream<void> watchLazy({bool fireImmediately = false}) {
    if (DatabaseUniverseCore.kIsWeb) {
      throw UnsupportedError('Watchers are not supported on the web');
    }

    final port = ReceivePort();
    final handlePtrPtr =
        DatabaseUniverseCore.ptrPtr.cast<Pointer<CWatchHandle>>();

    DatabaseUniverseCore.b
        .database_universe_watch_query(
          databaseUniverse.getPtr(),
          _ptr,
          port.sendPort.nativePort,
          handlePtrPtr,
        )
        .checkNoError();

    final handlePtr = handlePtrPtr.ptrValue;
    final controller = StreamController<void>(
      onCancel: () {
        databaseUniverse.getPtr(); // Make sure DatabaseUniverse is not closed
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
  void close() {
    DatabaseUniverseCore.b.database_universe_query_free(_ptr);
    _ptrAddress = 0;
  }
}
