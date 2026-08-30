import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/home/domain/entities/product_entity.dart';
import 'package:marketi/features/home/inner_views/best_for_you/domain/repos/best_for_you_repo.dart';
import 'package:marketi/features/home/inner_views/best_for_you/domain/use_cases/get_best_for_you_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockBestForYouRepository extends Mock implements BestForYouRepository {}

void main() {
  late BestForYouRepository repository;
  late GetBestForYouUseCase useCase;

  setUp(() {
    repository = MockBestForYouRepository();
    useCase = GetBestForYouUseCase(repository);
  });

  const tProducts = [
    ProductEntity(
      id: 1,
      name: 'Test Product',
      price: 100,
      image: 'test.png',
      rating: 4.5,
      isFavorite: false,
    ),
  ];

  test(
    'should call [BestForYouRepository.getBestForYouProducts] and return [List<ProductEntity>]',
    () async {
      // Arrange
      when(() => repository.getBestForYouProducts())
          .thenAnswer((_) async => const Right(tProducts));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Right<Failure, List<ProductEntity>>(tProducts));
      verify(() => repository.getBestForYouProducts()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'should return [Failure] when [BestForYouRepository.getBestForYouProducts] fails',
    () async {
      // Arrange
      const tFailure = ApiFailure(message: 'Server Error');
      when(() => repository.getBestForYouProducts())
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Left<Failure, List<ProductEntity>>(tFailure));
      verify(() => repository.getBestForYouProducts()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
