import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:marketi/core/api/internet_connection_checker.dart';
import 'package:marketi/core/errors/failure.dart';

import '../../domain/entities/cart_products_entities.dart';
import '../../domain/repositories/cart_products_repository.dart';
import '../data_source/data_source_for_cart_products.dart';

class CartProductsRepositoryImpl extends CartProductsRepository {
  final CartProductsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CartProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CartProductsEntities>>> getCartProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final cartProducts = await remoteDataSource.getCartProducts();
        return Right(cartProducts);
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
