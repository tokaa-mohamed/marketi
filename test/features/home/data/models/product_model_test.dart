import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/features/home/data/models/product_model.dart';
import 'package:marketi/features/home/domain/entities/product_entity.dart';

void main() {
  const tProductModel = ProductModel(
    id: 1,
    name: 'Test Product',
    price: 100,
    image: 'test.png',
    rating: 4.5,
    isFavorite: false,
    discount: 10,
  );

  test('should be a subclass of ProductEntity', () {
    expect(tProductModel, isA<ProductEntity>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON contains main_image_url', () {
      final Map<String, dynamic> jsonMap = {
        "id": 1,
        "name": "Test Product",
        "price": "100.0",
        "main_image_url": "http://test.png",
        "rating": 4.5,
        "is_favorite": true,
        "discount": 10
      };

      final result = ProductModel.fromJson(jsonMap);

      expect(result.id, 1);
      expect(result.price, 100.0);
      expect(result.isFavorite, true);
      expect(result.image, "http://test.png");
    });

    test('should return a valid model when price is a number', () {
      final Map<String, dynamic> jsonMap = {
        "id": 1,
        "name": "Test Product",
        "price": 100,
        "main_image_url": "test.png",
        "rating": 4.5,
        "is_favorite": false,
      };

      final result = ProductModel.fromJson(jsonMap);
      expect(result.price, 100);
    });
  });
}
