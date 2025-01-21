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
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:database_universe/database_universe.dart';
import 'package:database_universe_inspector/collection/collection_area.dart';
import 'package:database_universe_inspector/connect_client.dart';
import 'package:database_universe_inspector/sidebar.dart';

///
class ConnectedLayout extends StatefulWidget {
  ///
  const ConnectedLayout({
    required this.client,
    required this.instances,
    super.key,
  });

  ///
  final ConnectClient client;

  ///
  final List<String> instances;

  @override
  State<ConnectedLayout> createState() => _ConnectedLayoutState();
}

class _ConnectedLayoutState extends State<ConnectedLayout> {
  late StreamSubscription<void> infoSubscription;

  String? selectedInstance;
  String? selectedCollection;
  final List<DatabaseUniverseSchema> schemas = [];

  @override
  void initState() {
    _selectInstance(widget.instances.firstOrNull);
    infoSubscription = widget.client.collectionInfoChanged.listen((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void didUpdateWidget(ConnectedLayout oldWidget) {
    if (!widget.instances.contains(selectedInstance)) {
      _selectInstance(widget.instances.firstOrNull);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    infoSubscription.cancel();
    super.dispose();
  }

  void _selectInstance(String? instance) {
    if (instance == selectedInstance) {
      return;
    }

    selectedInstance = instance;
    selectedCollection = null;
    schemas.clear();

    if (instance != null) {
      widget.client.watchInstance(instance);
      widget.client.getSchemas(instance).then((newSchemas) {
        if (mounted && selectedInstance == instance) {
          setState(() {
            schemas.addAll(newSchemas);
            selectedCollection =
                schemas.where((e) => !e.embedded).firstOrNull?.name;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 320,
            child: Sidebar(
              instances: widget.instances,
              selectedInstance: selectedInstance,
              onInstanceSelected: (instance) {
                setState(() {
                  _selectInstance(instance);
                });
              },
              schemas: schemas,
              collectionInfo: widget.client.collectionInfo,
              selectedCollection: selectedCollection,
              onCollectionSelected: (collection) {
                setState(() {
                  selectedCollection = collection;
                });
              },
            ),
          ),
          const SizedBox(width: 25),
          if (selectedInstance != null && selectedCollection != null)
            Expanded(
              child: CollectionArea(
                key: Key('$selectedInstance.$selectedCollection'),
                instance: selectedInstance!,
                collection: selectedCollection!,
                client: widget.client,
                schemas: {
                  for (final schema in schemas) schema.name: schema,
                },
              ),
            ),
        ],
      ),
    );
  }
}
