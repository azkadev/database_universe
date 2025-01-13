part of "package:database_universe/core/core/generator/database_universe_generator.dart";

String _generateSchema(ObjectInfo object) {
  String generatePropertySchema(PropertyInfo p) {
    return '''
    DatabaseUniversePropertySchema(
      name: '${p.databaseUniverseName}',
      type: DatabaseUniverseType.${p.type.name},
      ${p.targetDatabaseUniverseName != null ? "target: '${p.targetDatabaseUniverseName}'," : ''}
      ${p.enumMap != null ? 'enumMap: ${jsonEncode(p.enumMap)},' : ''}
    ),''';
  }

  String generateIndexSchema(IndexInfo index) {
    return '''
    DatabaseUniverseIndexSchema(
      name: '${index.name}',
      properties: [${index.properties.map((e) => '"$e",').join()}],
      unique: ${index.unique},
      hash: ${index.hash},
    ),''';
  }

  final embeddedSchemas =
      object.embeddedDartNames.map((e) => '${e.capitalize()}Schema').join(',');
  final properties = object.properties
      .where((e) => !e.isId || e.type != DatabaseUniverseType.long)
      .map(generatePropertySchema)
      .join();
  final indexes = object.indexes.map(generateIndexSchema).join();
  return '''
    const ${object.dartName.capitalize()}Schema = DatabaseUniverseGeneratedSchema(
      schema: DatabaseUniverseSchema(
        name: '${object.databaseUniverseName}',
        ${object.idProperty != null ? "idName: '${object.idProperty!.databaseUniverseName}'," : ''}
        embedded: ${object.isEmbedded},
        properties: [$properties],
        indexes: [$indexes],
      ),
      converter: DatabaseUniverseObjectConverter<${object.idProperty?.dartType ?? 'void'}, ${object.dartName}>(
        serialize: serialize${object.dartName},
        deserialize: deserialize${object.dartName},
        ${!object.isEmbedded ? 'deserializeProperty: deserialize${object.dartName}Prop,' : ''}
      ),
      ${object.isEmbedded ? '' : 'embeddedSchemas: [$embeddedSchemas],'}
    );''';
}
