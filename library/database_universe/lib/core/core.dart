/// Extremely fast, easy to use, and fully async NoSQL database for Flutter.
library;

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:database_universe/core/core/database_universe_connect_api.dart';
import 'package:database_universe/core/core/native/native.dart'
    if (dart.library.js) 'package:database_universe/core/core/web/web.dart'
    if (dart.library.js_interop) 'package:database_universe/core/core/wasm/wasm.dart';
import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

part 'core/annotations/collection.dart';
part 'core/annotations/embedded.dart';
part 'core/annotations/enum_value.dart';
part 'core/annotations/id.dart';
part 'core/annotations/ignore.dart';
part 'core/annotations/index.dart';
part 'core/annotations/name.dart';
part 'core/annotations/type.dart';
part 'core/annotations/utc.dart';

part 'core/compact_condition.dart';

part 'core/impl/filter_builder.dart';
part 'core/impl/database_universe_collection_impl.dart';
part 'core/impl/database_universe_impl.dart';
part 'core/impl/database_universe_query_impl.dart';
part 'core/impl/native_error.dart';

part 'core/database_universe.dart';
part 'core/database_universe_collection.dart';
part 'core/database_universe_connect.dart';
part 'core/database_universe_core.dart';
part 'core/database_universe_error.dart';
part 'core/database_universe_generated_schema.dart';
part 'core/database_universe_query.dart';
part 'core/database_universe_schema.dart';

part 'core/query_builder.dart';
part 'core/query_components.dart';
part 'core/query_extensions.dart';

/// @nodoc
@protected
const databaseUniverseProtected = protected;

/// @nodoc
@protected
const databaseUniverseJsonEncode = jsonEncode;

/// @nodoc
@protected
const databaseUniverseJsonDecode = jsonDecode;
