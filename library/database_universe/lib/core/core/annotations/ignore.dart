part of "package:database_universe/core/core.dart";

/// Annotate a property or accessor in an DatabaseUniverse collection to ignore it.
const ignore = Ignore();

/// @nodoc
@Target({TargetKind.field, TargetKind.getter})
class Ignore {
  /// @nodoc
  const Ignore();
}
