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
import 'package:flutter/material.dart';
import 'package:database_universe_inspector/collection/collection_area.dart';

///
class PrevNextButtons extends StatelessWidget {
  ///
  const PrevNextButtons({
    required this.page,
    required this.count,
    required this.onChanged,
    super.key,
  });

  ///
  final int page;

  ///
  final int count;

  ///
  final void Function(int newPage) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var from = 0;
    var to = 0;
    if (count > 0) {
      from = page * objectsPerPage + 1;
      to = from + objectsPerPage - 1;
      if (to > count) {
        to = count;
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: 'Previous page',
          child: TextButton(
            onPressed: page > 0 ? () => onChanged(page - 1) : null,
            child: const Text('Prev'),
          ),
        ),
        const SizedBox(width: 10),
        Tooltip(
          message: 'Current page',
          child: Row(
            children: [
              Text(
                '$from',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                ' - ',
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              Text(
                '$to',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Text(
          ' of ',
          style: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        Tooltip(
          message: 'Total number of objects',
          child: Text(
            '$count',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        Tooltip(
          message: 'Next page',
          child: TextButton(
            onPressed: to == count ? null : () => onChanged(page + 1),
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }
}
