import 'package:dartz/dartz.dart';
import '../../../../../../core/api/internet_connection_checker.dart';
import '../../../../../../core/errors/error_handler.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../domain/repos/best_for_you_repo.dart';
import '../data_sources/best_for_you_remote_data_source.dart';

class BestForYouRepositoryImpl implements BestForYouRepository {
  final BestForYouRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BestForYouRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProductEntity>>> getBestForYouProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getBestForYouProducts();
        return Right(result);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
