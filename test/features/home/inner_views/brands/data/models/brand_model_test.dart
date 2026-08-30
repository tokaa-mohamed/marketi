import 'package:flutter_test/flutter_test.dart';
import 'package:marketi/features/home/inner_views/brands/data/models/brand_model.dart';
import 'package:marketi/features/home/inner_views/brands/domain/entities/brand_entity.dart';

void main() {
  const tBrandModel = BrandModel(
    id: 1,
    name: 'Test Brand',
    image: 'test.png',
    productsCount: 10,
  );

  test('should be a subclass of BrandEntity', () {
    expect(tBrandModel, isA<BrandEntity>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is successful', () {
      final Map<String, dynamic> jsonMap = {
        "id": 1,
        "name": "Test Brand",
        "logo": "brand.png",
        "products_count": 10
      };

      final result = BrandModel.fromJson(jsonMap);

      expect(result.id, 1);
      expect(result.name, "Test Brand");
      expect(result.productsCount, 10);
      expect(result.image, contains("brand.png"));
    });
  });
}
