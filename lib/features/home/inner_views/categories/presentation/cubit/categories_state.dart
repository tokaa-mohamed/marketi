import 'package:equatable/equatable.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../domain/entities/category_entity.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesSuccess extends CategoriesState {
  final List<CategoryEntity> categories;
  const CategoriesSuccess(this.categories);
  @override
  List<Object?> get props => [categories];
}

class CategoriesError extends CategoriesState {
  final String message;
  const CategoriesError(this.message);
  @override
  List<Object?> get props => [message];
}

class CategoryProductsLoading extends CategoriesState {}

class CategoryProductsSuccess extends CategoriesState {
  final List<ProductEntity> products;
  const CategoryProductsSuccess(this.products);
  @override
  List<Object?> get props => [products];
}

class CategoryProductsError extends CategoriesState {
  final String message;
  const CategoryProductsError(this.message);
  @override
  List<Object?> get props => [message];
}
