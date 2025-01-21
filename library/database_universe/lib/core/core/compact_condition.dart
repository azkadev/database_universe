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

/// DatabaseUniverse databases can contain unused space that will be reused for later
/// operations. You can specify conditions to trigger manual compaction where
/// the entire database is copied and unused space freed.
///
/// This operation can only be performed while a database is being opened and
/// should only be used if absolutely necessary.
class CompactCondition {
  /// Compaction will happen if all of the specified conditions are true.
  const CompactCondition({
    this.minFileSize,
    this.minBytes,
    this.minRatio,
  }) : assert(
          minFileSize != null || minBytes != null || minRatio != null,
          'At least one condition needs to be specified.',
        );

  /// The minimum size in bytes of the database file to trigger compaction. It
  /// is highly  discouraged to trigger compaction solely on this condition.
  final int? minFileSize;

  /// The minimum number of bytes that can be freed with compaction.
  final int? minBytes;

  /// The minimum compaction ration. For example `2.0` would trigger compaction
  /// as soon as the file size can be halved.
  final double? minRatio;
}
