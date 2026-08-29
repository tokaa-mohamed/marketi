import 'package:marketi/cart_page/domain/entities/cart_products_entities.dart';

class CartPageStates {}

class CartPageInitialState extends CartPageStates {}

class CartPageLoadingState extends CartPageStates {}

class GetCartPageSuccessState extends CartPageStates {
  final List<CartProductsEntities> cartProductsModel;
  GetCartPageSuccessState({required this.cartProductsModel});
}

class GetCartPageErrorState extends CartPageStates {
  final String error;
  GetCartPageErrorState({required this.error});
}
