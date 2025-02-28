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

/// @nodoc
@protected
typedef FilterRepeatModifier<OBJ, R, E>
    = QueryBuilder<OBJ, R, QAfterFilterCondition> Function(
  QueryBuilder<OBJ, R, QFilterCondition> q,
  E element,
);

/// Logical operators for query builders.
extension QueryFilterAndOr<OBJ, R> on QueryBuilder<OBJ, R, QFilterOperator> {
  /// Intersection of two filter conditions.
  QueryBuilder<OBJ, R, QFilterCondition> and() {
    return QueryBuilder.apply(
      this,
      (q) => q.copyWith(filterGroupAnd: true),
    );
  }

  /// Union of two filter conditions.
  QueryBuilder<OBJ, R, QFilterCondition> or() {
    return QueryBuilder.apply(
      this,
      (q) => q.copyWith(filterGroupAnd: false),
    );
  }
}

/// Filter groups, logical not, anyOf, and allOf modifiers for query builders.
extension QueryFilterNotAnyAll<OBJ, R>
    on QueryBuilder<OBJ, R, QFilterCondition> {
  /// Group filter conditions.
  QueryBuilder<OBJ, R, QAfterFilterCondition> group(FilterQuery<OBJ> q) {
    return QueryBuilder.apply(this, (query) => query.group(q));
  }

  /// Complement the next filter condition or group.
  QueryBuilder<OBJ, R, QFilterCondition> not() {
    return QueryBuilder.apply(
      this,
      (q) => q.copyWith(filterNot: !q.filterNot),
    );
  }

  /// Joins the results of the [modifier] for each item in [items] using logical
  /// OR. So an object will be included if it matches at least one of the
  /// resulting filters.
  ///
  /// If [items] is empty, this condition will match nothing.
  QueryBuilder<OBJ, R, QAfterFilterCondition> anyOf<E>(
    Iterable<E> items,
    FilterRepeatModifier<OBJ, OBJ, E> modifier,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (items.isEmpty) {
        return query.addFilterCondition(
          const BetweenCondition(property: 0, lower: 1, upper: 0),
        );
      } else {
        return query.group((q) {
          var q2 = QueryBuilder<OBJ, OBJ, QAfterFilterCondition>._(q._query);
          for (final e in items) {
            q2 = modifier(q2.or(), e);
          }
          return q2;
        });
      }
    });
  }

  /// Joins the results of the [modifier] for each item in [items] using logical
  /// AND. So an object will be included if it matches all of the resulting
  /// filters.
  ///
  /// If [items] is empty, this condition will match everything.
  QueryBuilder<OBJ, R, QAfterFilterCondition> allOf<E>(
    Iterable<E> items,
    FilterRepeatModifier<OBJ, OBJ, E> modifier,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (items.isEmpty) {
        return query.addFilterCondition(
          const GreaterOrEqualCondition(property: 0, value: null),
        );
      } else {
        return query.group((q) {
          var q2 = QueryBuilder<OBJ, OBJ, QAfterFilterCondition>._(q._query);
          for (final e in items) {
            q2 = modifier(q2.and(), e);
          }
          return q2;
        });
      }
    });
  }
}

/// @nodoc
@protected
typedef QueryOption<OBJ, S, RS> = QueryBuilder<OBJ, OBJ, RS> Function(
  QueryBuilder<OBJ, OBJ, S> q,
);

/// Optional query modifier.
extension QueryModifier<OBJ, S> on QueryBuilder<OBJ, OBJ, S> {
  /// Only apply a part of the query if `enabled` is true.
  QueryBuilder<OBJ, OBJ, RS> optional<RS>(
    bool enabled,
    QueryOption<OBJ, S, RS> option,
  ) {
    if (enabled) {
      return option(this);
    } else {
      return QueryBuilder._(_query);
    }
  }
}

/// Asynchronous operations for queries.
extension QueryAsync<T> on DatabaseUniverseQuery<T> {
  /// {@macro query_find_first}
  Future<T?> findFirstAsync({int? offset}) => databaseUniverse
      .readAsync((databaseUniverse) => findFirst(offset: offset));

