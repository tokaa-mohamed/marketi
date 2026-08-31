import 'package:dartz/dartz.dart';
import 'package:marketi/core/api/internet_connection_checker.dart';
import 'package:marketi/core/errors/error_handler.dart';
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
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addToCart({
    required int productId,
    int quantity = 1,
    String size = "M",
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.addToCart(
          productId: productId,
          quantity: quantity,
          size: size,
        );
        return Right(response.data['message'] ?? 'Added to cart');
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
