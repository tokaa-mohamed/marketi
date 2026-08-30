import 'package:marketi/core/api/dio_helper.dart';

import '../models/cart_products_model.dart';

class CartProductsRemoteDataSource {
  Future<List<CartProductsModel>> getCartProducts() async {
    final response = await DioHelper.getData(url: "cart", withAuth: true);
    // استخراج القائمة القادمة في الـ Response
    final List dynamicList = response.data['data'] ?? response.data;

    // تحويل الـ JSON إلى Models
    return dynamicList
        .map((json) => CartProductsModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
