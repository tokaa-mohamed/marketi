import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../domain/entities/product_entity.dart';
import '../entities/brand_entity.dart';

abstract class BrandsRepository {
  Future<Either<Failure, List<BrandEntity>>> getBrands();
  Future<Either<Failure, List<ProductEntity>>> getBrandProducts(int brandId);
}
