import '../../../../../../core/constant/app_constants.dart';
import '../../domain/entities/brand_entity.dart';

class BrandModel extends BrandEntity {
  const BrandModel({
    required super.id,
    required super.name,
    required super.image,
    super.description,
    required super.productsCount,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    final rawLogo = json['logo']?.toString() ?? '';
    return BrandModel(
      id: _parseId(json['id']),
      name: json['name']?.toString() ?? '',
      image: rawLogo.startsWith('http') ? rawLogo : '${AppConstants.storageUrl}$rawLogo',
      description: json['description']?.toString(),
      productsCount: json['products_count'] ?? 0,
    );
  }

  static int _parseId(dynamic id) {
    if (id is int) return id;
    if (id is String) return int.tryParse(id) ?? 0;
    return 0;
  }
}
