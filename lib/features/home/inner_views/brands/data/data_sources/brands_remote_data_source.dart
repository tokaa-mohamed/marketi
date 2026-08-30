import '../../../../../../core/api/dio_helper.dart';
import '../../../../../../core/constant/app_constants.dart';
import '../../../../data/models/product_model.dart';
import '../models/brand_model.dart';

abstract class BrandsRemoteDataSource {
  Future<List<BrandModel>> getBrands();
  Future<List<ProductModel>> getBrandProducts(int brandId);
}

class BrandsRemoteDataSourceImpl implements BrandsRemoteDataSource {
  final DioHelper dioHelper;

  BrandsRemoteDataSourceImpl(this.dioHelper);

  @override
  Future<List<BrandModel>> getBrands() async {
    final response = await dioHelper.getData(url: AppConstants.brandsEndpoint);
    return (response.data['data'] as List)
        .map((e) => BrandModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<ProductModel>> getBrandProducts(int brandId) async {
    final response = await dioHelper.getData(
      url: '${AppConstants.brandsEndpoint}/$brandId/products',
    );
    return (response.data['data']['data'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
