// ignore_for_file: avoid_print

import 'dart:io';

import 'package:general_lib/general_lib.dart';

void main() {
  print(
      Dart.pub.installFromDirectoryFresh(directoryPackage: Directory.current),);
}
