import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_brands_use_case.dart';
import '../../domain/use_cases/get_brand_products_use_case.dart';
import 'brands_state.dart';

class BrandsCubit extends Cubit<BrandsState> {
  final GetBrandsUseCase getBrandsUseCase;
  final GetBrandProductsUseCase getBrandProductsUseCase;

  BrandsCubit(this.getBrandsUseCase, this.getBrandProductsUseCase) : super(BrandsInitial());

  Future<void> getBrands() async {
    emit(BrandsLoading());
    final result = await getBrandsUseCase();
    result.fold(
      (failure) => emit(BrandsError(failure.message)),
      (brands) => emit(BrandsSuccess(brands)),
    );
  }

  Future<void> getBrandProducts(int brandId) async {
    emit(BrandProductsLoading());
    final result = await getBrandProductsUseCase(brandId);
    result.fold(
      (failure) => emit(BrandProductsError(failure.message)),
      (products) => emit(BrandProductsSuccess(products)),
    );
  }
}
