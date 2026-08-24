import '../../../../../../core/constant/app_constants.dart';
import '../../domain/entities/category_entity.dart';

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
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      image: rawImage.startsWith('http') ? rawImage : '${AppConstants.storageUrl}$rawImage',
      description: json['description']?.toString() ?? '',
      productsCount: json['products_count'] ?? 0,
    );
  }
}
