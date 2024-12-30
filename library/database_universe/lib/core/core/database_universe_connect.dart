// ignore_for_file: avoid_print

part of database_universe;

abstract class _DatabaseUniverseConnect {
  static const _handlers = {
    ConnectAction.listInstances: _listInstances,
    ConnectAction.getSchemas: _getSchemas,
    ConnectAction.watchInstance: _watchInstance,
    ConnectAction.executeQuery: _executeQuery,
    ConnectAction.deleteQuery: _deleteQuery,
    ConnectAction.importJson: _importJson,
    ConnectAction.editProperty: _editProperty,
  };

  static final _instances = <String, DatabaseUniverse>{};
  static var _initialized = false;

  // ignore: cancel_subscriptions
  static final _querySubscription = <StreamSubscription<void>>[];
  static final _collectionSubscriptions = <StreamSubscription<void>>[];

  static void initialize(DatabaseUniverse databaseUniverse) {
    if (!_initialized) {
      _initialized = true;
      _printConnection();
      _registerHandlers();
    }

    if (!_instances.containsKey(databaseUniverse.name)) {
      _instances[databaseUniverse.name] = databaseUniverse;
      postEvent(ConnectEvent.instancesChanged.event, {});
    }
  }

  static void _registerHandlers() {
    for (final handler in _handlers.entries) {
      registerExtension(handler.key.method, (method, parameters) async {
        try {
          final args = parameters.containsKey('args')
              ? jsonDecode(parameters['args']!) as Map<String, dynamic>
              : <String, dynamic>{};
          final result = <String, dynamic>{'result': await handler.value(args)};
          return ServiceExtensionResponse.result(jsonEncode(result));
        } catch (e) {
          return ServiceExtensionResponse.error(
            ServiceExtensionResponse.extensionError,
            e.toString(),
          );
        }
      });
    }
  }

  static void _printConnection() {
    Service.getInfo().then((ServiceProtocolInfo info) {
      final serviceUri = info.serverUri;
      if (serviceUri == null) {
        return;
      }
      final port = serviceUri.port;
      var path = serviceUri.path;
      if (path.endsWith('/')) {
        path = path.substring(0, path.length - 1);
      }
      if (path.endsWith('=')) {
        path = path.substring(0, path.length - 1);
      }
      final url =
          ' https://inspect.database_universe.dev/${DatabaseUniverse.version}/#/$port$path ';
      String line(String text, String fill) {
        final fillCount = url.length - text.length;
        final left = List.filled(fillCount ~/ 2, fill);
        final right = List.filled(fillCount - left.length, fill);
        return left.join() + text + right.join();
      }

      print('╔${line('', '═')}╗');
      print('║${line('DATABASE UNIVERSE CONNECT STARTED', ' ')}║');
      print('╟${line('', '─')}╢');
      print(
          '║${line('Open the link to connect to the DatabaseUniverse', ' ')}║');
      print('║${line('Inspector while this build is running.', ' ')}║');
      print('╟${line('', '─')}╢');
      print('║$url║');
      print('╚${line('', '═')}╝');
    });
  }

  static Future<dynamic> _getSchemas(Map<String, dynamic> params) async {
    final p = ConnectInstancePayload.fromJson(params);
    final databaseUniverse = _instances[p.instance]!;
    return ConnectSchemasPayload(databaseUniverse.schemas);
  }

  static Future<dynamic> _listInstances(Map<String, dynamic> _) async {
    return ConnectInstanceNamesPayload(_instances.keys.toList());
  }

