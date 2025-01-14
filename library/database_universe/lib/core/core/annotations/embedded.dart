part of "package:database_universe/core/core.dart";

/// Annotation to nest objects of this type in collections.
const embedded = Embedded();

/// Annotation to nest objects of this type in collections.
@Target({TargetKind.classType})
class Embedded {
  /// Annotation to nest objects of this type in collections.
  const Embedded({this.inheritance = true, this.ignore = const {}});

  /// Should properties and accessors of parent classes and mixins be included?
  final bool inheritance;

  /// A list of properties or getter names that DatabaseUniverse should ignore.
  final Set<String> ignore;
}
