part of "package:database_universe/core/core.dart";

/// Annotation to create an DatabaseUniverse collection.
const collection = Collection();

/// Annotation to create an DatabaseUniverse collection.
@Target({TargetKind.classType})
class Collection {
  /// Annotation to create an DatabaseUniverse collection.
  const Collection({
    this.inheritance = true,
    this.accessor,
    this.ignore = const {'copyWith'},
  });

  /// Should properties and accessors of parent classes and mixins be included?
  final bool inheritance;

  /// Allows you to override the default collection accessor.
  ///
  /// Example:
  /// ```dart
  /// @Collection(accessor: 'col')
  /// class MyCol {
  ///   Id? id;
  /// }
  ///
  /// // access collection:
  /// database_universe.col.where().findAll();
  /// ```
  final String? accessor;

  /// A list of properties or getter names that DatabaseUniverse should ignore.
  final Set<String> ignore;
}
