// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatbot_data_local_database.dart';

// **************************************************************************
// _DatabaseUniverseCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors

extension GetChatbotDataLocalDatabaseCollection on DatabaseUniverse {
  DatabaseUniverseCollection<int, ChatbotDataLocalDatabase> get chatbotDataLocalDatabases => this.collection();
}

const ChatbotDataLocalDatabaseSchema = DatabaseUniverseGeneratedSchema(
  schema: DatabaseUniverseSchema(
    name: 'ChatbotDataLocalDatabase',
    idName: 'id',
    embedded: false,
    properties: [
      DatabaseUniversePropertySchema(
        name: 'special_type',
        type: DatabaseUniverseType.string,
      ),
      DatabaseUniversePropertySchema(
        name: 'prompt',
        type: DatabaseUniverseType.string,
      ),
      DatabaseUniversePropertySchema(
        name: 'respond',
        type: DatabaseUniverseType.string,
      ),
    ],
    indexes: [],
  ),
  converter: DatabaseUniverseObjectConverter<int, ChatbotDataLocalDatabase>(
    serialize: serializeChatbotDataLocalDatabase,
    deserialize: deserializeChatbotDataLocalDatabase,
    deserializeProperty: deserializeChatbotDataLocalDatabaseProp,
  ),
  embeddedSchemas: [],
);

@databaseUniverseProtected
int serializeChatbotDataLocalDatabase(DatabaseUniverseWriter writer, ChatbotDataLocalDatabase object) {
  DatabaseUniverseCore.writeString(writer, 1, object.special_type);
  DatabaseUniverseCore.writeString(writer, 2, object.prompt);
  DatabaseUniverseCore.writeString(writer, 3, object.respond);
  return object.id;
}

@databaseUniverseProtected
ChatbotDataLocalDatabase deserializeChatbotDataLocalDatabase(DatabaseUniverseReader reader) {
  final object = ChatbotDataLocalDatabase();
  object.special_type = DatabaseUniverseCore.readString(reader, 1) ?? '';
  object.id = DatabaseUniverseCore.readId(reader);
  object.prompt = DatabaseUniverseCore.readString(reader, 2) ?? '';
  object.respond = DatabaseUniverseCore.readString(reader, 3) ?? '';
  return object;
}

