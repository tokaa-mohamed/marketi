import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final num price;
  final String image;
  final num rating;
  final bool isFavorite;
  final int? discount;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
    required this.isFavorite,
    this.discount,
  });

  @override
  List<Object?> get props => [id, name, price, image, rating, isFavorite, discount];
}
