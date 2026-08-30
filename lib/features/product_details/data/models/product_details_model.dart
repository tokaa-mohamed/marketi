import '../../../../core/utils/url_helper.dart';
import '../../domain/entities/product_details_entity.dart';

class ProductImageModel extends ProductImageEntity {
  const ProductImageModel({required super.id, required super.image});

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      id: json['id'] ?? 0,
      image: UrlHelper.getFullImageUrl(json['image_url'] ?? json['image']),
    );
  }
}

class ProductSizeModel extends ProductSizeEntity {
  const ProductSizeModel({
    required super.id,
    required super.size,
    required super.stockQuantity,
  });

  factory ProductSizeModel.fromJson(Map<String, dynamic> json) {
    return ProductSizeModel(
      id: json['id'] ?? 0,
      size: json['size']?.toString() ?? '',
      stockQuantity: json['stock_quantity'] ?? 0,
    );
  }
}

class ProductDetailsModel extends ProductDetailsEntity {
  const ProductDetailsModel({
    required super.id,
    required super.name,
    required super.price,
    required super.image,
    required super.rating,
    required super.isFavorite,
    super.discount,
    required super.description,
    required super.gallery,
    required super.sizes,
    required super.stockQuantity,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;

    return ProductDetailsModel(
      id: _parseId(data['id']),
      name: data['name']?.toString() ?? '',
      price: _parseNum(data['price']),
      image: UrlHelper.getFullImageUrl(data['main_image_url'] ?? data['main_image']),
      rating: _parseNum(data['rating']),
      isFavorite: data['is_favorite'] == true || data['is_favorite'] == 1,
      discount:
          data['discount'] != null ? _parseNum(data['discount']).toInt() : null,
      description: data['description']?.toString() ?? '',
      gallery:
          (data['images'] as List?)
              ?.map((e) => ProductImageModel.fromJson(e))
              .toList() ??
          [],
      sizes:
          (data['sizes'] as List?)
              ?.map((e) => ProductSizeModel.fromJson(e))
              .toList() ??
          [],
      stockQuantity: data['stock_quantity'] ?? 0,
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
