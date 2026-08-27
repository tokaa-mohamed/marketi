import 'package:dartz/dartz.dart';
import 'package:marketi/cart_page/domain/entities/cart_products_entities.dart';
import 'package:marketi/cart_page/domain/repositories/cart_products_repository.dart';
import 'package:marketi/core/errors/failure.dart';

class GetCartProductsUsecase {
  final CartProductsRepository repository;

  GetCartProductsUsecase({required this.repository});
  Future<Either<Failure, List<CartProductsEntities>>> callProductsInTheCart() {
    return repository.getCartProducts();
  }
}
