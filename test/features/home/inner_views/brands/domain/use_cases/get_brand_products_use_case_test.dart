import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/home/domain/entities/product_entity.dart';
import 'package:marketi/features/home/inner_views/brands/domain/repos/brands_repo.dart';
import 'package:marketi/features/home/inner_views/brands/domain/use_cases/get_brand_products_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockBrandsRepository extends Mock implements BrandsRepository {}

void main() {
  late BrandsRepository repository;
  late GetBrandProductsUseCase useCase;

  setUp(() {
    repository = MockBrandsRepository();
    useCase = GetBrandProductsUseCase(repository);
  });

  const tBrandId = 1;
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
    'should call [BrandsRepository.getBrandProducts] with correct id and return [List<ProductEntity>]',
    () async {
      // Arrange
      when(() => repository.getBrandProducts(any()))
          .thenAnswer((_) async => const Right(tProducts));

      // Act
      final result = await useCase(tBrandId);

      // Assert
      expect(result, const Right<Failure, List<ProductEntity>>(tProducts));
      verify(() => repository.getBrandProducts(tBrandId)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'should return [Failure] when [BrandsRepository.getBrandProducts] fails',
    () async {
      // Arrange
      const tFailure = ApiFailure(message: 'Server Error');
      when(() => repository.getBrandProducts(any()))
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(tBrandId);

      // Assert
      expect(result, const Left<Failure, List<ProductEntity>>(tFailure));
      verify(() => repository.getBrandProducts(tBrandId)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
