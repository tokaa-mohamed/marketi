import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../domain/entities/product_entity.dart';

abstract class PopularProductsRepository {
  Future<Either<Failure, List<ProductEntity>>> getPopularProducts();
}
