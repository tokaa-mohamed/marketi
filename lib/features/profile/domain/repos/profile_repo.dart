import 'package:dartz/dartz.dart';
import 'package:marketi/features/profile/data/models/order_model.dart';
import 'package:marketi/features/profile/data/models/subscription_model.dart';
import 'package:marketi/features/profile/domain/entities/user_profile.dart';

abstract class ProfileRepository {
  Future<Either<String, UserProfile>> getUserProfile();
  Future<Either<String, Unit>> updateProfile({required String name, required String city});
  Future<Either<String, Unit>> changePassword({required String currentPassword, required String newPassword});
  Future<Either<String, List<OrderModel>>> getOrders();
  Future<Either<String, List<SubscriptionModel>>> getSubscriptions();
  Future<Either<String, Unit>> createSupportTicket({required String subject, required String message});
}