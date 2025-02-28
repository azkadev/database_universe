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
typedef FilterQuery<OBJ> = QueryBuilder<OBJ, OBJ, QAfterFilterCondition>
    Function(QueryBuilder<OBJ, OBJ, QFilterCondition> q);

/// Query builders are used to create queries in a safe way.
///
/// Acquire a `QueryBuilder` instance using `collection.where()` or
/// `collection.filter()`.
class QueryBuilder<OBJ, R, S> {
  /// @nodoc
  @protected
  QueryBuilder(DatabaseUniverseCollection<dynamic, OBJ>? collection)
      : _query = _QueryBuilder<OBJ>(collection: collection);

  @protected
  const QueryBuilder._(this._query);

  final _QueryBuilder<OBJ> _query;

  /// @nodoc
  @protected
  static QueryBuilder<OBJ, R, S> apply<OBJ, R, S>(
    QueryBuilder<OBJ, dynamic, dynamic> qb,
    // ignore: library_private_types_in_public_api
    _QueryBuilder<OBJ> Function(_QueryBuilder<OBJ> query) transform,
  ) {
    return QueryBuilder._(transform(qb._query));
  }
}

class _QueryBuilder<OBJ> {
  /// @nodoc
  const _QueryBuilder({
    this.collection,
    this.filter,
    this.filterGroupAnd = true,
    this.filterNot = false,
    this.distinctByProperties = const [],
    this.sortByProperties = const [],
    this.properties = const [],
  });

  /// @nodoc
  final DatabaseUniverseCollection<dynamic, OBJ>? collection;

  /// @nodoc
  final Filter? filter;

  /// @nodoc
  final bool filterGroupAnd;

  /// @nodoc
  final bool filterNot;

  /// @nodoc
  final List<DistinctProperty> distinctByProperties;

  /// @nodoc
  final List<SortProperty> sortByProperties;

  /// @nodoc
  final List<int> properties;

  /// @nodoc
  _QueryBuilder<OBJ> addFilterCondition(Filter cond) {
    if (filterNot) {
      cond = NotGroup(cond);
    }

    late Filter newFilter;

    final filter = this.filter;
    if (filter == null) {
      newFilter = cond;
    } else if (filterGroupAnd) {
      if (filter is AndGroup) {
        newFilter = AndGroup([...filter.filters, cond]);
      } else if (filter is OrGroup) {
        newFilter = OrGroup([
          ...filter.filters.sublist(0, filter.filters.length - 1),
          AndGroup([
            filter.filters.last,
            cond,
          ]),
        ]);
      } else {
        newFilter = AndGroup([filter, cond]);
      }
    } else {
      if (filter is OrGroup) {
        newFilter = OrGroup([...filter.filters, cond]);
      } else {
        newFilter = OrGroup([filter, cond]);
      }
    }

    return copyWith(
      filter: newFilter,
      filterGroupAnd: true,
      filterNot: false,
    );
  }

  /// @nodoc
  _QueryBuilder<OBJ> group(FilterQuery<OBJ> q) {
    // ignore: prefer_const_constructors
    final qb = q(QueryBuilder._(_QueryBuilder()));
    final filter = qb._query.filter;
    if (filter != null) {
      return addFilterCondition(filter);
    } else {
      // ignore: avoid_returning_this
      return this;
    }
  }

  /// @nodoc
  _QueryBuilder<OBJ> object<E>(
    FilterQuery<E> q,
    int property,
  ) {
    // ignore: prefer_const_constructors
    final qb = q(QueryBuilder._(_QueryBuilder()));
    final filter = qb._query.filter;
    if (filter != null) {
      return addFilterCondition(
        ObjectFilter(property: property, filter: filter),
      );
    } else {
      // ignore: avoid_returning_this
      return this;
    }
  }

  ///

  /// @nodoc
  _QueryBuilder<OBJ> addSortBy(
    int property, {
    Sort sort = Sort.asc,
    bool caseSensitive = true,
  }) {
    return copyWith(
      sortByProperties: [
        ...sortByProperties,
        SortProperty(
          property: property,
          sort: sort,
          caseSensitive: caseSensitive,
        ),
      ],
    );
  }

  /// @nodoc
  _QueryBuilder<OBJ> addDistinctBy(int property, {bool caseSensitive = true}) {
    return copyWith(
      distinctByProperties: [
        ...distinctByProperties,
        DistinctProperty(
          property: property,
          caseSensitive: caseSensitive,
        ),
      ],
    );
  }

  /// @nodoc
  _QueryBuilder<OBJ> addProperty(int property) {
    return copyWith(properties: [...properties, property]);
  }

  /// @nodoc
  _QueryBuilder<OBJ> copyWith({
    Filter? filter,
    bool? filterIsGrouped,
    bool? filterGroupAnd,
    bool? filterNot,
    List<DistinctProperty>? distinctByProperties,
    List<SortProperty>? sortByProperties,
    List<int>? properties,
  }) {
    return _QueryBuilder(
      collection: collection,
      filter: filter ?? this.filter,
      filterGroupAnd: filterGroupAnd ?? this.filterGroupAnd,
      filterNot: filterNot ?? this.filterNot,
      distinctByProperties:
          distinctByProperties ?? List.unmodifiable(this.distinctByProperties),
      sortByProperties:
          sortByProperties ?? List.unmodifiable(this.sortByProperties),
      properties: properties ?? this.properties,
    );
  }

  /// @nodoc
  @protected
  DatabaseUniverseQuery<R> build<R>() {
    return collection!.buildQuery(
      filter: filter,
      sortBy: sortByProperties,
      distinctBy: distinctByProperties,
      properties: properties,
    );
  }
}

/// @nodoc
///
/// Right after query starts
@protected
interface class QStart
    implements QFilterCondition, QSortBy, QDistinct, QProperty, QOperations {}

/// @nodoc
@protected
sealed class QFilterCondition {}

/// @nodoc
@protected
interface class QAfterFilterCondition
    implements
        QFilterCondition,
        QFilterOperator,
        QSortBy,
        QDistinct,
        QProperty,
        QOperations {}

/// @nodoc
@protected
interface class QFilterOperator {}

/// @nodoc
@protected
interface class QAfterFilterOperator implements QFilterCondition {}

/// @nodoc
@protected
interface class QSortBy {}

/// @nodoc
@protected
interface class QAfterSortBy
    implements QSortThenBy, QDistinct, QProperty, QOperations {}

/// @nodoc
@protected
interface class QSortThenBy {}

/// @nodoc
@protected
interface class QDistinct {}

/// @nodoc
@protected
interface class QAfterDistinct implements QProperty, QOperations {}

/// @nodoc
@protected
interface class QProperty {}

/// @nodoc
@protected
interface class QAfterProperty implements QOperations {}

/// @nodoc
@protected
interface class QOperations {}
