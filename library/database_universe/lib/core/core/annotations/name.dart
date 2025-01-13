part of "package:database_universe/core/core.dart";

/// Annotate DatabaseUniverse collections or properties to change their name.
///
/// Can be used to change the name in Dart independently of DatabaseUniverse.
@Target({TargetKind.classType, TargetKind.field, TargetKind.getter})
class Name {
  /// Annotate DatabaseUniverse collections or properties to change their name.
  const Name(this.name);

  /// The name this entity should have in the database.
  final String name;
}
