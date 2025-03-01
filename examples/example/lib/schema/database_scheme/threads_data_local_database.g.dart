// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'threads_data_local_database.dart';

// **************************************************************************
// _DatabaseUniverseCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors

extension GetThreadsDataLocalDatabaseCollection on DatabaseUniverse {
  DatabaseUniverseCollection<int, ThreadsDataLocalDatabase> get threadsDataLocalDatabases => this.collection();
}

const ThreadsDataLocalDatabaseSchema = DatabaseUniverseGeneratedSchema(
  schema: DatabaseUniverseSchema(
    name: 'ThreadsDataLocalDatabase',
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
        name: 'thread',
        type: DatabaseUniverseType.string,
      ),
      DatabaseUniversePropertySchema(
        name: 'view_count',
        type: DatabaseUniverseType.long,
      ),
      DatabaseUniversePropertySchema(
        name: 'thread_create_date',
        type: DatabaseUniverseType.long,
      ),
      DatabaseUniversePropertySchema(
        name: 'thread_update_date',
        type: DatabaseUniverseType.long,
      ),
    ],
    indexes: [],
  ),
  converter: DatabaseUniverseObjectConverter<int, ThreadsDataLocalDatabase>(
    serialize: serializeThreadsDataLocalDatabase,
    deserialize: deserializeThreadsDataLocalDatabase,
    deserializeProperty: deserializeThreadsDataLocalDatabaseProp,
  ),
  embeddedSchemas: [],
);

@databaseUniverseProtected
int serializeThreadsDataLocalDatabase(DatabaseUniverseWriter writer, ThreadsDataLocalDatabase object) {
  DatabaseUniverseCore.writeString(writer, 1, object.special_type);
  DatabaseUniverseCore.writeString(writer, 2, object.threads_unique_id);
  DatabaseUniverseCore.writeString(writer, 3, object.thread);
  DatabaseUniverseCore.writeLong(writer, 4, object.view_count);
  DatabaseUniverseCore.writeLong(writer, 5, object.thread_create_date);
  DatabaseUniverseCore.writeLong(writer, 6, object.thread_update_date);
  return object.id;
}

@databaseUniverseProtected
ThreadsDataLocalDatabase deserializeThreadsDataLocalDatabase(DatabaseUniverseReader reader) {
  final object = ThreadsDataLocalDatabase();
  object.special_type = DatabaseUniverseCore.readString(reader, 1) ?? '';
  object.id = DatabaseUniverseCore.readId(reader);
  object.threads_unique_id = DatabaseUniverseCore.readString(reader, 2) ?? '';
  object.thread = DatabaseUniverseCore.readString(reader, 3) ?? '';
  object.view_count = DatabaseUniverseCore.readLong(reader, 4);
  object.thread_create_date = DatabaseUniverseCore.readLong(reader, 5);
  object.thread_update_date = DatabaseUniverseCore.readLong(reader, 6);
  return object;
}

