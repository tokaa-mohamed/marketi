import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/home_entity.dart';
import '../repos/home_repo.dart';

class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<Either<Failure, HomeDataEntity>> call() async {
    return await repository.getHomeData();
  }
}
