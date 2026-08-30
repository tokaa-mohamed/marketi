import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/security/security_helper.dart';

import '../../domain/usecase/get_cart_products_usecase.dart';
import '../../domain/usecase/add_products_to_cart.dart';
import 'cart_page_states.dart';

class CartPageCubit extends Cubit<CartPageStates> {
  final GetCartProductsUsecase getCartProductsUseCase;
  final AddProductsToCartUseCase addToCartUseCase;
  final AuthStorage authStorage;

  CartPageCubit(this.getCartProductsUseCase, this.addToCartUseCase, this.authStorage)
      : super(CartPageInitialState());

  Future<void> getCartProducts() async {
    emit(CartPageLoadingState());

    final result = await getCartProductsUseCase.callProductsInTheCart();

    result.fold(
      (failure) => emit(GetCartPageErrorState(error: failure.message)),
      (cartProducts) => emit(GetCartPageSuccessState(cartProductsModel: cartProducts)),
    );
  }

  Future<void> addToCart({required int productId, int quantity = 1, String size = "M"}) async {
    if (authStorage.token == null || authStorage.token!.isEmpty) {
      emit(AddToCartErrorState(message: "AuthRequired"));
      return;
    }

    emit(AddToCartLoadingState());

    final result = await addToCartUseCase(productId: productId, quantity: quantity, size: size);

    result.fold(
      (failure) => emit(AddToCartErrorState(message: failure.message)),
      (successMessage) {
        emit(AddToCartSuccessState(message: successMessage));
        getCartProducts(); // Refresh cart
      },
    );
  }
}
