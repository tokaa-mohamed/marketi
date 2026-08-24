import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../domain/entities/product_entity.dart';
import '../repos/categories_repo.dart';

class GetCategoryProductsUseCase {
  final CategoriesRepository repository;

  GetCategoryProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call(int categoryId) async {
    return await repository.getCategoryProducts(categoryId);
  }
}
