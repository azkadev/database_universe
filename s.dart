import 'dart:io';

import 'package:general_lib/extension/dynamic.dart';

void main(List<String> args) {
  File("/home/galaxeus/.config/dart/pub-credentials.json")
      .readAsStringSync()
      .printPretty();
}
