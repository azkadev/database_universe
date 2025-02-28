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
part of "package:database_universe/core/core/generator/database_universe_generator.dart";

const _updateableTypes = [
  DatabaseUniverseType.bool,
  DatabaseUniverseType.byte,
  DatabaseUniverseType.int,
  DatabaseUniverseType.long,
  DatabaseUniverseType.float,
  DatabaseUniverseType.double,
  DatabaseUniverseType.dateTime,
  DatabaseUniverseType.duration,
  DatabaseUniverseType.string,
];

String _generateUpdate(ObjectInfo oi) {
  final updateProperties = oi.properties
      .where((p) => !p.isId && _updateableTypes.contains(p.type))
      .toList();

  if (updateProperties.isEmpty) {
    return '';
  }

  return '''
  sealed class _${oi.dartName}Update {
    bool call({
      required ${oi.idProperty!.dartType} ${oi.idProperty!.dartName},
      ${updateProperties.map((p) => '${p.scalarDartTypeNotNull}? ${p.dartName},').join('\n')}
    });
  }

  class _${oi.dartName}UpdateImpl implements _${oi.dartName}Update {
    const _${oi.dartName}UpdateImpl(this.collection);

    final DatabaseUniverseCollection<${oi.idProperty!.dartType}, ${oi.dartName}> collection;

    @override
    bool call({
      required ${oi.idProperty!.dartType} ${oi.idProperty!.dartName},
      ${updateProperties.map((p) => 'Object? ${p.dartName} = ignore,').join('\n')}
    }) {
      return collection.updateProperties(
        [${oi.idProperty!.dartName}], 
        {
          ${updateProperties.map((p) => 'if (${p.dartName} != ignore) ${p.index}: ${p.dartName} as ${p.scalarDartTypeNotNull}?,').join('\n')}
        }
      ) > 0;
    }
  }

  sealed class _${oi.dartName}UpdateAll {
    int call({
      required List<${oi.idProperty!.dartType}> ${oi.idProperty!.dartName},
      ${updateProperties.map((p) => '${p.scalarDartTypeNotNull}? ${p.dartName},').join('\n')}
    });
  }

  class _${oi.dartName}UpdateAllImpl implements _${oi.dartName}UpdateAll {
    const _${oi.dartName}UpdateAllImpl(this.collection);

    final DatabaseUniverseCollection<${oi.idProperty!.dartType}, ${oi.dartName}> collection;

    @override
    int call({
      required List<${oi.idProperty!.dartType}> ${oi.idProperty!.dartName},
      ${updateProperties.map((p) => 'Object? ${p.dartName} = ignore,').join('\n')}
    }) {
      return collection.updateProperties(
        ${oi.idProperty!.dartName}, 
        {
          ${updateProperties.map((p) => 'if (${p.dartName} != ignore) ${p.index}: ${p.dartName} as ${p.scalarDartTypeNotNull}?,').join('\n')}
        }
      );
    }
  }

  extension ${oi.dartName}Update on DatabaseUniverseCollection<${oi.idProperty!.dartType}, ${oi.dartName}> {
    _${oi.dartName}Update get update => _${oi.dartName}UpdateImpl(this);

    _${oi.dartName}UpdateAll get updateAll => _${oi.dartName}UpdateAllImpl(this);
  }

  sealed class _${oi.dartName}QueryUpdate {
    int call({
      ${updateProperties.map((p) => '${p.scalarDartTypeNotNull}? ${p.dartName},').join('\n')}
    });
  }

  class _${oi.dartName}QueryUpdateImpl implements _${oi.dartName}QueryUpdate {
    const _${oi.dartName}QueryUpdateImpl(this.query, {this.limit});

    final DatabaseUniverseQuery<${oi.dartName}> query;
    final int? limit;

    @override
    int call({
      ${updateProperties.map((p) => 'Object? ${p.dartName} = ignore,').join('\n')}
    }) {
      return query.updateProperties(
        limit: limit, 
        {
          ${updateProperties.map((p) => 'if (${p.dartName} != ignore) ${p.index}: ${p.dartName} as ${p.scalarDartTypeNotNull}?,').join('\n')}
        }
      );
    }
  }

  extension ${oi.dartName}QueryUpdate on DatabaseUniverseQuery<${oi.dartName}> {
    _${oi.dartName}QueryUpdate get updateFirst => _${oi.dartName}QueryUpdateImpl(this, limit: 1);

    _${oi.dartName}QueryUpdate get updateAll => _${oi.dartName}QueryUpdateImpl(this);
  }

  class _${oi.dartName}QueryBuilderUpdateImpl implements _${oi.dartName}QueryUpdate {
    const _${oi.dartName}QueryBuilderUpdateImpl(this.query, {this.limit});

    final QueryBuilder<${oi.dartName}, ${oi.dartName}, QOperations> query;
    final int? limit;

    @override
    int call({
      ${updateProperties.map((p) => 'Object? ${p.dartName} = ignore,').join('\n')}
    }) {
      final q = query.build();
      try {
        return q.updateProperties(
          limit: limit, 
          {
            ${updateProperties.map((p) => 'if (${p.dartName} != ignore) ${p.index}: ${p.dartName} as ${p.scalarDartTypeNotNull}?,').join('\n')}
          }
        );
      } finally {
        q.close();
      }
    }
  }

  extension ${oi.dartName}QueryBuilderUpdate on QueryBuilder<${oi.dartName}, ${oi.dartName}, QOperations> {
    _${oi.dartName}QueryUpdate get updateFirst => _${oi.dartName}QueryBuilderUpdateImpl(this, limit: 1);

    _${oi.dartName}QueryUpdate get updateAll => _${oi.dartName}QueryBuilderUpdateImpl(this);
  }
  ''';
}
