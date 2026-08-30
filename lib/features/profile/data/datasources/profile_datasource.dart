import 'package:marketi/features/profile/data/models/order_model.dart';
import 'package:marketi/features/profile/data/models/subscription_model.dart';
import 'package:marketi/features/profile/data/models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> getProfile();
  Future<UserProfileModel> updateProfile(UserProfileModel profile);
  Future<void> changePassword(String currentPassword, String newPassword);
  Future<List<OrderModel>> getOrders();
  Future<List<SubscriptionModel>> getSubscriptions();
  Future<void> createSupportTicket(String subject, String message);
}