import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/favourit_page/domain/entities/favourit_products_entities.dart';
import 'package:marketi/favourit_page/domain/repositories/favourit_products_repositories.dart';

class GetFavouritProductsUseCase {
  final FavouritProductsRepositories repositorie;

  GetFavouritProductsUseCase({required this.repositorie});
  Future<Either<Failure, List<FavouritProductsEntities>>>
      callFavouritProducts() {
    return repositorie.getFavouritProducts();
  }
}
