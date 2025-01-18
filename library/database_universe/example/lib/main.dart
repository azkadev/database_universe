// ignore_for_file: use_build_context_synchronously

import 'package:example/core/flutter/client/client.dart';
import 'package:flutter/material.dart';
import 'package:general/flutter/general_flutter_core.dart';
import 'package:general_lib_flutter/widget/widget.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

///
class MainApp extends StatelessWidget {
  ///
  const MainApp({super.key});

  ///
  static ExampleClientFlutter exampleClientFlutter = ExampleClientFlutter(
    navigatorKey: GlobalKey<NavigatorState>(),
    generalLibrary: GeneralFlutter(),
  );

  @override
  Widget build(BuildContext context) {
    return GeneralLibFlutterAppMain(
      generalLibFlutterApp: ExampleClientFlutter.generalLibFlutterApp,
      builder: (themeMode, lightTheme, darkTheme, widget) {
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          onUnknownRoute: exampleClientFlutter.routeGeneralLibFlutter.route,
        );
      },
    );
  }
}

///
class MainInitializedApp extends ExampleClientFlutterAppStatefulWidget {
  ///
  const MainInitializedApp({
    super.key,
    required super.generalFrameworkClientFlutter,
  });

  @override
  State<MainInitializedApp> createState() => _MainInitializedAppState();
}

class _MainInitializedAppState extends State<MainInitializedApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      task();
    });
  }

  void task() {
    Future(() async {
      await widget.generalFrameworkClientFlutter.ensureInitialized(
        context: context,
        onLoading: (text) {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
