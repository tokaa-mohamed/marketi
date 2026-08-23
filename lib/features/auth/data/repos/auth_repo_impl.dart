import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:marketi/core/api/internet_connection_checker.dart';
import 'package:marketi/core/constant/app_constants.dart';
import 'package:marketi/features/auth/data/datasources/auth_data_source.dart';
import 'package:marketi/features/auth/data/model/user_model.dart';
import 'package:marketi/features/auth/domain/entities/user_entity.dart';
import 'package:marketi/features/auth/domain/repos/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  Future<Either<String, T>> _executeApiCall<T>({
    required Future<Response> Function() apiCall,
    required T Function(dynamic data) onSuccess,
  }) async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(AppConstants.noInternetMessage);
    }

    try {
      final response = await apiCall();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(onSuccess(response.data));
      } else {
        return left(response.data['message'] ?? AppConstants.serverErrorMessage);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return left(AppConstants.timeoutErrorMessage);
      }
      return left(e.response?.data['message'] ?? AppConstants.serverErrorMessage);
    } catch (e) {
      return left(AppConstants.unknownErrorMessage);
    }
  }

  @override
  Future<Either<String, UserEntity>> login({
    required String identifier,
    required String password,
  }) {
    return _executeApiCall<UserEntity>(
      apiCall: () => remoteDataSource.login(
        identifier: identifier,
        password: password,
      ),
      onSuccess: (data) => UserModel.fromJson(data),
    );
  }

  @override
  Future<Either<String, UserEntity>> register({
    required String name,
    required String username,
    required String phone,
    required String countryPhoneCode,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) {
    return _executeApiCall<UserEntity>(
      apiCall: () => remoteDataSource.register(
        name: name,
        username: username,
        phone: phone,
        countryPhoneCode: countryPhoneCode,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
      onSuccess: (data) => UserModel.fromJson(data),
    );
  }

  @override
  Future<Either<String, String>> forgotPassword({
    required String phone,
  }) {
    return _executeApiCall<String>(
      apiCall: () => remoteDataSource.forgotPassword(phone: phone),
      onSuccess: (data) => data['message'] ?? 'OTP Sent Successfully',
    );
  }

  @override
  Future<Either<String, String>> verifyOtp({
    required String phone,
    required String otp,
  }) {
    return _executeApiCall<String>(
      apiCall: () => remoteDataSource.verifyOtp(phone: phone, otp: otp),
      onSuccess: (data) => data['message'] ?? 'OTP Verified Successfully',
    );
  }

  @override
  Future<Either<String, String>> resetPassword({
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) {
    return _executeApiCall<String>(
      apiCall: () => remoteDataSource.resetPassword(
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirmation,
      ),
      onSuccess: (data) => data['message'] ?? 'Password Reset Successfully',
    );
  }
}