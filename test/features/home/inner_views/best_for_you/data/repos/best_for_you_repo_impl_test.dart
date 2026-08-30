import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/api/internet_connection_checker.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/inner_views/best_for_you/data/data_sources/best_for_you_remote_data_source.dart';
import 'package:marketi/features/home/inner_views/best_for_you/data/repos/best_for_you_repo_impl.dart';
import 'package:marketi/features/home/inner_views/best_for_you/domain/repos/best_for_you_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockBestForYouRemoteDataSource extends Mock implements BestForYouRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late BestForYouRemoteDataSource remoteDataSource;
  late NetworkInfo networkInfo;
  late BestForYouRepository repository;

  setUp(() {
    remoteDataSource = MockBestForYouRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = BestForYouRepositoryImpl(
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

  group('getBestForYouProducts', () {
    test(
      'should check if the device is online',
      () async {
        // Arrange
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        when(() => remoteDataSource.getBestForYouProducts()).thenAnswer((_) async => [tProductModel]);

        // Act
        await repository.getBestForYouProducts();

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
          when(() => remoteDataSource.getBestForYouProducts()).thenAnswer((_) async => [tProductModel]);

          // Act
          final result = await repository.getBestForYouProducts();

          // Assert
          verify(() => remoteDataSource.getBestForYouProducts());
          expect(result, equals(const Right([tProductModel])));
        },
      );
    });
  });
}
