import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(
    numberm: 1,
    textm: 'Test Text',
  );

  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      //assert
      expect(tNumberTriviaModel, isA<NumberTrivia>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is an integer',
      () async {
        //arrange
        final json = fixture('trivia.json');
        //act
        final result = NumberTriviaModel.fromJson(json);
        //assert
        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should return a valid model when the JSON number is a double',
      () async {
        //arrange
        final json = fixture('trivia_double.json');
        //act
        final result = NumberTriviaModel.fromJson(json);
        //assert
        expect(result, tNumberTriviaModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        //act
        final result = tNumberTriviaModel.toMap();
        //assert
        final expectedMap = {"text": "Test Text", "number": 1};
        expect(result, expectedMap);
      },
    );
  });
}
