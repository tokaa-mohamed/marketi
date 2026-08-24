import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_categories_use_case.dart';
import '../../domain/use_cases/get_category_products_use_case.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetCategoryProductsUseCase getCategoryProductsUseCase;

  CategoriesCubit(
    this.getCategoriesUseCase,
    this.getCategoryProductsUseCase,
  ) : super(CategoriesInitial());

  Future<void> getCategories() async {
    emit(CategoriesLoading());
    final result = await getCategoriesUseCase();
    result.fold(
      (failure) => emit(CategoriesError(failure.message)),
      (categories) => emit(CategoriesSuccess(categories)),
    );
  }

  Future<void> getCategoryProducts(int categoryId) async {
    emit(CategoryProductsLoading());
    final result = await getCategoryProductsUseCase(categoryId);
    result.fold(
      (failure) => emit(CategoryProductsError(failure.message)),
      (products) => emit(CategoryProductsSuccess(products)),
    );
  }
}
