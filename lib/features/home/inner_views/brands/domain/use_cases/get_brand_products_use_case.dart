import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../domain/entities/product_entity.dart';
import '../repos/brands_repo.dart';

class GetBrandProductsUseCase {
  final BrandsRepository repository;

  GetBrandProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call(int brandId) async {
    return await repository.getBrandProducts(brandId);
  }
}