@databaseUniverseProtected
dynamic deserializeThreadsDataLocalDatabaseProp(DatabaseUniverseReader reader, int property) {
  switch (property) {
    case 1:
      return DatabaseUniverseCore.readString(reader, 1) ?? '';
    case 0:
      return DatabaseUniverseCore.readId(reader);
    case 2:
      return DatabaseUniverseCore.readString(reader, 2) ?? '';
    case 3:
      return DatabaseUniverseCore.readString(reader, 3) ?? '';
    case 4:
      return DatabaseUniverseCore.readLong(reader, 4);
    case 5:
      return DatabaseUniverseCore.readLong(reader, 5);
    case 6:
      return DatabaseUniverseCore.readLong(reader, 6);
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _ThreadsDataLocalDatabaseUpdate {
  bool call({
    required int id,
    String? special_type,
    String? threads_unique_id,
    String? thread,
    int? view_count,
    int? thread_create_date,
    int? thread_update_date,
  });
}

class _ThreadsDataLocalDatabaseUpdateImpl implements _ThreadsDataLocalDatabaseUpdate {
  const _ThreadsDataLocalDatabaseUpdateImpl(this.collection);

  final DatabaseUniverseCollection<int, ThreadsDataLocalDatabase> collection;

  @override
  bool call({
    required int id,
    Object? special_type = ignore,
    Object? threads_unique_id = ignore,
    Object? thread = ignore,
    Object? view_count = ignore,
    Object? thread_create_date = ignore,
    Object? thread_update_date = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (special_type != ignore) 1: special_type as String?,
          if (threads_unique_id != ignore) 2: threads_unique_id as String?,
          if (thread != ignore) 3: thread as String?,
          if (view_count != ignore) 4: view_count as int?,
          if (thread_create_date != ignore) 5: thread_create_date as int?,
          if (thread_update_date != ignore) 6: thread_update_date as int?,
        }) >
        0;
  }
}

sealed class _ThreadsDataLocalDatabaseUpdateAll {
  int call({
    required List<int> id,
    String? special_type,
    String? threads_unique_id,
    String? thread,
    int? view_count,
    int? thread_create_date,
    int? thread_update_date,
  });
}

class _ThreadsDataLocalDatabaseUpdateAllImpl implements _ThreadsDataLocalDatabaseUpdateAll {
  const _ThreadsDataLocalDatabaseUpdateAllImpl(this.collection);

  final DatabaseUniverseCollection<int, ThreadsDataLocalDatabase> collection;

  @override
  int call({
    required List<int> id,
    Object? special_type = ignore,
    Object? threads_unique_id = ignore,
    Object? thread = ignore,
    Object? view_count = ignore,
    Object? thread_create_date = ignore,
    Object? thread_update_date = ignore,
  }) {
    return collection.updateProperties(id, {
      if (special_type != ignore) 1: special_type as String?,
      if (threads_unique_id != ignore) 2: threads_unique_id as String?,
      if (thread != ignore) 3: thread as String?,
      if (view_count != ignore) 4: view_count as int?,
      if (thread_create_date != ignore) 5: thread_create_date as int?,
      if (thread_update_date != ignore) 6: thread_update_date as int?,
    });
  }
}

extension ThreadsDataLocalDatabaseUpdate on DatabaseUniverseCollection<int, ThreadsDataLocalDatabase> {
  _ThreadsDataLocalDatabaseUpdate get update => _ThreadsDataLocalDatabaseUpdateImpl(this);

  _ThreadsDataLocalDatabaseUpdateAll get updateAll => _ThreadsDataLocalDatabaseUpdateAllImpl(this);
}

sealed class _ThreadsDataLocalDatabaseQueryUpdate {
  int call({
    String? special_type,
    String? threads_unique_id,
    String? thread,
    int? view_count,
    int? thread_create_date,
    int? thread_update_date,
  });
}

class _ThreadsDataLocalDatabaseQueryUpdateImpl implements _ThreadsDataLocalDatabaseQueryUpdate {
  const _ThreadsDataLocalDatabaseQueryUpdateImpl(this.query, {this.limit});

  final DatabaseUniverseQuery<ThreadsDataLocalDatabase> query;
  final int? limit;

  @override
  int call({
    Object? special_type = ignore,
    Object? threads_unique_id = ignore,
    Object? thread = ignore,
    Object? view_count = ignore,
    Object? thread_create_date = ignore,
    Object? thread_update_date = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (special_type != ignore) 1: special_type as String?,
      if (threads_unique_id != ignore) 2: threads_unique_id as String?,
      if (thread != ignore) 3: thread as String?,
      if (view_count != ignore) 4: view_count as int?,
      if (thread_create_date != ignore) 5: thread_create_date as int?,
      if (thread_update_date != ignore) 6: thread_update_date as int?,
    });
  }
}

extension ThreadsDataLocalDatabaseQueryUpdate on DatabaseUniverseQuery<ThreadsDataLocalDatabase> {
  _ThreadsDataLocalDatabaseQueryUpdate get updateFirst => _ThreadsDataLocalDatabaseQueryUpdateImpl(this, limit: 1);

  _ThreadsDataLocalDatabaseQueryUpdate get updateAll => _ThreadsDataLocalDatabaseQueryUpdateImpl(this);
}

