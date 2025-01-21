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
import 'package:database_universe_inspector/connect_client.dart';
import 'package:database_universe_inspector/connected_layout.dart';
import 'package:database_universe_inspector/error_screen.dart';

///
class ConnectionScreen extends StatefulWidget {
  ///
  const ConnectionScreen({
    required this.port,
    required this.secret,
    super.key,
  });

  ///
  final String port;

  ///
  final String secret;

  @override
  State<ConnectionScreen> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionScreen> {
  late Future<ConnectClient> clientFuture;

  @override
  void initState() {
    clientFuture = ConnectClient.connect(widget.port, widget.secret);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ConnectionScreen oldWidget) {
    if (oldWidget.port != widget.port || oldWidget.secret != widget.secret) {
      clientFuture = ConnectClient.connect(widget.port, widget.secret);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConnectClient>(
      future: clientFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _InstancesLoader(client: snapshot.data!);
        } else if (snapshot.hasError) {
          return const ErrorScreen();
        } else {
          return const Loading();
        }
      },
    );
  }
}

class _InstancesLoader extends StatefulWidget {
  const _InstancesLoader({required this.client});

  final ConnectClient client;

  @override
  State<_InstancesLoader> createState() => _InstancesLoaderState();
}

class _InstancesLoaderState extends State<_InstancesLoader> {
  late Future<List<String>> instancesFuture;
  late StreamSubscription<void> _instancesSubscription;

  @override
  void initState() {
    instancesFuture = widget.client.listInstances();
    _instancesSubscription = widget.client.instancesChanged.listen((event) {
      setState(() {
        instancesFuture = widget.client.listInstances();
      });
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _InstancesLoader oldWidget) {
    instancesFuture = widget.client.listInstances();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _instancesSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: instancesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ConnectedLayout(
            client: widget.client,
            instances: snapshot.data!,
          );
        } else if (snapshot.hasError) {
          return const ErrorScreen();
        } else {
          return const Loading();
        }
      },
    );
  }
}

///
class Loading extends StatelessWidget {
  ///
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
