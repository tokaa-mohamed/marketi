import 'brand_entity.dart';

class BrandsDummyData {
  static final brands = List.generate(
    6,
    (index) => BrandEntity(
      id: index,
      name: 'Brand Name',
      image: '',
      productsCount: 10,
    ),
  );
}
