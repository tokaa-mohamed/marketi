import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/product_details_entity.dart';
import '../repos/product_details_repo.dart';

class GetProductDetailsUseCase {
  final ProductDetailsRepository repository;

  GetProductDetailsUseCase(this.repository);

  Future<Either<Failure, ProductDetailsEntity>> call(int productId) async {
    return await repository.getProductDetails(productId);
  }
}
