import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/failure.dart';

import '../entities/cart_products_entities.dart';

abstract class CartProductsRepository {
  Future<Either<Failure, List<CartProductsEntities>>> getCartProducts();
  Future<Either<Failure, String>> addToCart({
    required int productId,
    int quantity = 1,
    String size = "M",
  });
}
