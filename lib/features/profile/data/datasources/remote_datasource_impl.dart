import 'package:marketi/core/api/dio_helper.dart';
import 'package:marketi/core/constant/app_constants.dart';
import 'package:marketi/features/profile/data/datasources/profile_datasource.dart';
import 'package:marketi/features/profile/data/models/order_model.dart';
import 'package:marketi/features/profile/data/models/subscription_model.dart';
import 'package:marketi/features/profile/data/models/user_profile_model.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioHelper dioHelper;

  ProfileRemoteDataSourceImpl({required this.dioHelper});

  @override
  Future<UserProfileModel> getProfile() async {
    final response = await dioHelper.getData(
      url: AppConstants.profileEndpoint,
      withAuth: true,
      appendAuthParams: true,
    );
    return UserProfileModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<UserProfileModel> updateProfile(UserProfileModel profile) async {
    final response = await dioHelper.putDataWithAuth(
      url: AppConstants.profileEndpoint,
      data: profile.toJson(),
      withAuth: true,
    );
    return UserProfileModel.fromJson(response.data['data'] ?? response.data);
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) async {
    await dioHelper.putDataWithAuth(
      url: AppConstants.profilePasswordEndpoint,
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
      withAuth: true,
    );
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    final response = await dioHelper.getData(
      url: AppConstants.ordersEndpoint,
      withAuth: true,
      appendAuthParams: true,
    );

    final responseData = response.data['data'];
    final List list = (responseData is Map && responseData.containsKey('data'))
        ? responseData['data']
        : (responseData as List? ?? []);

    return list.map((e) => OrderModel.fromJson(e)).toList();
  }

  @override
  Future<List<SubscriptionModel>> getSubscriptions() async {
    final response = await dioHelper.getData(
      url: AppConstants.subscriptionsEndpoint,
      withAuth: true,
      appendAuthParams: true,
    );
    final List list = response.data['data'] ?? response.data;
    return list.map((e) => SubscriptionModel.fromJson(e)).toList();
  }

  @override
  Future<void> createSupportTicket(String subject, String message) async {
    await dioHelper.postData(
      url: AppConstants.supportTicketsEndpoint,
      data: {
        'subject': subject,
        'message': message,
      },
      withAuth: true,
      appendAuthParams: true,
    );
  }
}
