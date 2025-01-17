// ignore_for_file: non_constant_identifier_names, public_member_api_docs

import 'package:general_lib/general_lib.dart';
import 'default_scheme.dart';

final List<Map<String, dynamic>> example_database_schemes = () {
  final GeneralLibSchemeType generalLibSchemeType = GeneralLibSchemeType.database;
  final Set<GeneralLibSchemeType> generalLibSchemeTypes = {
    generalLibSchemeType,
    GeneralLibSchemeType.local,
  };

  final List<Map<String, dynamic>> database_schemes_procces = [
    for (final GeneralLibSchemeType element in generalLibSchemeTypes) ...[
      ExampleDefaultScheme.account(
        generalLibSchemeType: element,
      ), 
      ExampleDefaultScheme.session(
        generalLibSchemeType: element,
      ),  
    ], 
  ];
  return database_schemes_procces;
}();
