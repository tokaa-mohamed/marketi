import 'package:dio/dio.dart';
import 'package:marketi/core/api/dio_helper.dart';
import '../models/cart_products_model.dart';

class CartProductsRemoteDataSource {
  final DioHelper dioHelper;

  CartProductsRemoteDataSource(this.dioHelper);

  Future<List<CartProductsModel>> getCartProducts() async {
    final response = await dioHelper.getData(url: "cart", withAuth: true);
    
    // Support multiple response structures (nested under data.items or data.data)
    final data = response.data['data'];
    List dynamicList = [];
    
    if (data != null) {
      if (data is Map && data.containsKey('items')) {
        dynamicList = data['items'];
      } else if (data is Map && data.containsKey('data')) {
        dynamicList = data['data'];
      } else if (data is List) {
        dynamicList = data;
      }
    }

    return dynamicList
        .map((json) => CartProductsModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Response> addToCart({
    required int productId,
    int quantity = 1,
    String size = "M",
  }) async {
    return await dioHelper.postData(
      url: "cart/items",
      data: {
        "product_id": productId,
        "quantity": quantity,
        "size": size,
      },
      withAuth: true,
    );
  }
}
