import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/failure.dart';

import '../entities/favourit_products_entities.dart';
import '../repositories/favourit_products_repositories.dart';

class GetFavouritProductsUseCase {
  final FavouritProductsRepositories repositorie;

  GetFavouritProductsUseCase({required this.repositorie});

  Future<Either<Failure, List<FavouritProductsEntities>>>
  callFavouritProducts() {
    return repositorie.getFavouritProducts();
  }
}
