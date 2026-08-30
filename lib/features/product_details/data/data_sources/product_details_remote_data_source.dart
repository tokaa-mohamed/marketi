import '../../../../core/api/dio_helper.dart';
import '../../../../core/constant/app_constants.dart';
import '../models/product_details_model.dart';

abstract class ProductDetailsRemoteDataSource {
  Future<ProductDetailsModel> getProductDetails(int productId);
}

class ProductDetailsRemoteDataSourceImpl implements ProductDetailsRemoteDataSource {
  final DioHelper dioHelper;

  ProductDetailsRemoteDataSourceImpl(this.dioHelper);

  @override
  Future<ProductDetailsModel> getProductDetails(int productId) async {
    final response = await dioHelper.getData(
      url: AppConstants.productDetailsEndpoint(productId),
    );
    return ProductDetailsModel.fromJson(response.data);
  }
}
