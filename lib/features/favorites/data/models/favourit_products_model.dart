import '../../../../core/utils/url_helper.dart';
import '../../domain/entities/favourit_products_entities.dart';

class FavouritProductsModel extends FavouritProductsEntities {
  final dynamic favoriteId;
  final int productId;
  final int rating_count;
  final String slug;
  final int stock_quantity;

  FavouritProductsModel({
    required super.name,
    required super.main_image,
    required super.price,
    required super.rating,
    required this.favoriteId,
    required this.productId,
    required this.rating_count,
    required this.slug,
    required this.stock_quantity,
  });

  factory FavouritProductsModel.fromJson(Map<String, dynamic> json) {
    final productData = json['product'] ?? json;
    final int pId = int.tryParse(productData['id']?.toString() ?? '0') ?? 0;
    
    return FavouritProductsModel(
      favoriteId: json['id'],
      productId: pId,
      name: productData['name']?.toString() ?? 'Unknown',
      main_image: UrlHelper.getFullImageUrl(productData['main_image_url'] ?? productData['main_image']),
      price: double.tryParse(productData['price']?.toString() ?? '0') ?? 0.0,
      rating: double.tryParse(productData['rating']?.toString() ?? '0') ?? 0.0,
      rating_count: productData['rating_count'] ?? 0,
      slug: productData['slug']?.toString() ?? '',
      stock_quantity:
          int.tryParse(productData['stock_quantity']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': favoriteId,
      'product_id': productId,
      'name': name,
      'price': price,
      'main_image': main_image,
      'rating': rating,
      'rating_count': rating_count,
      'slug': slug,
      'stock_quantity': stock_quantity,
    };
  }
}
