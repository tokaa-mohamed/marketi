import 'package:dartz/dartz.dart';
import '../../../../../../core/api/internet_connection_checker.dart';
import '../../../../../../core/errors/error_handler.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../domain/entities/brand_entity.dart';
import '../../domain/repos/brands_repo.dart';
import '../data_sources/brands_remote_data_source.dart';

class BrandsRepositoryImpl implements BrandsRepository {
  final BrandsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BrandsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<BrandEntity>>> getBrands() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getBrands();
        return Right(result);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getBrandProducts(int brandId) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getBrandProducts(brandId);
        return Right(result);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
