import 'package:equatable/equatable.dart';
import '../../../../domain/entities/product_entity.dart';

abstract class BestForYouState extends Equatable {
  const BestForYouState();
  @override
  List<Object?> get props => [];
}

class BestForYouInitial extends BestForYouState {}

class BestForYouLoading extends BestForYouState {}

class BestForYouSuccess extends BestForYouState {
  final List<ProductEntity> products;
  const BestForYouSuccess(this.products);
  @override
  List<Object?> get props => [products];
}

class BestForYouError extends BestForYouState {
  final String message;
  const BestForYouError(this.message);
  @override
  List<Object?> get props => [message];
}
