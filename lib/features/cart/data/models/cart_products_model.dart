import '../../domain/entities/cart_products_entities.dart';

class CartProductsModel extends CartProductsEntities {
  final String id;
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
    return CartProductsModel(
      name: json['name'],
      main_image: json['main_image'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      id: json['id'],
      rating_count: json['rating_count'],
      slug: json['slug'],
      stock_quantity: int.tryParse(json['stock_quantity'].toString()) ?? 0,
      main_image_url: json['main_image_url'],
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
