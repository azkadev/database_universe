#!/bin/sh

cargo install cbindgen

cbindgen --config scripts/cbindgen.toml --crate database_universe --output package/database_universe/database_universe-dart.h

cd package/database_universe

dart pub get
dart run ffigen --config ffigen.yaml
dart run ffigen --config ffigen_web.yaml
rm database_universe-dart.h

dart tool/fix_web_bindings.dart

dart format --fix lib/src/impl/bindings.dart
dart format --fix lib/src/web/bindings.dart
