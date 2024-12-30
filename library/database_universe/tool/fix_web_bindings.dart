import 'dart:io';

const path = 'lib/core/core/web/bindings.dart';

void main() {
  var content = File(path).readAsStringSync();

  content = content.replaceFirst(
    "import 'dart:ffi' as ffi;",
    '''
import 'package:database_universe/core/core/web/ffi.dart' as ffi;
import 'package:database_universe/core/core/web/interop.dart';

extension DatabaseUniverseBindingsX on JSDatabaseUniverse {
''',
  );

  content = content.replaceFirst(
    'final',
    '''
}

final
''',
  );

  File(path).writeAsStringSync(content);
}
