import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/favorites/domain/repositories/favourit_products_repositories.dart';

class AddFavoriteUseCase {
  final FavouritProductsRepositories repository;

  AddFavoriteUseCase({required this.repository});

  Future<Either<Failure, String>> call(int productId) {
    return repository.addFavorite(productId);
  }
}
