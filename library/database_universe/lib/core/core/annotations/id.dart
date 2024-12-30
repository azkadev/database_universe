part of database_universe;

/// Annotate the property or accessor in an DatabaseUniverse collection that should be used
/// as the primary key.
const id = Id();

/// @nodoc
@Target({TargetKind.field, TargetKind.getter})
class Id {
  /// @nodoc
  const Id();
}