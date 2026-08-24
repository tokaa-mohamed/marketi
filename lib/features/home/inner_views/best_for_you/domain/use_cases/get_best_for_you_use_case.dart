import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../domain/entities/product_entity.dart';
import '../repos/best_for_you_repo.dart';

class GetBestForYouUseCase {
  final BestForYouRepository repository;

  GetBestForYouUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await repository.getBestForYouProducts();
  }
}
