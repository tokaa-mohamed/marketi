import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_popular_products_use_case.dart';
import 'popular_products_state.dart';

class PopularProductsCubit extends Cubit<PopularProductsState> {
  final GetPopularProductsUseCase getPopularProductsUseCase;

  PopularProductsCubit(this.getPopularProductsUseCase) : super(PopularProductsInitial());

  Future<void> getPopularProducts() async {
    emit(PopularProductsLoading());
    final result = await getPopularProductsUseCase();
    result.fold(
      (failure) => emit(PopularProductsError(failure.message)),
      (products) => emit(PopularProductsSuccess(products)),
    );
  }
}
