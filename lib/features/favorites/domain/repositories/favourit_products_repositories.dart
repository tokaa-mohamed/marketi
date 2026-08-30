import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/failure.dart';

import '../entities/favourit_products_entities.dart';

abstract class FavouritProductsRepositories {
  Future<Either<Failure, List<FavouritProductsEntities>>> getFavouritProducts();
  Future<Either<Failure, String>> addFavorite(int productId);
}
