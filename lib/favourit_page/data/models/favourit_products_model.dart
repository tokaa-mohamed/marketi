import 'package:marketi/favourit_page/domain/entities/favourit_products_entities.dart';

class FavouritProductsModel extends FavouritProductsEntities {
  final String id;
  final int rating_count;
  final String slug;
  final int stock_quantity;
  FavouritProductsModel(
      {required super.name,
      required super.main_image,
      required super.price,
      required super.rating,
      required this.id,
      required this.rating_count,
      required this.slug,
      required this.stock_quantity});

  factory FavouritProductsModel.fromJson(Map<String, dynamic> json) {
    return FavouritProductsModel(
      name: json['name'],
      main_image: json['main_image'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      id: json['id'],
      rating_count: json['rating_count'],
      slug: json['slug'],
      stock_quantity: int.tryParse(json['stock_quantity'].toString()) ?? 0,
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
      'stock_quantity': stock_quantity
    };
  }
}