@databaseUniverseProtected
dynamic deserializeChatbotDataLocalDatabaseProp(DatabaseUniverseReader reader, int property) {
  switch (property) {
    case 1:
      return DatabaseUniverseCore.readString(reader, 1) ?? '';
    case 0:
      return DatabaseUniverseCore.readId(reader);
    case 2:
      return DatabaseUniverseCore.readString(reader, 2) ?? '';
    case 3:
      return DatabaseUniverseCore.readString(reader, 3) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _ChatbotDataLocalDatabaseUpdate {
  bool call({
    required int id,
    String? special_type,
    String? prompt,
    String? respond,
  });
}

class _ChatbotDataLocalDatabaseUpdateImpl implements _ChatbotDataLocalDatabaseUpdate {
  const _ChatbotDataLocalDatabaseUpdateImpl(this.collection);

  final DatabaseUniverseCollection<int, ChatbotDataLocalDatabase> collection;

  @override
  bool call({
    required int id,
    Object? special_type = ignore,
    Object? prompt = ignore,
    Object? respond = ignore,
  }) {
    return collection.updateProperties([
          id
        ], {
          if (special_type != ignore) 1: special_type as String?,
          if (prompt != ignore) 2: prompt as String?,
          if (respond != ignore) 3: respond as String?,
        }) >
        0;
  }
}

sealed class _ChatbotDataLocalDatabaseUpdateAll {
  int call({
    required List<int> id,
    String? special_type,
    String? prompt,
    String? respond,
  });
}

class _ChatbotDataLocalDatabaseUpdateAllImpl implements _ChatbotDataLocalDatabaseUpdateAll {
  const _ChatbotDataLocalDatabaseUpdateAllImpl(this.collection);

  final DatabaseUniverseCollection<int, ChatbotDataLocalDatabase> collection;

  @override
  int call({
    required List<int> id,
    Object? special_type = ignore,
    Object? prompt = ignore,
    Object? respond = ignore,
  }) {
    return collection.updateProperties(id, {
      if (special_type != ignore) 1: special_type as String?,
      if (prompt != ignore) 2: prompt as String?,
      if (respond != ignore) 3: respond as String?,
    });
  }
}

extension ChatbotDataLocalDatabaseUpdate on DatabaseUniverseCollection<int, ChatbotDataLocalDatabase> {
  _ChatbotDataLocalDatabaseUpdate get update => _ChatbotDataLocalDatabaseUpdateImpl(this);

  _ChatbotDataLocalDatabaseUpdateAll get updateAll => _ChatbotDataLocalDatabaseUpdateAllImpl(this);
}

sealed class _ChatbotDataLocalDatabaseQueryUpdate {
  int call({
    String? special_type,
    String? prompt,
    String? respond,
  });
}

class _ChatbotDataLocalDatabaseQueryUpdateImpl implements _ChatbotDataLocalDatabaseQueryUpdate {
  const _ChatbotDataLocalDatabaseQueryUpdateImpl(this.query, {this.limit});

  final DatabaseUniverseQuery<ChatbotDataLocalDatabase> query;
  final int? limit;

  @override
  int call({
    Object? special_type = ignore,
    Object? prompt = ignore,
    Object? respond = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (special_type != ignore) 1: special_type as String?,
      if (prompt != ignore) 2: prompt as String?,
      if (respond != ignore) 3: respond as String?,
    });
  }
}

extension ChatbotDataLocalDatabaseQueryUpdate on DatabaseUniverseQuery<ChatbotDataLocalDatabase> {
  _ChatbotDataLocalDatabaseQueryUpdate get updateFirst => _ChatbotDataLocalDatabaseQueryUpdateImpl(this, limit: 1);

  _ChatbotDataLocalDatabaseQueryUpdate get updateAll => _ChatbotDataLocalDatabaseQueryUpdateImpl(this);
}

class _ChatbotDataLocalDatabaseQueryBuilderUpdateImpl implements _ChatbotDataLocalDatabaseQueryUpdate {
  const _ChatbotDataLocalDatabaseQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? special_type = ignore,
    Object? prompt = ignore,
    Object? respond = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (special_type != ignore) 1: special_type as String?,
        if (prompt != ignore) 2: prompt as String?,
        if (respond != ignore) 3: respond as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension ChatbotDataLocalDatabaseQueryBuilderUpdate on QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QOperations> {
  _ChatbotDataLocalDatabaseQueryUpdate get updateFirst => _ChatbotDataLocalDatabaseQueryBuilderUpdateImpl(this, limit: 1);

  _ChatbotDataLocalDatabaseQueryUpdate get updateAll => _ChatbotDataLocalDatabaseQueryBuilderUpdateImpl(this);
}

extension ChatbotDataLocalDatabaseQueryFilter on QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QFilterCondition> {
  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> special_typeEqualTo(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> special_typeGreaterThan(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> special_typeGreaterThanOrEqualTo(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> special_typeLessThan(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> special_typeLessThanOrEqualTo(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> special_typeBetween(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> special_typeStartsWith(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> special_typeEndsWith(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> special_typeContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> special_typeMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> special_typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> special_typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> idGreaterThanOrEqualTo(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> idLessThanOrEqualTo(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> promptEqualTo(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> promptGreaterThan(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> promptGreaterThanOrEqualTo(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> promptLessThan(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> promptLessThanOrEqualTo(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> promptBetween(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> promptStartsWith(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> promptEndsWith(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> promptContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> promptMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> promptIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> promptIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> respondEqualTo(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> respondGreaterThan(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> respondGreaterThanOrEqualTo(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> respondLessThan(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> respondLessThanOrEqualTo(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> respondBetween(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> respondStartsWith(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> respondEndsWith(
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> respondContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> respondMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> respondIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterFilterCondition> respondIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }
}

extension ChatbotDataLocalDatabaseQueryObject on QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QFilterCondition> {}

extension ChatbotDataLocalDatabaseQuerySortBy on QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QSortBy> {
  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> sortBySpecial_type({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> sortBySpecial_typeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> sortByPrompt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> sortByPromptDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> sortByRespond({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> sortByRespondDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension ChatbotDataLocalDatabaseQuerySortThenBy on QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QSortThenBy> {
  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> thenBySpecial_type({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> thenBySpecial_typeDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> thenByPrompt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> thenByPromptDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> thenByRespond({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterSortBy> thenByRespondDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension ChatbotDataLocalDatabaseQueryWhereDistinct on QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QDistinct> {
  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterDistinct> distinctBySpecial_type({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterDistinct> distinctByPrompt({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QAfterDistinct> distinctByRespond({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }
}

extension ChatbotDataLocalDatabaseQueryProperty1 on QueryBuilder<ChatbotDataLocalDatabase, ChatbotDataLocalDatabase, QProperty> {
  QueryBuilder<ChatbotDataLocalDatabase, String, QAfterProperty> special_typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, String, QAfterProperty> promptProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, String, QAfterProperty> respondProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension ChatbotDataLocalDatabaseQueryProperty2<R> on QueryBuilder<ChatbotDataLocalDatabase, R, QAfterProperty> {
  QueryBuilder<ChatbotDataLocalDatabase, (R, String), QAfterProperty> special_typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, (R, String), QAfterProperty> promptProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, (R, String), QAfterProperty> respondProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension ChatbotDataLocalDatabaseQueryProperty3<R1, R2> on QueryBuilder<ChatbotDataLocalDatabase, (R1, R2), QAfterProperty> {
  QueryBuilder<ChatbotDataLocalDatabase, (R1, R2, String), QOperations> special_typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, (R1, R2, String), QOperations> promptProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ChatbotDataLocalDatabase, (R1, R2, String), QOperations> respondProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}
