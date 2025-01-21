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
import 'package:database_universe_inspector/object/property_value.dart';
import 'package:database_universe_inspector/query_builder/query_group.dart';
import 'package:database_universe_inspector/util.dart';

///
class QueryFilter extends StatelessWidget {
  ///
  const QueryFilter({
    required this.schema,
    required this.condition,
    required this.onChanged,
    super.key,
  });

  ///
  final DatabaseUniverseSchema schema;

  ///
  final FilterCondition condition;

  ///
  final void Function(FilterCondition condition) onChanged;

  @override
  Widget build(BuildContext context) {
    final property = schema.getPropertyByIndex(condition.property);

    final theme = Theme.of(context);
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border:
            Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isDense: true,
                items: [
                  for (final property in schema.idAndProperties)
                    if (property.type != DatabaseUniverseType.object &&
                        property.type != DatabaseUniverseType.objectList)
                      DropdownMenuItem(
                        value: property.name,
                        child: Text(property.name),
                      ),
                ],
                value: property.name,
                onChanged: (name) {
                  if (name == null) return;
                  onChanged(
                    FilterCondition(
                      type: FilterType.equalTo,
                      property: schema.getPropertyIndex(name),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 20),
            DropdownButtonHideUnderline(
              child: DropdownButton<FilterType>(
                isDense: true,
                items: [
                  for (final type in property.supportedFilters)
                    DropdownMenuItem(
                      value: type,
                      child: Text(type.displayName),
                    ),
                ],
                value: condition.type,
                onChanged: (value) {
                  if (value == null) return;
                  onChanged(
                    FilterCondition(
                      type: value,
                      property: condition.property,
                      value1: condition.value1,
                      value2: condition.value2,
                    ),
                  );
                },
              ),
            ),
            if (condition.type.valueCount > 0) ...[
              const SizedBox(width: 20),
              IntrinsicWidth(
                child: PropertyValue(
                  condition.value1,
                  type: property.type,
                  enumMap: property.enumMap,
                  onUpdate: (newValue) {
                    onChanged(
                      FilterCondition(
                        type: condition.type,
                        property: condition.property,
                        value1: newValue,
                        value2: condition.value2,
                      ),
                    );
                  },
                ),
              ),
            ],
            if (condition.type.valueCount == 2) ...[
              const SizedBox(width: 20),
              IntrinsicWidth(
                child: PropertyValue(
                  condition.value2,
                  type: property.type,
                  enumMap: property.enumMap,
                  onUpdate: (newValue) {
                    onChanged(
                      FilterCondition(
                        type: condition.type,
                        property: condition.property,
                        value1: condition.value1,
                        value2: newValue,
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  ///
  dynamic get value1 {}
}

///
enum FilterType {
  ///
  equalTo('is equal to'),

  ///
  greaterThan('is greater than'),

  ///
  lessThan('is less than'),

  ///
  between('is between', valueCount: 2),

  ///
  startsWith('starts with'),

  ///
  endsWith('ends with'),

  ///
  contains('contains'),

  ///
  matches('matches'),

  ///
  isNull('is null', valueCount: 0),

  ///
  isNotNull('is not null', valueCount: 0),

  ///
  elementIsNull('element is null', valueCount: 0),

  ///
  elementIsNotNull('element is not null', valueCount: 0);

  const FilterType(this.displayName, {this.valueCount = 1});

  ///
  final String displayName;

  ///
  final int valueCount;
}

extension on DatabaseUniversePropertySchema {
  List<FilterType> get supportedFilters {
    switch (type) {
      case DatabaseUniverseType.bool:
      case DatabaseUniverseType.boolList:
        return [
          FilterType.equalTo,
          FilterType.isNull,
          FilterType.isNotNull,
          if (type == DatabaseUniverseType.boolList) ...[
            FilterType.elementIsNull,
            FilterType.elementIsNotNull,
          ],
        ];
      case DatabaseUniverseType.byte:
      case DatabaseUniverseType.byteList:
        return [
          FilterType.equalTo,
          FilterType.greaterThan,
          FilterType.lessThan,
          FilterType.between,
        ];
      case DatabaseUniverseType.int:
      case DatabaseUniverseType.float:
      case DatabaseUniverseType.long:
      case DatabaseUniverseType.double:
      case DatabaseUniverseType.dateTime:
      case DatabaseUniverseType.duration:
      case DatabaseUniverseType.intList:
      case DatabaseUniverseType.floatList:
      case DatabaseUniverseType.longList:
      case DatabaseUniverseType.doubleList:
      case DatabaseUniverseType.dateTimeList:
      case DatabaseUniverseType.durationList:
        return [
          FilterType.equalTo,
          FilterType.greaterThan,
          FilterType.lessThan,
          FilterType.between,
          FilterType.isNull,
          FilterType.isNotNull,
          FilterType.elementIsNull,
          FilterType.elementIsNotNull,
        ];
      case DatabaseUniverseType.string:
      case DatabaseUniverseType.stringList:
        return [
          FilterType.equalTo,
          FilterType.greaterThan,
          FilterType.lessThan,
          FilterType.between,
          FilterType.startsWith,
          FilterType.endsWith,
          FilterType.contains,
          FilterType.matches,
          FilterType.isNull,
          FilterType.isNotNull,
          if (type == DatabaseUniverseType.stringList) ...[
            FilterType.elementIsNull,
            FilterType.elementIsNotNull,
          ],
        ];
      case DatabaseUniverseType.object:
      case DatabaseUniverseType.objectList:
      case DatabaseUniverseType.json:
        return [];
    }
  }
}
