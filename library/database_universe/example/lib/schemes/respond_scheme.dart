// ignore_for_file: non_constant_identifier_names, public_member_api_docs

import 'package:general_lib/general_lib_core.dart';
import 'default_scheme.dart';

final List<Map<String, dynamic>> example_respond_schemes = () {
  final GeneralLibSchemeType generalLibSchemeType = GeneralLibSchemeType.scheme;
  return [
    ExampleDefaultScheme.account(generalLibSchemeType: generalLibSchemeType),
    ExampleDefaultScheme.session(generalLibSchemeType: generalLibSchemeType),
  ];
}();
