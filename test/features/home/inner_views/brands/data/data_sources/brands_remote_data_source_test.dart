import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/core/api/dio_helper.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/inner_views/brands/data/data_sources/brands_remote_data_source.dart';
import 'package:marketi/features/home/inner_views/brands/data/models/brand_model.dart';
import 'package:mocktail/mocktail.dart';

class MockDioHelper extends Mock implements DioHelper {}

void main() {
  late DioHelper dioHelper;
  late BrandsRemoteDataSource brandsRemoteDataSource;

  setUp(() {
    dioHelper = MockDioHelper();
    brandsRemoteDataSource = BrandsRemoteDataSourceImpl(dioHelper);
  });

  group("Get Brands", () {
    final tResponse = Response(
      data: {
        "success": true,
        "data": [
          {
            "id": 1,
            "name": "Test Brand",
            "logo": "test.png",
            "products_count": 10
          }
        ]
      },
      statusCode: 200,
      requestOptions: RequestOptions(path: ''),
    );

    test(
      "Should call the api and return [List<BrandModel>] when success",
      () async {
        // Arrange
        when(() => dioHelper.getData(url: any(named: 'url')))
            .thenAnswer((_) async => tResponse);

        // Act
        final result = await brandsRemoteDataSource.getBrands();

        // Assert
        expect(result, isA<List<BrandModel>>());
        expect(result.first.name, "Test Brand");
      },
    );
  });

  group("Get Brand Products", () {
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
        final result = await brandsRemoteDataSource.getBrandProducts(1);

        // Assert
        expect(result, isA<List<ProductModel>>());
        expect(result.first.name, "Test Product");
      },
    );
  });
}
