import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/core/utils/input_converter.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/presentation/bloc/number_trivia/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetRandomNumberTrivia, InputConverter])
@GenerateNiceMocks(
    [MockSpec<GetConcreteNumberTrivia>(as: #BaseMockGetConcreteNumberTrivia)])
void main() {
  late BaseMockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;
  late NumberTriviaBloc numberTriviaBloc;

  setUp(() {
    mockGetConcreteNumberTrivia = BaseMockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    numberTriviaBloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test(
    'initialState should be empty',
    () async {
      //assert
      expect(numberTriviaBloc.state, equals(NumberTriviaInitialState()));
    },
  );

  group('GetTrviaForConcreteNumber', () {
    const String tNumberString = '1';
    const int tNumberParsed = 1;
    const NumberTrivia tNumberTrivia =
        NumberTrivia(text: 'Test Text', number: tNumberParsed);

    void setUpMockInputConverterSuccess() {
      when(mockInputConverter.stringToUnsignedInteger(tNumberString))
          .thenReturn(Future.value(tNumberParsed));
    }

    test(
      '''should call the input converter to validate 
      and convert the String to an unsigned integer''',
      () async* {
        //arrange
        setUpMockInputConverterSuccess();
        //act
        numberTriviaBloc.add(
            const GetTriviaForConcreteNumberEvent(numberString: tNumberString));
        await untilCalled(
            mockInputConverter.stringToUnsignedInteger(tNumberString));
        //assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test(
      'should emit [ErrorState] when the input is invalid',
      () async* {
        //arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenThrow(const FormatException());
        //assert later
        final List<NumberTriviaState> expected = [
          NumberTriviaInitialState(),
          const ErrorState(errorMessage: invalidInputFailureMessage)
        ];
        expectLater(numberTriviaBloc.state, emitsInOrder(expected));
        //act
        numberTriviaBloc.add(
            const GetTriviaForConcreteNumberEvent(numberString: tNumberString));
      },
    );

    test(
      'should get data from the concrete use case',
      () async {
        //arrange
        when(mockInputConverter.stringToUnsignedInteger(tNumberString))
            .thenAnswer((_) async => Future.value(tNumberParsed));
        when(mockGetConcreteNumberTrivia(const Params(number: tNumberString)))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        //act
        numberTriviaBloc.add(
            const GetTriviaForConcreteNumberEvent(numberString: tNumberString));
        await untilCalled(
          mockGetConcreteNumberTrivia(const Params(number: tNumberString)),
        );
        //assert
        verify(
            mockGetConcreteNumberTrivia(const Params(number: tNumberString)));
      },
    );

    test(
      'should emit [LoadingState, LoadedState] when data is gotten succesfully',
      () async* {
        //arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(const Params(number: tNumberString)))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        //assert later
        final List<NumberTriviaState> expected = [
          NumberTriviaInitialState(),
          LoadingState(),
          const LoadedState(trivia: tNumberTrivia)
        ];
        expectLater(numberTriviaBloc.state, emitsInOrder(expected));
        //act
        numberTriviaBloc.add(
            const GetTriviaForConcreteNumberEvent(numberString: tNumberString));
      },
    );

    test(
      'should emit [LoadingState, ErrorState] when getting data fails',
      () async* {
        //arrange
        setUpMockInputConverterSuccess();
        when(mockGetConcreteNumberTrivia(const Params(number: tNumberString)))
            .thenAnswer((_) async => Left(ServerFailure()));
        //assert later
        final List<NumberTriviaState> expected = [
          NumberTriviaInitialState(),
          LoadingState(),
          const ErrorState(errorMessage: serverFailureMessage)
        ];
        expectLater(numberTriviaBloc.state, emitsInOrder(expected));
        //act
        numberTriviaBloc.add(
            const GetTriviaForConcreteNumberEvent(numberString: tNumberString));
      },
    );
  });

  group('GetTrviaForRandomNumber', () {
    const NumberTrivia tNumberTrivia =
        NumberTrivia(text: 'Test Text', number: 1);

    test(
      'should get data from the random use case',
      () async* {
        //arrange
        when(mockGetRandomNumberTrivia(NoParams()))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        //act
        numberTriviaBloc.add(GetTriviaForRandomNumberEvent());
        await untilCalled(
          mockGetRandomNumberTrivia(NoParams()),
        );
        //assert
        verify(mockGetRandomNumberTrivia(NoParams()));
      },
    );

    test(
      'should emit [LoadingState, LoadedState] when data is gotten succesfully',
      () async* {
        //arrange
        when(mockGetRandomNumberTrivia(NoParams()))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        //assert later
        final List<NumberTriviaState> expected = [
          NumberTriviaInitialState(),
          LoadingState(),
          const LoadedState(trivia: tNumberTrivia)
        ];
        expectLater(numberTriviaBloc.state, emitsInOrder(expected));
        //act
        numberTriviaBloc.add(GetTriviaForRandomNumberEvent());
      },
    );

    test(
      'should emit [LoadingState, ErrorState] when getting data fails',
      () async* {
        //arrange
        when(mockGetRandomNumberTrivia(NoParams()))
            .thenAnswer((_) async => Left(ServerFailure()));
        //assert later
        final List<NumberTriviaState> expected = [
          NumberTriviaInitialState(),
          LoadingState(),
          const ErrorState(errorMessage: serverFailureMessage)
        ];
        expectLater(numberTriviaBloc.state, emitsInOrder(expected));
        //act
        numberTriviaBloc.add(GetTriviaForRandomNumberEvent());
      },
    );
  });
}
