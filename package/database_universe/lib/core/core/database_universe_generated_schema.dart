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
  DatabaseUniverseReader reader,
  int property,
);
