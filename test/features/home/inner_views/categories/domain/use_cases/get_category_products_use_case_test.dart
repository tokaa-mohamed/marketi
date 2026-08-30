import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/home/domain/entities/product_entity.dart';
import 'package:marketi/features/home/inner_views/categories/domain/repos/categories_repo.dart';
import 'package:marketi/features/home/inner_views/categories/domain/use_cases/get_category_products_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoriesRepository extends Mock implements CategoriesRepository {}

void main() {
  late CategoriesRepository repository;
  late GetCategoryProductsUseCase useCase;

  setUp(() {
    repository = MockCategoriesRepository();
    useCase = GetCategoryProductsUseCase(repository);
  });

  const tCategoryId = 1;
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
    'should call [CategoriesRepository.getCategoryProducts] with correct id and return [List<ProductEntity>]',
    () async {
      // Arrange
      when(() => repository.getCategoryProducts(any()))
          .thenAnswer((_) async => const Right(tProducts));

      // Act
      final result = await useCase(tCategoryId);

      // Assert
      expect(result, const Right<Failure, List<ProductEntity>>(tProducts));
      verify(() => repository.getCategoryProducts(tCategoryId)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'should return [Failure] when [CategoriesRepository.getCategoryProducts] fails',
    () async {
      // Arrange
      const tFailure = ApiFailure(message: 'Server Error');
      when(() => repository.getCategoryProducts(any()))
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(tCategoryId);

      // Assert
      expect(result, const Left<Failure, List<ProductEntity>>(tFailure));
      verify(() => repository.getCategoryProducts(tCategoryId)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
