import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:marketi/core/api/internet_connection_checker.dart';
import 'package:marketi/core/errors/failure.dart';

import '../../domain/entities/favourit_products_entities.dart';
import '../../domain/repositories/favourit_products_repositories.dart';
import '../data_source/favourit_products_remote_data_source.dart';

class FavouritProductsRepositoryImpl extends FavouritProductsRepositories {
  final FavouritProductsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FavouritProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<FavouritProductsEntities>>>
  getFavouritProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final favouritProducts = await remoteDataSource.getFavouritProducts();
        return Right(favouritProducts);
      } on DioException catch (e) {
        final String errorMessage =
            e.response?.data?['message']?.toString() ??
            e.message ??
            'An API error occurred';

        return Left(ApiFailure(message: errorMessage));
      }
    } else {
      return Left(NoInternetFailure(message: 'No Internet Connection'));
    }
  }
}
