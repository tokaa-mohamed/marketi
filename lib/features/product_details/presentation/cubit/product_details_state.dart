import 'package:equatable/equatable.dart';
import '../../domain/entities/product_details_entity.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();
  @override
  List<Object?> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccess extends ProductDetailsState {
  final ProductDetailsEntity product;
  const ProductDetailsSuccess(this.product);
  @override
  List<Object?> get props => [product];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;
  const ProductDetailsError(this.message);
  @override
  List<Object?> get props => [message];
}
