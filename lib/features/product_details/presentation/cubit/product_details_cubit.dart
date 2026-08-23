import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_product_details_use_case.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailsCubit(this.getProductDetailsUseCase) : super(ProductDetailsInitial());

  Future<void> getProductDetails(int productId) async {
    emit(ProductDetailsLoading());
    final result = await getProductDetailsUseCase(productId);
    result.fold(
      (failure) => emit(ProductDetailsError(failure.message)),
      (product) => emit(ProductDetailsSuccess(product)),
    );
  }
}