  /// {@macro query_find_all}
  Future<List<T>> findAllAsync({int? offset, int? limit}) => databaseUniverse
      .readAsync((databaseUniverse) => findAll(offset: offset, limit: limit));

  /// {@macro aggregation_count}
  Future<int> countAsync() =>
      databaseUniverse.readAsync((databaseUniverse) => count());

  /// {@macro aggregation_is_empty}
  Future<bool> isEmptyAsync() =>
      databaseUniverse.readAsync((databaseUniverse) => isEmpty());

  /// @nodoc
  @protected
  Future<R?> aggregateAsync<R>(Aggregation op) =>
      databaseUniverse.readAsync((databaseUniverse) => aggregate(op));
}

/// Aggregation operations for number queries.
extension QueryNumAggregation<T extends num?> on DatabaseUniverseQuery<T?> {
  /// {@macro aggregation_min}
  T? min() => aggregate(Aggregation.min);

  /// {@macro aggregation_min}
  Future<T?> minAsync() => aggregateAsync(Aggregation.min);

  /// {@macro aggregation_max}
  T? max() => aggregate(Aggregation.max);

  /// {@macro aggregation_max}
  Future<T?> maxAsync() => aggregateAsync(Aggregation.max);

  /// {@macro aggregation_sum}
  T sum() => aggregate(Aggregation.sum)!;

  /// {@macro aggregation_sum}
  Future<T> sumAsync() =>
      aggregateAsync<T>(Aggregation.sum).then((value) => value!);

  /// {@macro aggregation_average}
  double average() => aggregate(Aggregation.average) ?? double.nan;

  /// {@macro aggregation_average}
  Future<double> averageAsync() => aggregateAsync<double>(Aggregation.average)
      .then((value) => value ?? double.nan);
}

/// Aggregation operations for date queries.
extension QueryDateAggregation<T extends DateTime?>
    on DatabaseUniverseQuery<T> {
  /// {@macro aggregation_min}
  DateTime? min() => aggregate(Aggregation.min);

  /// {@macro aggregation_min}
  Future<DateTime?> minAsync() => aggregateAsync(Aggregation.min);

  /// {@macro aggregation_max}
  DateTime? max() => aggregate(Aggregation.max);

  /// {@macro aggregation_max}
  Future<DateTime?> maxAsync() => aggregateAsync(Aggregation.max);
}

/// Aggregation operations for string queries.
extension QueryStringAggregation<T extends String?>
    on DatabaseUniverseQuery<T?> {
  /// {@macro aggregation_min}
  T? min() => aggregate(Aggregation.min);

  /// {@macro aggregation_min}
  Future<T?> minAsync() => aggregateAsync(Aggregation.min);

  /// {@macro aggregation_max}
  T? max() => aggregate(Aggregation.max);

  /// {@macro aggregation_max}
  Future<T?> maxAsync() => aggregateAsync(Aggregation.max);
}

/// Operations for query builders.
extension QueryExecute<OBJ, R> on QueryBuilder<OBJ, R, QOperations> {
  /// Create a query from this query builder.
  DatabaseUniverseQuery<R> build() => _query.build();

  T _withQuery<T>(T Function(DatabaseUniverseQuery<R> q) f) {
    final q = build();
    try {
      return f(q);
    } finally {
      q.close();
    }
  }

  /// {@macro query_find_first}
  R? findFirst({int? offset}) => _withQuery((q) => q.findFirst(offset: offset));

  /// {@macro query_find_first}
  Future<R?> findFirstAsync({int? offset}) =>
      _withQueryAsync((q) => q.findFirstAsync(offset: offset));

  /// {@macro query_find_all}
  List<R> findAll({int? offset, int? limit}) =>
      _withQuery((q) => q.findAll(offset: offset, limit: limit));

  /// {@macro query_find_all}
  Future<List<R>> findAllAsync({int? offset, int? limit}) =>
      _withQueryAsync((q) => q.findAllAsync(offset: offset, limit: limit));

