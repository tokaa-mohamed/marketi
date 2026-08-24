import 'package:dartz/dartz.dart';
import '../../../../../../core/api/internet_connection_checker.dart';
import '../../../../../../core/errors/error_handler.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../domain/repos/popular_products_repo.dart';
import '../data_sources/popular_products_remote_data_source.dart';

class PopularProductsRepositoryImpl implements PopularProductsRepository {
  final PopularProductsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PopularProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });


  @override
  Future<Either<Failure, List<ProductEntity>>> getPopularProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularProducts();
        return Right(result);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
