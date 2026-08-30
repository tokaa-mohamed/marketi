import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_favourit_products.dart';
import 'favourit_products_states.dart';

class FavouritProductsCubit extends Cubit<FavouritProductsStates> {
  final GetFavouritProductsUseCase getFavouritProductsUseCase;

  FavouritProductsCubit(this.getFavouritProductsUseCase)
    : super(FavouritProductsInitialState());

  Future<void> getFavouritProducts() async {
    emit(GetFavouritProductsLoadingState());

    final result = await getFavouritProductsUseCase.callFavouritProducts();

    result.fold(
      (failure) {
        emit(FailGetFavouritProducts(message: failure.message));
      },
      (favouritProducts) {
        emit(
          GetFavouritPProductsSuccessfulState(
            favouritProducts: favouritProducts,
          ),
        );
      },
    );
  }
}
