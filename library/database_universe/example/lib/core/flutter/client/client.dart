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

import 'package:example/core/dart/client/client.dart';
import 'package:example/core/dart/database/database.dart';
import 'package:example/main.dart';
import 'package:example/page/home/home.dart';
import 'package:flutter/material.dart';
import 'package:general_framework/core/client/options.dart';
import 'package:general_framework/flutter/flutter.dart';
import 'package:general_lib/general_lib.dart';
import 'package:general_lib_flutter/general_lib_flutter.dart';

///
class ExampleClientFlutter
    extends GeneralFrameworkClientFlutter<ExampleClient> {
  ////
  ExampleClientFlutter({
    required super.navigatorKey,
    required super.generalLibrary,
  }) : super(
          generalFrameworkClient: ExampleClient(
            generalFrameworkDatabase: ExampleClientDatabase(),
            generalLibrary: generalLibrary,
            generalFrameworkClientInvokeOptions:
                GeneralFrameworkClientInvokeOptions(
              networkClientConnectionType: NetworkClientConnectionType.http,
              durationTimeOut: Duration(minutes: 1),
              isInvokeThrowOnError: false,
            ),
          ),
        );

  ///
  static GeneralLibFlutterApp generalLibFlutterApp = GeneralLibFlutterApp();

  ///
  final Completer<bool> completerEnsureInitialized = Completer<bool>();
  bool _isLoadingEnsureInitialized = false;

  @override
  FutureOr<void> ensureInitialized(
      {required BuildContext context,
      required FutureOr<void> Function(String textLoading) onLoading}) async {
    if (_isLoadingEnsureInitialized) {
      if (completerEnsureInitialized.isCompleted == false) {
        await completerEnsureInitialized.future;
      }
      return;
    }
    _isLoadingEnsureInitialized = true;
    await super.ensureInitialized(
      context: context,
      onLoading: onLoading,
    );
    completerEnsureInitialized.complete(true);
  }

  @override
  void ensureInitializedRoute() {
    routeGeneralLibFlutter.all("/", (context, data) {
      if (completerEnsureInitialized.isCompleted) {
        return HomePage(generalFrameworkClientFlutter: this);
      }
      return MainInitializedApp(
        generalFrameworkClientFlutter: this,
      );
    });
    routeGeneralLibFlutter.all("/home", (context, data) {
      return HomePage(generalFrameworkClientFlutter: this);
    });
    routeGeneralLibFlutter.all("/sign", (context, data) {
      return HomePage(
        generalFrameworkClientFlutter: this,
      );
    });
  }

  @override
  GeneralLibFlutterApp generalLibFlutterAppFunction() {
    return generalLibFlutterApp;
  }

  @override
  FutureOr onInvokeResult(
      Map result,
      Map parameters,
      GeneralFrameworkClientInvokeOptions
          generalFrameworkClientInvokeOptions) {}

  @override
  FutureOr<Map?> onInvokeValidation(Map parameters,
      GeneralFrameworkClientInvokeOptions generalFrameworkClientInvokeOptions) {
    return null;
  }

  @override
  Widget onErrorRoute(BuildContext context,
      RouteDataGeneralLibFlutter routeDataGeneralLibFlutter) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Page"),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: context.height,
            minWidth: context.width,
          ),
          child: Column(
            children: [
              Text("path: ${routeDataGeneralLibFlutter.path}"),
              Text("parameters: ${routeDataGeneralLibFlutter.arguments}"),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget onNotFoundRoute(BuildContext context,
      RouteDataGeneralLibFlutter routeDataGeneralLibFlutter) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Found Page"),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: context.height,
            minWidth: context.width,
          ),
          child: Column(
            children: [
              Text("path: ${routeDataGeneralLibFlutter.path}"),
              Text("parameters: ${routeDataGeneralLibFlutter.arguments}"),
            ],
          ),
        ),
      ),
    );
  }

  /// change theme black and white only
  Widget themeChangeWidget(
      {required BuildContext context,
      required GeneralLibFlutterStatefulWidget pageState}) {
    final child = ThemeChangeGeneralFrameworkWidget(
      themeChangeGeneralFrameworkWidgetStyle:
          ThemeChangeGeneralFrameworkWidgetStyle.minimalist,
      generalLibFlutterApp: ExampleClientFlutter.generalLibFlutterApp,
      onChanged: () {},
    );
    if (pageState.isLoading) {
      return SkeletonizerGeneralFramework(
        enabled: pageState.isLoading,
        child: child,
      );
    }
    return child;
  }
}

///
abstract class ExampleClientFlutterAppStatefulWidget
    extends GeneralFrameworkClientFlutterAppStatefulWidget<
        ExampleClientFlutter> {
  ///

  ///
  const ExampleClientFlutterAppStatefulWidget({
    super.key,
    required super.generalFrameworkClientFlutter,
  });
}

///
abstract class ExampleClientFlutterAppStatelessWidget
    extends GeneralFrameworkClientFlutterAppStatelessWidget<
        ExampleClientFlutter> {
  ///
  const ExampleClientFlutterAppStatelessWidget({
    super.key,
    required super.generalFrameworkClientFlutter,
  });
}
