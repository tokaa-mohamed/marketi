import 'package:dartz/dartz.dart';
import 'package:marketi/core/api/internet_connection_checker.dart';
import 'package:marketi/core/errors/error_handler.dart';
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
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addFavorite(int productId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.addFavorite(productId);
        return Right(response.data['message'] ?? 'Added to favorites');
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
