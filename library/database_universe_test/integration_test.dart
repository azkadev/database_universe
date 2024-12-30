// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:database_universe_test/database_universe_test.dart';
import 'package:path_provider/path_provider.dart';

import 'all_tests.dart' as tests;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final completer = Completer<void>();

  group('Integration test', () {
    setUpAll(() async {
      if (!kIsWeb) {
        final dir = await getTemporaryDirectory();
        testTempPath = dir.path;
      }
    });

    tearDownAll(() {
      print('Database Universe Test done');
      completer.complete();
    });

    tests.main();
  });

  testWidgets(
    'Isar',
    (t) async {
      await completer.future;
      expect(testCount > 0, true);
      expect(testErrors, isEmpty);
    },
    timeout: Timeout.none,
  );
}