  /// {@macro query_delete_first}
  bool deleteFirst({int? offset}) =>
      _withQuery((q) => q.deleteFirst(offset: offset));

  /// {@macro query_delete_all}
  int deleteAll({int? offset, int? limit}) =>
      _withQuery((q) => q.deleteAll(offset: offset, limit: limit));

  /// {@macro aggregation_count}
  int count() => _withQuery((q) => q.count());

  /// {@macro aggregation_count}
  Future<int> countAsync() => _withQueryAsync((q) => q.countAsync());

  /// {@macro aggregation_is_empty}
  bool isEmpty() => _withQuery((q) => q.isEmpty());

  /// {@macro aggregation_is_empty}
  Future<bool> isEmptyAsync() => _withQueryAsync((q) => q.isEmptyAsync());

  /// {@macro query_export_json}
  List<Map<String, dynamic>> exportJson({int? offset, int? limit}) =>
      _withQuery((q) => q.exportJson(offset: offset, limit: limit));

  /// {@macro query_watch}
  Stream<List<R>> watch({
    bool fireImmediately = false,
    int? offset,
    int? limit,
  }) {
    final q = build();
    final controller = StreamController<List<R>>();
    q
        .watch(fireImmediately: fireImmediately, offset: offset, limit: limit)
        .listen(
      controller.add,
      onError: controller.addError,
      onDone: () {
        controller.close();
        q.close();
      },
    );
    return controller.stream;
  }

  /// {@macro query_watch_lazy}
  Stream<void> watchLazy({bool fireImmediately = false}) =>
      _withQuery((q) => q.watchLazy(fireImmediately: fireImmediately));

  Future<T> _withQueryAsync<T>(
    Future<T> Function(DatabaseUniverseQuery<R> q) f,
  ) async {
    final q = build();
    try {
      return await f(q);
    } finally {
      q.close();
    }
  }
}

/// Aggregation operations for number query builders.
extension QueryExecuteNumAggregation<OBJ, T extends num>
    on QueryBuilder<OBJ, T?, QAfterProperty> {
  /// {@macro aggregation_min}
  T? min() => _withQuery((q) => q.min());

  /// {@macro aggregation_max}
  T? max() => _withQuery((q) => q.max());

  /// {@macro aggregation_average}
  double average() => _withQuery((q) => q.average());

  /// {@macro aggregation_sum}
  T sum() => _withQuery((q) => q.sum());

  /// {@macro aggregation_min}
  Future<T?> minAsync() => _withQueryAsync((q) => q.minAsync());

  /// {@macro aggregation_max}
  Future<T?> maxAsync() => _withQueryAsync((q) => q.maxAsync());

  /// {@macro aggregation_average}
  Future<double> averageAsync() => _withQueryAsync((q) => q.averageAsync());

  /// {@macro aggregation_sum}
  Future<T> sumAsync() => _withQueryAsync((q) => q.sumAsync());
}

/// Aggregation operations for date query builders.
extension QueryExecuteDateAggregation<OBJ>
    on QueryBuilder<OBJ, DateTime?, QAfterProperty> {
  /// {@macro aggregation_min}
  DateTime? min() => _withQuery((q) => q.min());

  /// {@macro aggregation_max}
  DateTime? max() => _withQuery((q) => q.max());

  /// {@macro aggregation_min}
  Future<DateTime?> minAsync() => _withQueryAsync((q) => q.minAsync());

  /// {@macro aggregation_max}
  Future<DateTime?> maxAsync() => _withQueryAsync((q) => q.maxAsync());
}

/// Aggregation operations for string query builders.
extension QueryExecuteStringAggregation<OBJ>
    on QueryBuilder<OBJ, String?, QAfterProperty> {
  /// {@macro aggregation_min}
  String? min() => _withQuery((q) => q.min());

  /// {@macro aggregation_max}
  String? max() => _withQuery((q) => q.max());

  /// {@macro aggregation_min}
  Future<String?> minAsync() => _withQueryAsync((q) => q.minAsync());

  /// {@macro aggregation_max}
  Future<String?> maxAsync() => _withQueryAsync((q) => q.maxAsync());
}
