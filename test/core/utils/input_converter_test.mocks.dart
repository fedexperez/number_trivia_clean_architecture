// Mocks generated by Mockito 5.3.2 from annotations
// in clean_architecture/test/core/utils/input_converter_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:clean_architecture/core/utils/input_converter.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [InputConverter].
///
/// See the documentation for Mockito's code generation for more information.
class BaseMockInputConverter extends _i1.Mock implements _i2.InputConverter {
  @override
  _i3.Future<int> stringToUnsignedInteger(String? str) => (super.noSuchMethod(
        Invocation.method(
          #stringToUnsignedInteger,
          [str],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
}
