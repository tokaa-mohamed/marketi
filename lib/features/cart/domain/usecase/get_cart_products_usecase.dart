import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/failure.dart';

import '../entities/cart_products_entities.dart';
import '../repositories/cart_products_repository.dart';

class GetCartProductsUsecase {
  final CartProductsRepository repository;

  GetCartProductsUsecase({required this.repository});

  Future<Either<Failure, List<CartProductsEntities>>> callProductsInTheCart() {
    return repository.getCartProducts();
  }
}
