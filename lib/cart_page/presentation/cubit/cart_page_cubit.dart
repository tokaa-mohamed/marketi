import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/cart_page/domain/usecase/get_cart_products_usecase.dart';
import 'package:marketi/cart_page/presentation/cubit/cart_page_states.dart';

class CartPageCubit extends Cubit<CartPageStates> {
  final GetCartProductsUsecase getCartProducts;
  CartPageCubit({required this.getCartProducts})
      : super(CartPageInitialState());
  Future<void> getFavouritProducts() async {
    emit(CartPageLoadingState());

    final result = await getCartProducts.callProductsInTheCart();

    result.fold(
      (failure) {
        emit(GetCartPageErrorState(error: failure.message));
      },
      (cartPageModel) {
        emit(GetCartPageSuccessState(cartProductsModel: cartPageModel));
      },
    );
  }
}
