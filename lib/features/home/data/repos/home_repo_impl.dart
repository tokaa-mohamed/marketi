import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/api/internet_connection_checker.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/repos/home_repo.dart';
import '../data_sources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, HomeDataEntity>> getHomeData() async {
    if (await networkInfo.isConnected) {
      try {
        final homeModel = await remoteDataSource.getHomeData();
        return Right(homeModel);
      } catch (error, stackTrace) {
        debugPrint('Parsing Error: $error');
        debugPrint('Stack Trace: $stackTrace');
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}

