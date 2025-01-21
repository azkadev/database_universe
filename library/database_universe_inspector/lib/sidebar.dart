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
import 'package:database_universe/database_universe.dart';
import 'package:database_universe_inspector/collections_list.dart';
import 'package:database_universe_inspector/connect_client.dart';
import 'package:database_universe_inspector/instance_selector.dart';
import 'package:database_universe_inspector/main.dart';

///
class Sidebar extends StatelessWidget {
  ///
  const Sidebar({
    required this.instances,
    required this.selectedInstance,
    required this.onInstanceSelected,
    required this.schemas,
    required this.collectionInfo,
    required this.selectedCollection,
    required this.onCollectionSelected,
    super.key,
  });

  ///
  final List<String> instances;

  ///
  final String? selectedInstance;

  ///
  final void Function(String instance) onInstanceSelected;

  ///

  final List<DatabaseUniverseSchema> schemas;

  ///
  final Map<String, ConnectCollectionInfoPayload?> collectionInfo;

  ///
  final String? selectedCollection;

  ///
  final void Function(String collection) onCollectionSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 40,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Isar',
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Inspector',
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    padding: const EdgeInsets.all(20),
                    icon: Icon(
                      theme.brightness == Brightness.light
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded,
                    ),
                    onPressed: DarkMode.of(context).toggle,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CollectionsList(
                collections: schemas.where((e) => !e.embedded).toList(),
                collectionInfo: collectionInfo,
                selectedCollection: selectedCollection,
                onSelected: onCollectionSelected,
              ),
            ),
          ),
          const SizedBox(height: 12),
          InstanceSelector(
            instances: instances,
            selectedInstance: selectedInstance,
            onSelected: onInstanceSelected,
          ),
        ],
      ),
    );
  }
}
