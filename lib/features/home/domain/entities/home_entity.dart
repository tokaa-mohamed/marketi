import 'package:equatable/equatable.dart';
import '../../inner_views/categories/domain/entities/category_entity.dart';
import '../../inner_views/brands/domain/entities/brand_entity.dart';
import 'product_entity.dart';

class BannerEntity extends Equatable {
  final int id;
  final String image;

  const BannerEntity({required this.id, required this.image});

  @override
  List<Object?> get props => [id, image];
}

class HomeDataEntity extends Equatable {
  final List<BannerEntity> banners;
  final List<CategoryEntity> categories;
  final List<ProductEntity> popularProducts;
  final List<ProductEntity> bestForYou;
  final List<ProductEntity> buyAgain;
  final List<BrandEntity> brands;

  const HomeDataEntity({
    required this.banners,
    required this.categories,
    required this.popularProducts,
    required this.bestForYou,
    required this.buyAgain,
    required this.brands,
  });

  @override
  List<Object?> get props => [banners, categories, popularProducts, bestForYou, buyAgain, brands];
}
