import 'package:clean_architecture/core/utils/input_converter.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_architecture/core/errors/exceptions.dart';
import 'package:clean_architecture/core/errors/failures.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_respository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final InputConverter inputConverter;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.inputConverter,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      String number) async {
    if (await networkInfo.isConnected) {
      try {
        final int numberParsed =
            await inputConverter.stringToUnsignedInteger(number);
        final remoteTrivia =
            await remoteDataSource.getConcreteNumberTrivia(numberParsed);
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      } on FormatException {
        return Left(FormatFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await remoteDataSource.getRandomNumberTrivia();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
