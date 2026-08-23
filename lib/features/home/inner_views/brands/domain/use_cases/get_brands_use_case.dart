import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../entities/brand_entity.dart';
import '../repos/brands_repo.dart';

class GetBrandsUseCase {
  final BrandsRepository repository;

  GetBrandsUseCase(this.repository);

  Future<Either<Failure, List<BrandEntity>>> call() async {
    return await repository.getBrands();
  }
}
