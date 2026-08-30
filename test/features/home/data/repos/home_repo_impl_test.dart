import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/api/internet_connection_checker.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:marketi/features/home/data/models/home_model.dart';
import 'package:marketi/features/home/data/repos/home_repo_impl.dart';
import 'package:marketi/features/home/domain/repos/home_repo.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late HomeRemoteDataSource remoteDataSource;
  late NetworkInfo networkInfo;
  late HomeRepository repository;

  setUp(() {
    remoteDataSource = MockHomeRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = HomeRepositoryImpl(
      remoteDataSource: remoteDataSource,
      networkInfo: networkInfo,
    );
  });

  const tHomeModel = HomeModel(
    banners: [],
    categories: [],
    popularProducts: [],
    bestForYou: [],
    buyAgain: [],
    brands: [],
  );

  group('getHomeData', () {
    test(
      'should check if the device is online',
      () async {
        // Arrange
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
        when(() => remoteDataSource.getHomeData()).thenAnswer((_) async => tHomeModel);

        // Act
        await repository.getHomeData();

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
          when(() => remoteDataSource.getHomeData()).thenAnswer((_) async => tHomeModel);

          // Act
          final result = await repository.getHomeData();

          // Assert
          verify(() => remoteDataSource.getHomeData());
          expect(result, equals(const Right(tHomeModel)));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // Arrange
          when(() => remoteDataSource.getHomeData()).thenThrow(Exception());

          // Act
          final result = await repository.getHomeData();

          // Assert
          verify(() => remoteDataSource.getHomeData());
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
          final result = await repository.getHomeData();

          // Assert
          verifyZeroInteractions(remoteDataSource);
          expect(result, isA<Left<Failure, dynamic>>());
        },
      );
    });
  });
}
