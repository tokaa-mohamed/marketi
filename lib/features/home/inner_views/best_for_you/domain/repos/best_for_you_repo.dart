import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../domain/entities/product_entity.dart';

abstract class BestForYouRepository {
  Future<Either<Failure, List<ProductEntity>>> getBestForYouProducts();
}
