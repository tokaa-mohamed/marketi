import 'package:dartz/dartz.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/favourit_page/domain/entities/favourit_products_entities.dart';

abstract class FavouritProductsRepositories {
  Future<Either<Failure, List<FavouritProductsEntities>>> getFavouritProducts();
}
