// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'threads_comment_data_local_database.dart';

// **************************************************************************
// _DatabaseUniverseCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors

extension GetThreadsCommentDataLocalDatabaseCollection on DatabaseUniverse {
  DatabaseUniverseCollection<int, ThreadsCommentDataLocalDatabase>
      get threadsCommentDataLocalDatabases => this.collection();
}

const ThreadsCommentDataLocalDatabaseSchema = DatabaseUniverseGeneratedSchema(
  schema: DatabaseUniverseSchema(
    name: 'ThreadsCommentDataLocalDatabase',
    idName: 'id',
    embedded: false,
    properties: [
      DatabaseUniversePropertySchema(
        name: 'special_type',
        type: DatabaseUniverseType.string,
      ),
      DatabaseUniversePropertySchema(
        name: 'threads_unique_id',
        type: DatabaseUniverseType.string,
      ),
      DatabaseUniversePropertySchema(
        name: 'comment',
        type: DatabaseUniverseType.long,
      ),
    ],
    indexes: [],
  ),
  converter:
      DatabaseUniverseObjectConverter<int, ThreadsCommentDataLocalDatabase>(
    serialize: serializeThreadsCommentDataLocalDatabase,
    deserialize: deserializeThreadsCommentDataLocalDatabase,
    deserializeProperty: deserializeThreadsCommentDataLocalDatabaseProp,
  ),
  embeddedSchemas: [],
);

@databaseUniverseProtected
int serializeThreadsCommentDataLocalDatabase(
    DatabaseUniverseWriter writer, ThreadsCommentDataLocalDatabase object) {
  DatabaseUniverseCore.writeString(writer, 1, object.special_type);
  DatabaseUniverseCore.writeString(writer, 2, object.threads_unique_id);
  DatabaseUniverseCore.writeLong(writer, 3, object.comment);
  return object.id;
}

@databaseUniverseProtected
ThreadsCommentDataLocalDatabase deserializeThreadsCommentDataLocalDatabase(
    DatabaseUniverseReader reader) {
  final object = ThreadsCommentDataLocalDatabase();
  object.special_type = DatabaseUniverseCore.readString(reader, 1) ?? '';
  object.id = DatabaseUniverseCore.readId(reader);
  object.threads_unique_id = DatabaseUniverseCore.readString(reader, 2) ?? '';
  object.comment = DatabaseUniverseCore.readLong(reader, 3);
  return object;
}

