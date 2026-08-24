import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../entities/category_entity.dart';
import '../repos/categories_repo.dart';

class GetCategoriesUseCase {
  final CategoriesRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await repository.getCategories();
  }
}
