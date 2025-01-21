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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:database_universe_inspector/connection_screen.dart';

void main() async {
  runApp(
    DarkMode(
      notifier: DarkModeNotifier(),
      child: const App(),
    ),
  );
}

final _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        if (kIsWeb == false) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              body: Material(
                child: ConnectionScreen(
                  port: "38377",
                  secret: "9D1uKBRy7IY",
                ),
              ),
            ),
          );
        }
        return const Material(
          child: Center(
            child: Text(
              'Welcome to the Database Universe Inspector!\nPlease open the link '
              'displayed when running the debug version of an Isar app.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: '/:port/:secret',
      builder: (BuildContext context, GoRouterState state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            body: Material(
              child: ConnectionScreen(
                port: state.pathParameters['port']!,
                secret: state.pathParameters['secret']!,
              ),
            ),
          ),
        );
      },
    ),
  ],
);

///
class App extends StatelessWidget {
  ///
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Database Universe Inspector',
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9FC9FF),
          brightness: DarkMode.of(context).darkMode
              ? Brightness.dark
              : Brightness.light,
        ),
        useMaterial3: true,
      ),
    );
  }
}

///
class DarkMode extends InheritedNotifier<DarkModeNotifier> {
  ///
  const DarkMode({
    required super.child,
    super.key,
    super.notifier,
  });

  ///
  static DarkModeNotifier of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DarkMode>()!.notifier!;
  }
}

///
class DarkModeNotifier extends ChangeNotifier {
  var _darkMode = true;

  ///
  bool get darkMode => _darkMode;

  ///
  void toggle() {
    _darkMode = !_darkMode;
    notifyListeners();
  }
}
