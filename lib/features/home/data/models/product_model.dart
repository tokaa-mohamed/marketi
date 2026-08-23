import '../../../../core/constant/app_constants.dart';
import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.image,
    required super.rating,
    required super.isFavorite,
    super.discount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: _parseId(json['id']),
      name: json['name']?.toString() ?? '',
      price: _parseNum(json['price']),
      image: json['main_image_url']?.toString() ?? 
             (json['main_image'] != null ? '${AppConstants.storageUrl}${json['main_image']}' : ''),
      rating: _parseNum(json['rating']),

      isFavorite: json['is_favorite'] == true || json['is_favorite'] == 1,
      discount: json['discount'] != null ? _parseNum(json['discount']).toInt() : null,
    );
  }

  static int _parseId(dynamic id) {
    if (id is int) return id;
    if (id is String) return int.tryParse(id) ?? 0;
    return 0;
  }

  static num _parseNum(dynamic value) {
    if (value is num) return value;
    if (value is String) return num.tryParse(value) ?? 0;
    return 0;
  }
}