class _ThreadsDataLocalDatabaseQueryBuilderUpdateImpl implements _ThreadsDataLocalDatabaseQueryUpdate {
  const _ThreadsDataLocalDatabaseQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? special_type = ignore,
    Object? threads_unique_id = ignore,
    Object? thread = ignore,
    Object? view_count = ignore,
    Object? thread_create_date = ignore,
    Object? thread_update_date = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (special_type != ignore) 1: special_type as String?,
        if (threads_unique_id != ignore) 2: threads_unique_id as String?,
        if (thread != ignore) 3: thread as String?,
        if (view_count != ignore) 4: view_count as int?,
        if (thread_create_date != ignore) 5: thread_create_date as int?,
        if (thread_update_date != ignore) 6: thread_update_date as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension ThreadsDataLocalDatabaseQueryBuilderUpdate on QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QOperations> {
  _ThreadsDataLocalDatabaseQueryUpdate get updateFirst => _ThreadsDataLocalDatabaseQueryBuilderUpdateImpl(this, limit: 1);

  _ThreadsDataLocalDatabaseQueryUpdate get updateAll => _ThreadsDataLocalDatabaseQueryBuilderUpdateImpl(this);
}

extension ThreadsDataLocalDatabaseQueryFilter on QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QFilterCondition> {
  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> special_typeEqualTo(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> special_typeGreaterThan(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> special_typeGreaterThanOrEqualTo(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> special_typeLessThan(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> special_typeLessThanOrEqualTo(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> special_typeBetween(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> special_typeStartsWith(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> special_typeEndsWith(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> special_typeContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> special_typeMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> special_typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> special_typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> idGreaterThanOrEqualTo(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> idLessThanOrEqualTo(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threads_unique_idEqualTo(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threads_unique_idGreaterThan(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threads_unique_idGreaterThanOrEqualTo(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threads_unique_idLessThan(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threads_unique_idLessThanOrEqualTo(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threads_unique_idBetween(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threads_unique_idStartsWith(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threads_unique_idEndsWith(
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threads_unique_idContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threads_unique_idMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threads_unique_idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threads_unique_idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threadEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threadGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threadGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threadLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threadLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threadBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threadContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threadMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> threadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> view_countEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> view_countGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> view_countGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> view_countLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> view_countLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> view_countBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> thread_create_dateEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> thread_create_dateGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> thread_create_dateGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> thread_create_dateLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> thread_create_dateLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> thread_create_dateBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> thread_update_dateEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> thread_update_dateGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> thread_update_dateGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> thread_update_dateLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> thread_update_dateLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterFilterCondition> thread_update_dateBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }
}

extension ThreadsDataLocalDatabaseQueryObject on QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QFilterCondition> {}

extension ThreadsDataLocalDatabaseQuerySortBy on QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QSortBy> {
  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortBySpecial_type({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortBySpecial_typeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortByThreads_unique_id({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortByThreads_unique_idDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortByThread({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortByThreadDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortByView_count() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortByView_countDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortByThread_create_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortByThread_create_dateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortByThread_update_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> sortByThread_update_dateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }
}

extension ThreadsDataLocalDatabaseQuerySortThenBy on QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QSortThenBy> {
  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenBySpecial_type({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenBySpecial_typeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenByThreads_unique_id({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenByThreads_unique_idDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenByThread({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenByThreadDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenByView_count() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenByView_countDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenByThread_create_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenByThread_create_dateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenByThread_update_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterSortBy> thenByThread_update_dateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }
}

extension ThreadsDataLocalDatabaseQueryWhereDistinct on QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QDistinct> {
  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterDistinct> distinctBySpecial_type({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterDistinct> distinctByThreads_unique_id({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterDistinct> distinctByThread({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterDistinct> distinctByView_count() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterDistinct> distinctByThread_create_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QAfterDistinct> distinctByThread_update_date() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }
}

extension ThreadsDataLocalDatabaseQueryProperty1 on QueryBuilder<ThreadsDataLocalDatabase, ThreadsDataLocalDatabase, QProperty> {
  QueryBuilder<ThreadsDataLocalDatabase, String, QAfterProperty> special_typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, String, QAfterProperty> threads_unique_idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, String, QAfterProperty> threadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, int, QAfterProperty> view_countProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, int, QAfterProperty> thread_create_dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, int, QAfterProperty> thread_update_dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }
}

extension ThreadsDataLocalDatabaseQueryProperty2<R> on QueryBuilder<ThreadsDataLocalDatabase, R, QAfterProperty> {
  QueryBuilder<ThreadsDataLocalDatabase, (R, String), QAfterProperty> special_typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, (R, String), QAfterProperty> threads_unique_idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, (R, String), QAfterProperty> threadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, (R, int), QAfterProperty> view_countProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, (R, int), QAfterProperty> thread_create_dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, (R, int), QAfterProperty> thread_update_dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }
}

extension ThreadsDataLocalDatabaseQueryProperty3<R1, R2> on QueryBuilder<ThreadsDataLocalDatabase, (R1, R2), QAfterProperty> {
  QueryBuilder<ThreadsDataLocalDatabase, (R1, R2, String), QOperations> special_typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, (R1, R2, String), QOperations> threads_unique_idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, (R1, R2, String), QOperations> threadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, (R1, R2, int), QOperations> view_countProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, (R1, R2, int), QOperations> thread_create_dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<ThreadsDataLocalDatabase, (R1, R2, int), QOperations> thread_update_dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }
}