@databaseUniverseProtected
dynamic deserializeThreadsCommentDataLocalDatabaseProp(
    DatabaseUniverseReader reader, int property) {
  switch (property) {
    case 1:
      return DatabaseUniverseCore.readString(reader, 1) ?? '';
    case 0:
      return DatabaseUniverseCore.readId(reader);
    case 2:
      return DatabaseUniverseCore.readString(reader, 2) ?? '';
    case 3:
      return DatabaseUniverseCore.readLong(reader, 3);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _ThreadsCommentDataLocalDatabaseUpdate {
  bool call({
    required int id,
    String? special_type,
    String? threads_unique_id,
    int? comment,
  });
}

class _ThreadsCommentDataLocalDatabaseUpdateImpl
    implements _ThreadsCommentDataLocalDatabaseUpdate {
  const _ThreadsCommentDataLocalDatabaseUpdateImpl(this.collection);

  final DatabaseUniverseCollection<int, ThreadsCommentDataLocalDatabase>
      collection;

  @override
  bool call({
    required int id,
    Object? special_type = ignore,
    Object? threads_unique_id = ignore,
    Object? comment = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (special_type != ignore) 1: special_type as String?,
          if (threads_unique_id != ignore) 2: threads_unique_id as String?,
          if (comment != ignore) 3: comment as int?,
        }) >
        0;
  }
}

sealed class _ThreadsCommentDataLocalDatabaseUpdateAll {
  int call({
    required List<int> id,
    String? special_type,
    String? threads_unique_id,
    int? comment,
  });
}

class _ThreadsCommentDataLocalDatabaseUpdateAllImpl
    implements _ThreadsCommentDataLocalDatabaseUpdateAll {
  const _ThreadsCommentDataLocalDatabaseUpdateAllImpl(this.collection);

  final DatabaseUniverseCollection<int, ThreadsCommentDataLocalDatabase>
      collection;

  @override
  int call({
    required List<int> id,
    Object? special_type = ignore,
    Object? threads_unique_id = ignore,
    Object? comment = ignore,
  }) {
    return collection.updateProperties(id, {
      if (special_type != ignore) 1: special_type as String?,
      if (threads_unique_id != ignore) 2: threads_unique_id as String?,
      if (comment != ignore) 3: comment as int?,
    });
  }
}

extension ThreadsCommentDataLocalDatabaseUpdate
    on DatabaseUniverseCollection<int, ThreadsCommentDataLocalDatabase> {
  _ThreadsCommentDataLocalDatabaseUpdate get update =>
      _ThreadsCommentDataLocalDatabaseUpdateImpl(this);

  _ThreadsCommentDataLocalDatabaseUpdateAll get updateAll =>
      _ThreadsCommentDataLocalDatabaseUpdateAllImpl(this);
}

sealed class _ThreadsCommentDataLocalDatabaseQueryUpdate {
  int call({
    String? special_type,
    String? threads_unique_id,
    int? comment,
  });
}

class _ThreadsCommentDataLocalDatabaseQueryUpdateImpl
    implements _ThreadsCommentDataLocalDatabaseQueryUpdate {
  const _ThreadsCommentDataLocalDatabaseQueryUpdateImpl(this.query,
      {this.limit});

  final DatabaseUniverseQuery<ThreadsCommentDataLocalDatabase> query;
  final int? limit;

  @override
  int call({
    Object? special_type = ignore,
    Object? threads_unique_id = ignore,
    Object? comment = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (special_type != ignore) 1: special_type as String?,
      if (threads_unique_id != ignore) 2: threads_unique_id as String?,
      if (comment != ignore) 3: comment as int?,
    });
  }
}

extension ThreadsCommentDataLocalDatabaseQueryUpdate
    on DatabaseUniverseQuery<ThreadsCommentDataLocalDatabase> {
  _ThreadsCommentDataLocalDatabaseQueryUpdate get updateFirst =>
      _ThreadsCommentDataLocalDatabaseQueryUpdateImpl(this, limit: 1);

  _ThreadsCommentDataLocalDatabaseQueryUpdate get updateAll =>
      _ThreadsCommentDataLocalDatabaseQueryUpdateImpl(this);
}

class _ThreadsCommentDataLocalDatabaseQueryBuilderUpdateImpl
    implements _ThreadsCommentDataLocalDatabaseQueryUpdate {
  const _ThreadsCommentDataLocalDatabaseQueryBuilderUpdateImpl(this.query,
      {this.limit});

  final QueryBuilder<ThreadsCommentDataLocalDatabase,
      ThreadsCommentDataLocalDatabase, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? special_type = ignore,
    Object? threads_unique_id = ignore,
    Object? comment = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (special_type != ignore) 1: special_type as String?,
        if (threads_unique_id != ignore) 2: threads_unique_id as String?,
        if (comment != ignore) 3: comment as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension ThreadsCommentDataLocalDatabaseQueryBuilderUpdate on QueryBuilder<
    ThreadsCommentDataLocalDatabase,
    ThreadsCommentDataLocalDatabase,
    QOperations> {
  _ThreadsCommentDataLocalDatabaseQueryUpdate get updateFirst =>
      _ThreadsCommentDataLocalDatabaseQueryBuilderUpdateImpl(this, limit: 1);

  _ThreadsCommentDataLocalDatabaseQueryUpdate get updateAll =>
      _ThreadsCommentDataLocalDatabaseQueryBuilderUpdateImpl(this);
}

extension ThreadsCommentDataLocalDatabaseQueryFilter on QueryBuilder<
    ThreadsCommentDataLocalDatabase,
    ThreadsCommentDataLocalDatabase,
    QFilterCondition> {
  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> special_typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> special_typeGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> special_typeGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> special_typeLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> special_typeLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> special_typeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> special_typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> special_typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
          QAfterFilterCondition>
      special_typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
          QAfterFilterCondition>
      special_typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> special_typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> special_typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> idEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> idGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> idGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> idLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 0,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 0,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> threads_unique_idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> threads_unique_idGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> threads_unique_idGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> threads_unique_idLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> threads_unique_idLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> threads_unique_idBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> threads_unique_idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> threads_unique_idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
          QAfterFilterCondition>
      threads_unique_idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
          QAfterFilterCondition>
      threads_unique_idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> threads_unique_idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> threads_unique_idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> commentEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> commentGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> commentGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> commentLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> commentLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterFilterCondition> commentBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }
}

