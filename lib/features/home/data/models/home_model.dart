import '../../../../core/constant/app_constants.dart';
import '../../inner_views/categories/domain/entities/category_entity.dart';
import '../../domain/entities/home_entity.dart';
import '../../inner_views/brands/data/models/brand_model.dart';
import 'product_model.dart';

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.image,
    required super.description,
    required super.productsCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final rawImage = json['image']?.toString() ?? '';
    return CategoryModel(
      id: _parseId(json['id']),
      name: json['name']?.toString() ?? '',
      image: rawImage.startsWith('http') ? rawImage : '${AppConstants.storageUrl}$rawImage',
      description: json['description']?.toString() ?? '',
      productsCount: json['products_count'] ?? 0,
    );
  }
}

class BannerModel extends BannerEntity {
  const BannerModel({required super.id, required super.image});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: _parseId(json['id']),
      image: json['image']?.toString() ?? '',
    );
  }
}

int _parseId(dynamic id) {
  if (id is int) return id;
  if (id is String) return int.tryParse(id) ?? 0;
  return 0;
}

class HomeModel extends HomeDataEntity {
  const HomeModel({
    required super.banners,
    required super.categories,
    required super.popularProducts,
    required super.bestForYou,
    required super.buyAgain,
    required super.brands,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    
    return HomeModel(
      banners: data['banners'] is List 
          ? (data['banners'] as List).map((e) => BannerModel.fromJson(e)).toList() 
          : [],
      categories: data['categories'] is List 
          ? (data['categories'] as List).map((e) => CategoryModel.fromJson(e)).toList() 
          : [],
      popularProducts: data['popular_products'] is List 
          ? (data['popular_products'] as List).map((e) => ProductModel.fromJson(e)).toList() 
          : [],
      bestForYou: data['best_for_you'] is List 
          ? (data['best_for_you'] as List).map((e) => ProductModel.fromJson(e)).toList() 
          : [],
      buyAgain: data['buy_again'] is List 
          ? (data['buy_again'] as List).map((e) => ProductModel.fromJson(e)).toList() 
          : [],
      brands: data['brands'] is List 
          ? (data['brands'] as List).map((e) => BrandModel.fromJson(e)).toList() 
          : [],
    );
  }
}
