import 'product_details_entity.dart';

class ProductDetailsDummyData {
  static final product = ProductDetailsEntity(
    id: 1,
    name: 'Product Name',
    price: 345,
    image: '',
    rating: 4.0,
    isFavorite: false,
    description: 'Fear no leaks with new and improved Pampers Swaddlers. Pampers Swaddlers helps prevent up to 100% of leaks, even blowouts Plus, Dual Leak-Guard Barriers at the legs help protect where leaks happen most With Swaddlers, you can rest assured that you have superior leak protection* while keeping baby\'s skin healthy',
    gallery: [
      ProductImageEntity(id: 1, image: ''),
      ProductImageEntity(id: 2, image: ''),
    ],
    sizes: [
      ProductSizeEntity(id: 1, size: '3', stockQuantity: 10),
      ProductSizeEntity(id: 2, size: '2', stockQuantity: 10),
      ProductSizeEntity(id: 3, size: '4', stockQuantity: 10),
    ],
    stockQuantity: 100,
  );
}
