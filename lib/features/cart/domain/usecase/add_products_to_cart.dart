import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/failure.dart';
import '../repositories/cart_products_repository.dart';

class AddProductsToCartUseCase {
  final CartProductsRepository repository;

  AddProductsToCartUseCase({required this.repository});

  Future<Either<Failure, String>> call({
    required int productId,
    int quantity = 1,
    String size = "M",
  }) {
    return repository.addToCart(
      productId: productId,
      quantity: quantity,
      size: size,
    );
  }
}
