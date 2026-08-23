import 'package:equatable/equatable.dart';

import '../../../home/domain/entities/product_entity.dart';

class ProductImageEntity extends Equatable {
  final int id;
  final String image;

  const ProductImageEntity({required this.id, required this.image});

  @override
  List<Object?> get props => [id, image];
}

class ProductSizeEntity extends Equatable {
  final int id;
  final String size;
  final int stockQuantity;

  const ProductSizeEntity({
    required this.id,
    required this.size,
    required this.stockQuantity,

  });

  @override
  List<Object?> get props => [id, size, stockQuantity];
}

class ProductDetailsEntity extends ProductEntity {
  final String description;
  final List<ProductImageEntity> gallery;
  final List<ProductSizeEntity> sizes;
  final int stockQuantity;

  const ProductDetailsEntity({
    required super.id,
    required super.name,
    required super.price,
    required super.image,
    required super.rating,
    required super.isFavorite,
    super.discount,
    required this.description,
    required this.gallery,
    required this.sizes,
    required this.stockQuantity,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    description,
    gallery,
    sizes,
    stockQuantity,
  ];
}
