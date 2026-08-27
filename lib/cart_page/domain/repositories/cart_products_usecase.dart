import 'package:dartz/dartz.dart';
import 'package:marketi/cart_page/domain/entities/cart_products_entities.dart';
import 'package:marketi/core/errors/failure.dart';

abstract class CartProductsUsecase {
  Future<Either<Failure, List<CartProductsEntities>>> getCartProducts();
}
