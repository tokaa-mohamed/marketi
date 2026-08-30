import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/api/dio_helper.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/inner_views/categories/data/data_sources/categories_remote_data_source.dart';
import 'package:marketi/features/home/inner_views/categories/data/models/category_model.dart';
import 'package:mocktail/mocktail.dart';

class MockDioHelper extends Mock implements DioHelper {}

void main() {
  late DioHelper dioHelper;
  late CategoriesRemoteDataSource categoriesRemoteDataSource;

  setUp(() {
    dioHelper = MockDioHelper();
    categoriesRemoteDataSource = CategoriesRemoteDataSourceImpl(dioHelper);
  });

  group("Get Categories", () {
    final tResponse = Response(
      data: {
        "success": true,
        "data": [
          {
            "id": 1,
            "name": "Test",
            "image": "test.png",
            "description": "desc",
            "products_count": 10
          }
        ]
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

    test(
      "Should call the api and return [List<CategoryModel>] when success",
      () async {
        // Arrange
        when(() => dioHelper.getData(url: any(named: 'url')))
            .thenAnswer((_) async => tResponse);

        // Act
        final result = await categoriesRemoteDataSource.getCategories();

        // Assert
        expect(result, isA<List<CategoryModel>>());
        expect(result.first.name, "Test");
        verify(() => dioHelper.getData(url: any(named: 'url'))).called(1);
      },
    );
  });

  group("Get Category Products", () {
    final tResponse = Response(
      data: {
        "success": true,
        "data": {
          "data": [
            {
              "id": 1,
              "name": "Test Product",
              "price": 100.0,
              "main_image_url": "test.png",
              "rating": 4.5,
              "is_favorite": false
            }
          ]
        }
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

    test(
      "Should call the api and return [List<ProductModel>] when success",
      () async {
        // Arrange
        when(() => dioHelper.getData(url: any(named: 'url')))
            .thenAnswer((_) async => tResponse);

        // Act
        final result = await categoriesRemoteDataSource.getCategoryProducts(1);

        // Assert
        expect(result, isA<List<ProductModel>>());
        expect(result.first.name, "Test Product");
        verify(() => dioHelper.getData(url: any(named: 'url'))).called(1);
      },
    );
  });
}
