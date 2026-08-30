import '../../../../../../core/api/dio_helper.dart';
import '../../../../../../core/constant/app_constants.dart';
import '../../../../data/models/product_model.dart';
import '../models/category_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getCategoryProducts(int categoryId);
}

class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final DioHelper dioHelper;

  CategoriesRemoteDataSourceImpl(this.dioHelper);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await dioHelper.getData(url: AppConstants.categoriesEndpoint);
    return (response.data['data'] as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<ProductModel>> getCategoryProducts(int categoryId) async {
    final response = await dioHelper.getData(
      url: AppConstants.categoryProductsEndpoint(categoryId),
    );
    // Based on response, products are under data.data
    return (response.data['data']['data'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