  static Future<dynamic> _watchInstance(Map<String, dynamic> params) async {
    for (final sub in _collectionSubscriptions) {
      unawaited(sub.cancel());
    }

    _collectionSubscriptions.clear();
    if (params.isEmpty) {
      return true;
    }

    final p = ConnectInstancePayload.fromJson(params);
    final databaseUniverse = _instances[p.instance]!;

    void sendCollectionInfo(
        DatabaseUniverseCollection<dynamic, dynamic> collection) {
      final count = collection.count();
      final size = collection.getSize(includeIndexes: true);
      final collectionInfo = ConnectCollectionInfoPayload(
        instance: collection.database_universe.name,
        collection: collection.schema.name,
        size: size,
        count: count,
      );
      postEvent(
        ConnectEvent.collectionInfoChanged.event,
        collectionInfo.toJson(),
      );
    }

    for (var i = 0; i < databaseUniverse.schemas.length; i++) {
      if (databaseUniverse.schemas[i].embedded) {
        break;
      }

      final collection =
          databaseUniverse.collectionByIndex<dynamic, dynamic>(i);
      final sub = collection.watchLazy(fireImmediately: true).listen((_) {
        sendCollectionInfo(collection);
      });
      _collectionSubscriptions.add(sub);
    }
  }

  static Future<dynamic> _executeQuery(Map<String, dynamic> params) async {
    for (final sub in _querySubscription) {
      unawaited(sub.cancel());
    }
    _querySubscription.clear();

    final cQuery = ConnectQueryPayload.fromJson(params);
    final databaseUniverse = _instances[cQuery.instance]!;
    final query = cQuery.toQuery(databaseUniverse);

    _querySubscription.add(
      query.watchLazy().listen((_) {
        postEvent(ConnectEvent.queryChanged.event, {});
      }),
    );

    final count = query.count();
    final objects = await databaseUniverse.readAsync((databaseUniverse) {
      return query.exportJson(offset: cQuery.offset, limit: cQuery.limit);
    });
    query.close();

    return ConnectObjectsPayload(
      instance: cQuery.instance,
      collection: cQuery.collection,
      objects: objects,
      count: count,
    );
  }

  static Future<dynamic> _deleteQuery(Map<String, dynamic> params) async {
    final cQuery = ConnectQueryPayload.fromJson(params);
    final databaseUniverse = _instances[cQuery.instance]!;
    final query = cQuery.toQuery(databaseUniverse);
    await databaseUniverse.writeAsync((databaseUniverse) {
      query.deleteAll();
      query.close();
    });
  }

  static Future<dynamic> _importJson(Map<String, dynamic> params) {
    final p = ConnectObjectsPayload.fromJson(params);
    final databaseUniverse = _instances[p.instance]!;
    final colIndex =
        databaseUniverse.schemas.indexWhere((e) => e.name == p.collection);
    return databaseUniverse.writeAsync((databaseUniverse) {
      databaseUniverse
          .collectionByIndex<dynamic, dynamic>(colIndex)
          .importJson(p.objects);
    });
  }

  static Future<dynamic> _editProperty(Map<String, dynamic> params) async {
    final cEdit = ConnectEditPayload.fromJson(params);
    final databaseUniverse = _instances[cEdit.instance]!;
    final keys = cEdit.path.split('.');

    final colIndex =
        databaseUniverse.schemas.indexWhere((e) => e.name == cEdit.collection);
    final colSchema = databaseUniverse.schemas[colIndex];
    final idIndex = colSchema.getPropertyIndex(colSchema.idName!);
    final query = databaseUniverse
        .collectionByIndex<dynamic, dynamic>(colIndex)
        .buildQuery<dynamic>(
          filter: EqualCondition(
            property: idIndex == -1 ? 0 : idIndex,
            value: cEdit.id,
          ),
        );

    final objects = query.exportJson();
    if (objects.isNotEmpty) {
      dynamic object = objects.first;
      for (var i = 0; i < keys.length; i++) {
        if (i == keys.length - 1 && object is Map) {
          object[keys[i]] = cEdit.value;
        } else if (object is Map) {
          object = object[keys[i]];
        } else if (object is List) {
          object = object[int.parse(keys[i])];
        }
      }

      await databaseUniverse.writeAsync(
        (databaseUniverse) => databaseUniverse
            .collectionByIndex<dynamic, dynamic>(colIndex)
            .importJson(objects),
      );
    }
  }
}
