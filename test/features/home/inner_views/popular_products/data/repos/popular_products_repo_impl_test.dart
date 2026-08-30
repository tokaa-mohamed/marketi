import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/api/internet_connection_checker.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/inner_views/popular_products/data/data_sources/popular_products_remote_data_source.dart';
import 'package:marketi/features/home/inner_views/popular_products/data/repos/popular_products_repo_impl.dart';
import 'package:marketi/features/home/inner_views/popular_products/domain/repos/popular_products_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularProductsRemoteDataSource extends Mock implements PopularProductsRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late PopularProductsRemoteDataSource remoteDataSource;
  late NetworkInfo networkInfo;
  late PopularProductsRepository repository;

  setUp(() {
    remoteDataSource = MockPopularProductsRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = PopularProductsRepositoryImpl(
      remoteDataSource: remoteDataSource,
      networkInfo: networkInfo,
    );
  });

  const tProductModel = ProductModel(
    id: 1,
    name: 'Test Product',
    price: 100,
    image: 'test.png',
    rating: 4.5,
    isFavorite: false,
  );

  group('getPopularProducts', () {
    test(
      'should check if the device is online',
      () async {
        // Arrange
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        when(() => remoteDataSource.getPopularProducts()).thenAnswer((_) async => [tProductModel]);

        // Act
        await repository.getPopularProducts();

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
          when(() => remoteDataSource.getPopularProducts()).thenAnswer((_) async => [tProductModel]);

          // Act
          final result = await repository.getPopularProducts();

          // Assert
          verify(() => remoteDataSource.getPopularProducts());
          expect(result, equals(const Right([tProductModel])));
        },
      );
    });
  });
}