extension ThreadsCommentDataLocalDatabaseQueryObject on QueryBuilder<
    ThreadsCommentDataLocalDatabase,
    ThreadsCommentDataLocalDatabase,
    QFilterCondition> {}

extension ThreadsCommentDataLocalDatabaseQuerySortBy on QueryBuilder<
    ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase, QSortBy> {
  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> sortBySpecial_type({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> sortBySpecial_typeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> sortByThreads_unique_id({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> sortByThreads_unique_idDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> sortByComment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> sortByCommentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }
}

extension ThreadsCommentDataLocalDatabaseQuerySortThenBy on QueryBuilder<
    ThreadsCommentDataLocalDatabase,
    ThreadsCommentDataLocalDatabase,
    QSortThenBy> {
  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> thenBySpecial_type({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> thenBySpecial_typeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> thenByThreads_unique_id({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> thenByThreads_unique_idDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> thenByComment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterSortBy> thenByCommentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc);
    });
  }
}

extension ThreadsCommentDataLocalDatabaseQueryWhereDistinct on QueryBuilder<
    ThreadsCommentDataLocalDatabase,
    ThreadsCommentDataLocalDatabase,
    QDistinct> {
  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterDistinct> distinctBySpecial_type({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterDistinct> distinctByThreads_unique_id({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, ThreadsCommentDataLocalDatabase,
      QAfterDistinct> distinctByComment() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }
}

extension ThreadsCommentDataLocalDatabaseQueryProperty1 on QueryBuilder<
    ThreadsCommentDataLocalDatabase,
    ThreadsCommentDataLocalDatabase,
    QProperty> {
  QueryBuilder<ThreadsCommentDataLocalDatabase, String, QAfterProperty>
      special_typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, int, QAfterProperty>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, String, QAfterProperty>
      threads_unique_idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, int, QAfterProperty>
      commentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension ThreadsCommentDataLocalDatabaseQueryProperty2<R>
    on QueryBuilder<ThreadsCommentDataLocalDatabase, R, QAfterProperty> {
  QueryBuilder<ThreadsCommentDataLocalDatabase, (R, String), QAfterProperty>
      special_typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, (R, int), QAfterProperty>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, (R, String), QAfterProperty>
      threads_unique_idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, (R, int), QAfterProperty>
      commentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension ThreadsCommentDataLocalDatabaseQueryProperty3<R1, R2>
    on QueryBuilder<ThreadsCommentDataLocalDatabase, (R1, R2), QAfterProperty> {
  QueryBuilder<ThreadsCommentDataLocalDatabase, (R1, R2, String), QOperations>
      special_typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, (R1, R2, int), QOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, (R1, R2, String), QOperations>
      threads_unique_idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ThreadsCommentDataLocalDatabase, (R1, R2, int), QOperations>
      commentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}
