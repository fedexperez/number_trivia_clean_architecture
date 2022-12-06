import 'package:dartz/dartz.dart';

import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(String number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
