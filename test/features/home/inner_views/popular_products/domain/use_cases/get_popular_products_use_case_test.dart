import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/home/domain/entities/product_entity.dart';
import 'package:marketi/features/home/inner_views/popular_products/domain/repos/popular_products_repo.dart';
import 'package:marketi/features/home/inner_views/popular_products/domain/use_cases/get_popular_products_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockPopularProductsRepository extends Mock implements PopularProductsRepository {}

void main() {
  late PopularProductsRepository repository;
  late GetPopularProductsUseCase useCase;

  setUp(() {
    repository = MockPopularProductsRepository();
    useCase = GetPopularProductsUseCase(repository);
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
    'should call [PopularProductsRepository.getPopularProducts] and return [List<ProductEntity>]',
    () async {
      // Arrange
      when(() => repository.getPopularProducts())
          .thenAnswer((_) async => const Right(tProducts));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Right<Failure, List<ProductEntity>>(tProducts));
      verify(() => repository.getPopularProducts()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'should return [Failure] when [PopularProductsRepository.getPopularProducts] fails',
    () async {
      // Arrange
      const tFailure = ApiFailure(message: 'Server Error');
      when(() => repository.getPopularProducts())
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Left<Failure, List<ProductEntity>>(tFailure));
      verify(() => repository.getPopularProducts()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
