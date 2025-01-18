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
