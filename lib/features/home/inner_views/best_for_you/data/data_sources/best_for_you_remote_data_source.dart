import '../../../../../../core/api/dio_helper.dart';
import '../../../../../../core/constant/app_constants.dart';
import '../../../../data/models/product_model.dart';

abstract class BestForYouRemoteDataSource {
  Future<List<ProductModel>> getBestForYouProducts();
}

class BestForYouRemoteDataSourceImpl implements BestForYouRemoteDataSource {
  @override
  Future<List<ProductModel>> getBestForYouProducts() async {
    final response = await DioHelper.getData(url: '${AppConstants.productsEndpoint}/best-for-you');
    return (response.data['data']['data'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
