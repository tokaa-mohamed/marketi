import 'package:equatable/equatable.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../domain/entities/brand_entity.dart';

abstract class BrandsState extends Equatable {
  const BrandsState();
  @override
  List<Object?> get props => [];
}

class BrandsInitial extends BrandsState {}

class BrandsLoading extends BrandsState {}

class BrandsSuccess extends BrandsState {
  final List<BrandEntity> brands;
  const BrandsSuccess(this.brands);
  @override
  List<Object?> get props => [brands];
}

class BrandsError extends BrandsState {
  final String message;
  const BrandsError(this.message);
  @override
  List<Object?> get props => [message];
}

class BrandProductsLoading extends BrandsState {}

class BrandProductsSuccess extends BrandsState {
  final List<ProductEntity> products;
  const BrandProductsSuccess(this.products);
  @override
  List<Object?> get props => [products];
}

class BrandProductsError extends BrandsState {
  final String message;
  const BrandProductsError(this.message);
  @override
  List<Object?> get props => [message];
}
