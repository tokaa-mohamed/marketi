import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/api/internet_connection_checker.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/inner_views/brands/data/data_sources/brands_remote_data_source.dart';
import 'package:marketi/features/home/inner_views/brands/data/models/brand_model.dart';
import 'package:marketi/features/home/inner_views/brands/data/repos/brands_repo_impl.dart';
import 'package:marketi/features/home/inner_views/brands/domain/repos/brands_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockBrandsRemoteDataSource extends Mock implements BrandsRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late BrandsRemoteDataSource remoteDataSource;
  late NetworkInfo networkInfo;
  late BrandsRepository repository;

  setUp(() {
    remoteDataSource = MockBrandsRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = BrandsRepositoryImpl(
      remoteDataSource: remoteDataSource,
      networkInfo: networkInfo,
    );
  });

  const tBrandModel = BrandModel(
    id: 1,
    name: 'Test Brand',
    image: 'test.png',
    productsCount: 10,
  );

  const tProductModel = ProductModel(
    id: 1,
    name: 'Test Product',
    price: 100,
    image: 'test.png',
    rating: 4.5,
    isFavorite: false,
  );

  group('getBrands', () {
    test(
      'should check if the device is online',
      () async {
        // Arrange
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        when(() => remoteDataSource.getBrands()).thenAnswer((_) async => [tBrandModel]);

        // Act
        await repository.getBrands();

        // Assert
        verify(() => networkInfo.isConnected);
      },
    );

    group('device is online', () {
      setUp(() {
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // Arrange
          when(() => remoteDataSource.getBrands()).thenAnswer((_) async => [tBrandModel]);

          // Act
          final result = await repository.getBrands();

          // Assert
          verify(() => remoteDataSource.getBrands());
          expect(result, equals(const Right([tBrandModel])));
        },
      );
    });
  });

  group('getBrandProducts', () {
    const tBrandId = 1;
    test(
      'should check if the device is online',
      () async {
        // Arrange
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        when(() => remoteDataSource.getBrandProducts(any())).thenAnswer((_) async => [tProductModel]);

        // Act
        await repository.getBrandProducts(tBrandId);

        // Assert
        verify(() => networkInfo.isConnected);
      },
    );

    group('device is online', () {
      setUp(() {
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // Arrange
          when(() => remoteDataSource.getBrandProducts(any())).thenAnswer((_) async => [tProductModel]);

          // Act
          final result = await repository.getBrandProducts(tBrandId);

          // Assert
          verify(() => remoteDataSource.getBrandProducts(tBrandId));
          expect(result, equals(const Right([tProductModel])));
        },
      );
    });
  });
}
