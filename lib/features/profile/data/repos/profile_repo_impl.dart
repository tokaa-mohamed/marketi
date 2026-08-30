import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:marketi/core/api/internet_connection_checker.dart';
import 'package:marketi/core/constant/app_constants.dart';
import 'package:marketi/features/profile/data/datasources/profile_datasource.dart';
import 'package:marketi/features/profile/data/datasources/remote_datasource_impl.dart';
import 'package:marketi/features/profile/data/models/order_model.dart';
import 'package:marketi/features/profile/data/models/subscription_model.dart';
import 'package:marketi/features/profile/data/models/user_profile_model.dart';
import 'package:marketi/features/profile/domain/entities/user_profile.dart';
import 'package:marketi/features/profile/domain/repos/profile_repo.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<String, UserProfile>> getUserProfile() async {
    if (!await networkInfo.isConnected) {
      return const Left(AppConstants.noInternetMessage);
    }

    try {
      final userModel = await remoteDataSource.getProfile();
      return Right(userModel);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? AppConstants.serverErrorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> updateProfile({
    required String name,
    required String city,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(AppConstants.noInternetMessage);
    }

    try {
      final model = UserProfileModel(name: name, city: city);
      await remoteDataSource.updateProfile(model);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? AppConstants.serverErrorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(AppConstants.noInternetMessage);
    }

    try {
      await remoteDataSource.changePassword(currentPassword, newPassword);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? AppConstants.serverErrorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<OrderModel>>> getOrders() async {
    if (!await networkInfo.isConnected) {
      return const Left(AppConstants.noInternetMessage);
    }

    try {
      final orders = await remoteDataSource.getOrders();
      return Right(orders);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? AppConstants.serverErrorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<SubscriptionModel>>> getSubscriptions() async {
    if (!await networkInfo.isConnected) {
      return const Left(AppConstants.noInternetMessage);
    }

    try {
      final subscriptions = await remoteDataSource.getSubscriptions();
      return Right(subscriptions);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? AppConstants.serverErrorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> createSupportTicket({
    required String subject,
    required String message,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(AppConstants.noInternetMessage);
    }

    try {
      await remoteDataSource.createSupportTicket(subject, message);
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? AppConstants.serverErrorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}