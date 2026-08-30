import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/api/internet_connection_checker.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/inner_views/categories/data/data_sources/categories_remote_data_source.dart';
import 'package:marketi/features/home/inner_views/categories/data/models/category_model.dart';
import 'package:marketi/features/home/inner_views/categories/data/repos/categories_repo_impl.dart';
import 'package:marketi/features/home/inner_views/categories/domain/repos/categories_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoriesRemoteDataSource extends Mock implements CategoriesRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late CategoriesRemoteDataSource remoteDataSource;
  late NetworkInfo networkInfo;
  late CategoriesRepository repository;

  setUp(() {
    remoteDataSource = MockCategoriesRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = CategoriesRepositoryImpl(
      remoteDataSource: remoteDataSource,
      networkInfo: networkInfo,
    );
  });

  const tCategoryModel = CategoryModel(
    id: 1,
    name: 'Test',
    image: 'test.png',
    description: 'desc',
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

  group('getCategories', () {
    test(
      'should check if the device is online',
      () async {
        // Arrange
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        when(() => remoteDataSource.getCategories()).thenAnswer((_) async => [tCategoryModel]);

        // Act
        await repository.getCategories();

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
          when(() => remoteDataSource.getCategories()).thenAnswer((_) async => [tCategoryModel]);

          // Act
          final result = await repository.getCategories();

          // Assert
          verify(() => remoteDataSource.getCategories());
          expect(result, equals(const Right([tCategoryModel])));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // Arrange
          when(() => remoteDataSource.getCategories()).thenThrow(Exception());

          // Act
          final result = await repository.getCategories();

          // Assert
          verify(() => remoteDataSource.getCategories());
          expect(result, isA<Left<Failure, dynamic>>());
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(() => networkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return NoInternetFailure when the device is offline',
        () async {
          // Act
          final result = await repository.getCategories();

          // Assert
          verifyZeroInteractions(remoteDataSource);
          expect(result, isA<Left<Failure, dynamic>>());
        },
      );
    });
  });

  group('getCategoryProducts', () {
    const tCategoryId = 1;
    test(
      'should check if the device is online',
      () async {
        // Arrange
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        when(() => remoteDataSource.getCategoryProducts(any())).thenAnswer((_) async => [tProductModel]);

        // Act
        await repository.getCategoryProducts(tCategoryId);

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
          when(() => remoteDataSource.getCategoryProducts(any())).thenAnswer((_) async => [tProductModel]);

          // Act
          final result = await repository.getCategoryProducts(tCategoryId);

          // Assert
          verify(() => remoteDataSource.getCategoryProducts(tCategoryId));
          expect(result, equals(const Right([tProductModel])));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // Arrange
          when(() => remoteDataSource.getCategoryProducts(any())).thenThrow(Exception());

          // Act
          final result = await repository.getCategoryProducts(tCategoryId);

          // Assert
          verify(() => remoteDataSource.getCategoryProducts(tCategoryId));
          expect(result, isA<Left<Failure, dynamic>>());
        },
      );
    });
  });
}
