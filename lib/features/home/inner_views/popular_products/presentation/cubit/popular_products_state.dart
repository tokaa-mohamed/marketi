import 'package:equatable/equatable.dart';
import '../../../../domain/entities/product_entity.dart';

abstract class PopularProductsState extends Equatable {
  const PopularProductsState();
  @override
  List<Object?> get props => [];
}

class PopularProductsInitial extends PopularProductsState {}

class PopularProductsLoading extends PopularProductsState {}

class PopularProductsSuccess extends PopularProductsState {
  final List<ProductEntity> products;
  const PopularProductsSuccess(this.products);
  @override
  List<Object?> get props => [products];
}

class PopularProductsError extends PopularProductsState {
  final String message;
  const PopularProductsError(this.message);
  @override
  List<Object?> get props => [message];
}
