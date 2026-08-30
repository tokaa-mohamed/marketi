import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/home/inner_views/categories/domain/entities/category_entity.dart';
import 'package:marketi/features/home/inner_views/categories/domain/repos/categories_repo.dart';
import 'package:marketi/features/home/inner_views/categories/domain/use_cases/get_categories_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoriesRepository extends Mock implements CategoriesRepository {}

void main() {
  late CategoriesRepository repository;
  late GetCategoriesUseCase useCase;

  setUp(() {
    repository = MockCategoriesRepository();
    useCase = GetCategoriesUseCase(repository);
  });

  const tCategories = [
    CategoryEntity(
      id: 1,
      name: 'Test Category',
      image: 'test.png',
      description: 'Test Description',
      productsCount: 10,
    ),
  ];

  test(
    'should call [CategoriesRepository.getCategories] and return [List<CategoryEntity>]',
    () async {
      // Arrange
      when(() => repository.getCategories())
          .thenAnswer((_) async => const Right(tCategories));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Right<Failure, List<CategoryEntity>>(tCategories));
      verify(() => repository.getCategories()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'should return [Failure] when [CategoriesRepository.getCategories] fails',
    () async {
      // Arrange
      const tFailure = ApiFailure(message: 'Server Error');
      when(() => repository.getCategories())
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Left<Failure, List<CategoryEntity>>(tFailure));
      verify(() => repository.getCategories()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
