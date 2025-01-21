/* <!-- START LICENSE -->


This Software / Program / Source Code Created By Developer From Company GLOBAL CORPORATION
Social Media:

   - Youtube: https://youtube.com/@Global_Corporation 
   - Github: https://github.com/globalcorporation
   - TELEGRAM: https://t.me/GLOBAL_CORP_ORG_BOT

All code script in here created 100% original without copy / steal from other code if we copy we add description source at from top code

If you wan't edit you must add credit me (don't change)

If this Software / Program / Source Code has you

Jika Program ini milik anda dari hasil beli jasa developer di (Global Corporation / apapun itu dari turunan itu jika ada kesalahan / bug / ingin update segera lapor ke sub)

Misal anda beli Beli source code di Slebew CORPORATION anda lapor dahulu di slebew jangan lapor di GLOBAL CORPORATION!

Jika ada kendala program ini (Pastikan sebelum deal project tidak ada negosiasi harga)
Karena jika ada negosiasi harga kemungkinan

1. Software Ada yang di kurangin
2. Informasi tidak lengkap
3. Bantuan Tidak Bisa remote / full time (Ada jeda)

Sebelum program ini sampai ke pembeli developer kami sudah melakukan testing

jadi sebelum nego kami sudah melakukan berbagai konsekuensi jika nego tidak sesuai ? 
Bukan maksud kami menipu itu karena harga yang sudah di kalkulasi + bantuan tiba tiba di potong akhirnya bantuan / software kadang tidak lengkap


<!-- END LICENSE --> */
import 'package:flutter/material.dart';
import 'package:database_universe/database_universe.dart';
import 'package:database_universe_inspector/object/isar_object.dart';
import 'package:database_universe_inspector/object/object_view.dart';
import 'package:database_universe_inspector/object/property_builder.dart';
import 'package:database_universe_inspector/object/property_value.dart';

///
class EmbeddedPropertyView extends StatelessWidget {
  ///
  const EmbeddedPropertyView({
    required this.property,
    required this.schemas,
    required this.object,
    required this.onUpdate,
    super.key,
  });

  ///
  final DatabaseUniversePropertySchema property;

  ///
  final Map<String, DatabaseUniverseSchema> schemas;

  ///
  final IsarObject object;

  ///
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
