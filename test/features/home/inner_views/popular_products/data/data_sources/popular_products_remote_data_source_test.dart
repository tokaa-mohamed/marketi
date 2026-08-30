import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/api/dio_helper.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/inner_views/popular_products/data/data_sources/popular_products_remote_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockDioHelper extends Mock implements DioHelper {}

void main() {
  late DioHelper dioHelper;
  late PopularProductsRemoteDataSource dataSource;

  setUp(() {
    dioHelper = MockDioHelper();
    dataSource = PopularProductsRemoteDataSourceImpl(dioHelper);
  });

  group("Get Popular Products", () {
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
        final result = await dataSource.getPopularProducts();

        // Assert
        expect(result, isA<List<ProductModel>>());
        expect(result.first.name, "Test Product");
      },
    );
  });
}
