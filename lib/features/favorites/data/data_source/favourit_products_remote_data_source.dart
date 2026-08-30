import 'package:marketi/core/api/dio_helper.dart';
import '../models/favourit_products_model.dart';

class FavouritProductsRemoteDataSource {
  final DioHelper dioHelper;

  FavouritProductsRemoteDataSource(this.dioHelper);

  Future<List<FavouritProductsModel>> getFavouritProducts() async {
    final response = await dioHelper.getData(url: "favorites", withAuth: true);
    // استخراج القائمة القادمة في الـ Response
    final List dynamicList = response.data['data'] ?? response.data;

    // تحويل الـ JSON إلى Models
    return dynamicList
        .map(
          (json) =>
              FavouritProductsModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }
}
