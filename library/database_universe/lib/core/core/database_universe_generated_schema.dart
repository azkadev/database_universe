part of database_universe;

/// @nodoc
@protected
final class DatabaseUniverseGeneratedSchema {
  /// @nodoc
  const DatabaseUniverseGeneratedSchema({
    required this.schema,
    required this.converter,
    this.embeddedSchemas,
  });

  /// @nodoc
  @protected
  final DatabaseUniverseSchema schema;

  /// @nodoc
  @protected
  final List<DatabaseUniverseGeneratedSchema>? embeddedSchemas;

  /// @nodoc
  @protected
  bool get isEmbedded => embeddedSchemas == null;

  /// @nodoc
  @protected
  final DatabaseUniverseObjectConverter<dynamic, dynamic> converter;
}

/// @nodoc
@protected
final class DatabaseUniverseObjectConverter<ID, OBJ> {
  /// @nodoc
  const DatabaseUniverseObjectConverter({
    required this.serialize,
    required this.deserialize,
    this.deserializeProperty,
  });

  /// @nodoc
  final Serialize<OBJ> serialize;

  /// @nodoc
  final Deserialize<OBJ> deserialize;

  /// @nodoc
  final DeserializeProp? deserializeProperty;

  /// @nodoc
  Type get type => OBJ;

  /// @nodoc
  T withType<T>(
    T Function<ID, OBJ>(DatabaseUniverseObjectConverter<ID, OBJ> converter) f,
  ) =>
      f(this);
}

/// @nodoc
typedef GetId<OBJ> = int Function(OBJ);

/// @nodoc
typedef DatabaseUniverseWriter = Pointer<CDatabaseUniverseWriter>;

/// @nodoc
typedef DatabaseUniverseReader = Pointer<CDatabaseUniverseReader>;

/// @nodoc
typedef Serialize<T> = int Function(DatabaseUniverseWriter writer, T object);

/// @nodoc
typedef Deserialize<T> = T Function(DatabaseUniverseReader reader);

/// @nodoc
typedef DeserializeProp = dynamic Function(
    DatabaseUniverseReader reader, int property);
