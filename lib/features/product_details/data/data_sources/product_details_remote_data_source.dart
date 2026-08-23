import '../../../../core/api/dio_helper.dart';
import '../../../../core/constant/app_constants.dart';
import '../models/product_details_model.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductDetailsModel> getProductDetails(int productId);
}

class ProductDetailsRemoteDataSourceImpl implements ProductDetailsRemoteDataSource {
  @override
  Future<ProductDetailsModel> getProductDetails(int productId) async {
    final response = await DioHelper.getData(
      url: AppConstants.productDetailsEndpoint(productId),
    );
    return ProductDetailsModel.fromJson(response.data);
  }
}
