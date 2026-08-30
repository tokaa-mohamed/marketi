import '../../../../../../core/api/dio_helper.dart';
import '../../../../../../core/constant/app_constants.dart';
import '../../../../data/models/product_model.dart';

abstract class PopularProductsRemoteDataSource {
  Future<List<ProductModel>> getPopularProducts();
}

class PopularProductsRemoteDataSourceImpl implements PopularProductsRemoteDataSource {
  final DioHelper dioHelper;

  PopularProductsRemoteDataSourceImpl(this.dioHelper);

  @override
  Future<List<ProductModel>> getPopularProducts() async {
    final response = await dioHelper.getData(url: '${AppConstants.productsEndpoint}/popular');
    return (response.data['data']['data'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
