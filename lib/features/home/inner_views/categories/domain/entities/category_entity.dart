import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final String description;
  final int productsCount;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.productsCount,
  });

  @override
  List<Object?> get props => [id, name, image, description, productsCount];
}
