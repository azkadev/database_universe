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
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:database_universe/database_universe.dart';
import 'package:database_universe_inspector/connect_client.dart';

///
class CollectionsList extends StatelessWidget {
  ///
  const CollectionsList({
    required this.collections,
    required this.collectionInfo,
    required this.selectedCollection,
    required this.onSelected,
    super.key,
  });

  ///

  final List<DatabaseUniverseSchema> collections;

  ///
  final Map<String, ConnectCollectionInfoPayload?> collectionInfo;

  ///
  final String? selectedCollection;

  ///
  final void Function(String collection) onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      primary: false,
      itemBuilder: (BuildContext context, int index) {
        final collection = collections[index];
        final info = collectionInfo[collection.name];

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ElevatedButton(
            style: collection.name == selectedCollection
                ? ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primaryContainer,
                    foregroundColor: theme.colorScheme.onPrimaryContainer,
                  )
                : null,
            onPressed: () {
              onSelected(collection.name);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 10,
                top: 12,
                bottom: 12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      collection.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        info?.count.toString() ?? 'loading',
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatSize(info?.size ?? 0),
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: collections.length,
    );
  }
}

String _formatSize(int bytes) {
  if (bytes <= 0) return '0 B';
  const suffixes = ['B', 'KB', 'MB', 'GB'];
  final n = (log(bytes) / log(1024)).floor();
  final index = min(n, suffixes.length - 1);
  final value = bytes / pow(1024, index);
  return '${value.toStringAsFixed(index == 0 ? 0 : 2)} ${suffixes[index]}';
}
