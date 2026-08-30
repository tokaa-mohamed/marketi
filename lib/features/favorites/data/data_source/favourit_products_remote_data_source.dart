import 'package:dio/dio.dart';
import 'package:marketi/core/api/dio_helper.dart';
import '../models/favourit_products_model.dart';

class FavouritProductsRemoteDataSource {
  final DioHelper dioHelper;

  FavouritProductsRemoteDataSource(this.dioHelper);

  Future<List<FavouritProductsModel>> getFavouritProducts() async {
    final response = await dioHelper.getData(url: "favorites", withAuth: true);
    
    // Reach the nested list: response.data['data']['data']
    final List dynamicList = response.data['data']?['data'] ?? [];

    return dynamicList
        .map(
          (json) =>
              FavouritProductsModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }

  Future<Response> addFavorite(int productId) async {
    return await dioHelper.postData(
      url: "favorites",
      data: {"product_id": productId},
      withAuth: true,
    );
  }
}
