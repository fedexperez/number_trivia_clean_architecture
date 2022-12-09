import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_respository.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

@GenerateMocks([NumberTriviaRepository])
void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  late int tNumber;
  late String tNumberString;
  late NumberTrivia tNumberTrivia;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(repository: mockNumberTriviaRepository);
    tNumber = 1;
    tNumberString = '1';
    tNumberTrivia = NumberTrivia(number: tNumber, text: 'test');
  });

  test('should get number trivia from the repository', () async {
    // "On the fly" implementation of the Repository using the Mockito package.
    //arange
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumberString))
        .thenAnswer((_) async => Right(tNumberTrivia));
    // The "act" phase of the test. Call the not-yet-existent method.
    final result = await usecase(Params(number: tNumberString));
    //assert
    expect(result, equals(Right(tNumberTrivia)));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumberString));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
