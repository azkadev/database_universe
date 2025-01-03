// ignore_for_file: hash_and_equals

import 'package:database_universe/database_universe.dart';
import 'package:database_universe_test/database_universe_test.dart';
import 'package:test/test.dart';

part 'embedded_test.g.dart';

@collection
class Model {
  Model(this.id, this.embedded, this.nested, this.nestedList);

  final int id;

  final EModel embedded;

  final NModel? nested;

  final List<NModel>? nestedList;

  @override
  bool operator ==(Object other) => other is Model && other.id == id && other.embedded == embedded && other.nested == nested && listEquals(other.nestedList, nestedList);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'embedded': embedded.toJson(),
      'nested': nested?.toJson(),
      'nestedList': nestedList?.map((e) => e.toJson()).toList(),
    };
  }
}

@embedded
class EModel {
  EModel(this.value);

  final String value;

  @override
  bool operator ==(Object other) => other is EModel && other.value == value;

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}

@embedded
class NModel {
  NModel([this.embedded, this.nested, this.nestedList, this.strList]);

  final EModel? embedded;

  final NModel? nested;

  final List<NModel?>? nestedList;

  final List<String>? strList;

  @override
  bool operator ==(Object other) => other is NModel && other.embedded == embedded && other.nested == nested && listEquals(other.nestedList, nestedList) && listEquals(other.strList, strList);

  Map<String, dynamic> toJson() {
    return {
      'embedded': embedded?.toJson(),
      'nested': nested?.toJson(),
      'nestedList': nestedList?.map((e) => e?.toJson()).toList(),
      'strList': strList,
    };
  }
}

void main() {
  group('Embedded', () {
    late Isar isar;

    late Model allNull;
    late Model simple;
    late Model nested;

    setUp(() async {
      isar = await openTempIsar([ModelSchema]);

      allNull = Model(0, EModel('test'), null, null);
      simple = Model(
        1,
        EModel('hello'),
        NModel(EModel('abc')),
        [NModel(EModel('test'))],
      );
      nested = Model(
        2,
        EModel('hello'),
        NModel(
          EModel('abc'),
          NModel(
            EModel('this is level2'),
            NModel(null, null, []),
            [
              NModel(
                EModel('i am part of a list'),
                NModel(
                  EModel('even deeper'),
                  NModel(null, null, [], ['a', 'aa', 'aaa']),
                  [],
                ),
              ),
              null,
              NModel(
                EModel('hello'),
              ),
            ],
            ['test1', 'test2', 'test3'],
          ),
        ),
        [
          NModel(EModel('test')),
          NModel(
            EModel('i am also part of a list'),
            NModel(
              EModel('even deeper'),
              NModel(
                null,
                NModel(null, NModel(null, null, []), []),
                [],
                ['hello', 'world'],
              ),
              [],
            ),
            [null, null, null],
          ),
        ],
      );
    });

    databaseUniverseTest('.put() .get()', () {
      isar.write((isar) {
        isar.models.putAll([allNull, simple, nested]);
      });

      //isar.models.verify([allNull, simple, nested]);

      expect(isar.models.where().findAll(), [allNull, simple, nested]);
    });

    /*databaseUniverseTest('.importJson()', ()  {
       isar.write(()  {
         isar.models.tImportJson([
          allNull.toJson(),
          simple.toJson(),
          nested.toJson(),
        ]);
      });

       isar.models.verify([allNull, simple, nested]);
    });

    databaseUniverseTest('.exportJson()', ()  {
       isar.write(()  {
         isar.models.putAll([allNull, simple, nested]);
      });

      expect(
         isar.models.where().exportJson(),
        [
          allNull.toJson(),
          simple.toJson(),
          nested.toJson(),
        ],
      );
    });*/
  });
}
