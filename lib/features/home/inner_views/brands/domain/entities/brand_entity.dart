import 'package:equatable/equatable.dart';

class BrandEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final String? description;
  final int productsCount;

  const BrandEntity({
    required this.id,
    required this.name,
    required this.image,
    this.description,
    required this.productsCount,
  });

  @override
  List<Object?> get props => [id, name, image, description, productsCount];
}
