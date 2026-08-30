import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/features/product_details/data/models/product_details_model.dart';
import 'package:marketi/features/product_details/domain/entities/product_details_entity.dart';

void main() {
  const tProductDetailsModel = ProductDetailsModel(
    id: 1,
    name: 'Test',
    price: 100,
    image: 'test.png',
    rating: 4.5,
    isFavorite: false,
    description: 'desc',
    gallery: [],
    sizes: [],
    stockQuantity: 10,
  );

  test('should be a subclass of ProductDetailsEntity', () {
    expect(tProductDetailsModel, isA<ProductDetailsEntity>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is successful', () {
      final Map<String, dynamic> jsonMap = {
        "data": {
          "id": 1,
          "name": "Test Product",
          "price": "100.0",
          "main_image_url": "test.png",
          "rating": 4.5,
          "is_favorite": 1,
          "description": "description",
          "images": [
            {"id": 1, "image_url": "gallery1.png"}
          ],
          "sizes": [
            {"id": 1, "size": "XL", "stock_quantity": 5}
          ],
          "stock_quantity": 20
        }
      };

      final result = ProductDetailsModel.fromJson(jsonMap);

      expect(result.id, 1);
      expect(result.name, "Test Product");
      expect(result.isFavorite, true);
      expect(result.gallery.length, 1);
      expect(result.sizes.first.size, "XL");
      expect(result.stockQuantity, 20);
    });
  });
}
