import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/errors/failure.dart';
import 'package:marketi/features/home/inner_views/brands/domain/entities/brand_entity.dart';
import 'package:marketi/features/home/inner_views/brands/domain/repos/brands_repo.dart';
import 'package:marketi/features/home/inner_views/brands/domain/use_cases/get_brands_use_case.dart';
import 'package:mocktail/mocktail.dart';

class MockBrandsRepository extends Mock implements BrandsRepository {}

void main() {
  late BrandsRepository repository;
  late GetBrandsUseCase useCase;

  setUp(() {
    repository = MockBrandsRepository();
    useCase = GetBrandsUseCase(repository);
  });

  const tBrands = [
    BrandEntity(
      id: 1,
      name: 'Test Brand',
      image: 'test.png',
      productsCount: 10,
    ),
  ];

  test(
    'should call [BrandsRepository.getBrands] and return [List<BrandEntity>]',
    () async {
      // Arrange
      when(() => repository.getBrands())
          .thenAnswer((_) async => const Right(tBrands));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Right<Failure, List<BrandEntity>>(tBrands));
      verify(() => repository.getBrands()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );

  test(
    'should return [Failure] when [BrandsRepository.getBrands] fails',
    () async {
      // Arrange
      const tFailure = ApiFailure(message: 'Server Error');
      when(() => repository.getBrands())
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase();

      // Assert
      expect(result, const Left<Failure, List<BrandEntity>>(tFailure));
      verify(() => repository.getBrands()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
