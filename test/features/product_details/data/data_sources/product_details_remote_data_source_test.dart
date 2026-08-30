import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/api/dio_helper.dart';
import 'package:marketi/features/product_details/data/data_sources/product_details_remote_data_source.dart';
import 'package:marketi/features/product_details/data/models/product_details_model.dart';
import 'package:mocktail/mocktail.dart';

class MockDioHelper extends Mock implements DioHelper {}

void main() {
  late DioHelper dioHelper;
  late ProductDetailsRemoteDataSource dataSource;

  setUp(() {
    dioHelper = MockDioHelper();
    dataSource = ProductDetailsRemoteDataSourceImpl(dioHelper);
  });

  group("Get Product Details", () {
    final tResponse = Response(
      data: {
        "success": true,
        "data": {
          "id": 1,
          "name": "Test Product",
          "price": 100.0,
          "main_image_url": "test.png",
          "rating": 4.5,
          "is_favorite": false,
          "description": "desc",
          "gallery": [],
          "sizes": [],
          "stock_quantity": 10
        }
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

    test(
      "Should call the api and return [ProductDetailsModel] when success",
      () async {
        // Arrange
        when(() => dioHelper.getData(url: any(named: 'url')))
            .thenAnswer((_) async => tResponse);

        // Act
        final result = await dataSource.getProductDetails(1);

        // Assert
        expect(result, isA<ProductDetailsModel>());
        expect(result.name, "Test Product");
      },
    );
  });
}
