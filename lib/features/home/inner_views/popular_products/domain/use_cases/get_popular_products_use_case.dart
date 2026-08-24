import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../domain/entities/product_entity.dart';
import '../repos/popular_products_repo.dart';

class GetPopularProductsUseCase {
  final PopularProductsRepository repository;

  GetPopularProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repository.getPopularProducts();
  }
}
