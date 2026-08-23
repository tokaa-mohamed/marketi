import 'package:dartz/dartz.dart';
import '../../../../core/api/internet_connection_checker.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/repos/product_details_repo.dart';
import '../data_sources/product_details_remote_data_source.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final ProductDetailsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductDetailsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(int productId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getProductDetails(productId);
        return Right(result);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
