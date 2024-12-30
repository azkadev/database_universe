import 'package:flutter/material.dart';
import 'package:database_universe/database_universe.dart';
import 'package:database_universe_inspector/object/isar_object.dart';
import 'package:database_universe_inspector/object/object_view.dart';
import 'package:database_universe_inspector/object/property_builder.dart';
import 'package:database_universe_inspector/object/property_value.dart';

class EmbeddedPropertyView extends StatelessWidget {
  const EmbeddedPropertyView({
    required this.property,
    required this.schemas,
    required this.object,
    required this.onUpdate,
    super.key,
  });

  final DatabaseUniversePropertySchema property;
  final Map<String, DatabaseUniverseSchema> schemas;
  final IsarObject object;
  final void Function(String path, dynamic value) onUpdate;

  @override
  Widget build(BuildContext context) {
    if (property.type == DatabaseUniverseType.object) {
      final child = object.getNested(property.name);
      return PropertyBuilder(
        property: property.name,
        type: property.target!,
        value: child == null ? const NullValue() : null,
        children: [
          if (child != null)
            ObjectView(
              schemaName: property.target!,
              schemas: schemas,
              object: child,
              onUpdate: onUpdate,
            ),
        ],
      );
    } else {
      final children = object.getNestedList(property.name);
      final childrenLength = children != null ? '(${children.length})' : '';
      return PropertyBuilder(
        property: property.name,
        type: 'List<${property.target}> $childrenLength',
        value: children == null ? const NullValue() : null,
        children: [
          for (var i = 0; i < (children?.length ?? 0); i++)
            PropertyBuilder(
              property: '$i',
              type: property.target!,
              value: children![i] == null ? const NullValue() : null,
              children: [
                if (children[i] != null)
                  ObjectView(
                    schemaName: property.target!,
                    schemas: schemas,
                    object: children[i]!,
                    onUpdate: (path, value) {
                      onUpdate('$i.$path', value);
                    },
                  ),
              ],
            ),
        ],
      );
    }
  }
}
