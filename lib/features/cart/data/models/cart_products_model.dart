import '../../../../core/utils/url_helper.dart';
import '../../domain/entities/cart_products_entities.dart';

class CartProductsModel extends CartProductsEntities {
  final dynamic id;
  final int rating_count;
  final String slug;

  CartProductsModel({
    required super.name,
    required super.main_image,
    required super.price,
    required super.rating,
    required this.id,
    required this.rating_count,
    required this.slug,
    required super.stock_quantity,
    required super.main_image_url,
  });

  factory CartProductsModel.fromJson(Map<String, dynamic> json) {
    // API might return the product nested under a 'product' key
    final productData = json['product'] ?? json;
    
    final image = UrlHelper.getFullImageUrl(productData['main_image_url'] ?? productData['main_image']);

    return CartProductsModel(
      id: json['id'],
      name: productData['name']?.toString() ?? 'Unknown',
      main_image: image,
      price: double.tryParse(productData['price']?.toString() ?? '0') ?? 0.0,
      rating: double.tryParse(productData['rating']?.toString() ?? '0') ?? 0.0,
      rating_count: productData['rating_count'] ?? 0,
      slug: productData['slug']?.toString() ?? '',
      stock_quantity: int.tryParse(productData['stock_quantity']?.toString() ?? '0') ?? 0,
      main_image_url: UrlHelper.getFullImageUrl(productData['main_image_url']) ?? image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'main_image': main_image,
      'rating': rating,
      'rating_count': rating_count,
      'slug': slug,
      'stock_quantity': stock_quantity,
      'main_image_url': main_image_url,
    };
  }
}
