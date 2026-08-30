import '../../../../core/api/dio_helper.dart';
import '../../../../core/constant/app_constants.dart';
import '../models/home_model.dart';

abstract class HomeRemoteDataSource {
  Future<HomeModel> getHomeData();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioHelper dioHelper;

  HomeRemoteDataSourceImpl(this.dioHelper);

  @override
  Future<HomeModel> getHomeData() async {
    final response = await dioHelper.getData(url: AppConstants.homeEndpoint);
    return HomeModel.fromJson(response.data);
  }
}
