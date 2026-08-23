import 'product_entity.dart';

class ProductsDummyData {
  static final products = List.generate(
    6,
    (index) => ProductEntity(
      id: index,
      name: 'Product Name',
      price: 100,
      image: '',
      rating: 4.5,
      isFavorite: false,
      discount: 10,
    ),
  );
}
