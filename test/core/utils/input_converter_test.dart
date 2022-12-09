import 'package:flutter_test/flutter_test.dart';

import 'package:clean_architecture/core/utils/input_converter.dart';

void main() {
  late InputConverter baseMockInputConverter;

  setUp(() {
    baseMockInputConverter = InputConverter();
  });

  group('stringToUnisgnedInt', () {
    test(
      'should return an integer when the string represents an unsigned integer',
      () async {
        //arrange
        const str = '1';
        //act
        final result =
            await baseMockInputConverter.stringToUnsignedInteger(str);
        //assert
        expect(result, equals(1));
      },
    );

    test(
      'should return a Exception when the string is not an integer',
      () async {
        //arrange
        const str = 'abc';
        //act
        final call = baseMockInputConverter.stringToUnsignedInteger;
        //assert
        expect(() async => await call(str),
            throwsA(const TypeMatcher<FormatException>()));
      },
    );

    test(
      'should return a Failure when the string is a negative integer',
      () async {
        //arrange
        const str = '-12';
        //act
        final call = baseMockInputConverter.stringToUnsignedInteger;
        //assert
        expect(() async => await call(str),
            throwsA(const TypeMatcher<FormatException>()));
      },
    );
  });
}
