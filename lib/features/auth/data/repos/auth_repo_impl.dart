import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:marketi/core/api/internet_connection_checker.dart';
import 'package:marketi/core/constant/app_constants.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/save%20data/save_data.dart';
import 'package:marketi/core/security/security_helper.dart';
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
    required Future<T> Function(dynamic data) onSuccess,
  }) async {
    bool isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return left(AppConstants.noInternetMessage);
    }

    try {
      final response = await apiCall();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(await onSuccess(response.data));
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
      onSuccess: (data) async {
        final token = data['data']['token'];
        final userId = data['data']['user']['id']?.toString();

        if (token != null) {
await getIt<CacheHelper>().saveData(key: 'token', value: token);

          final authStorage = getIt<AuthStorage>();
          authStorage.token = token;
          if (userId != null) {
            authStorage.userId = userId;
          }
        }

        return UserModel.fromJson(data['data']['user']);
      },
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
      onSuccess: (data) async {
        final token = data['data']['token'];
        final userId = data['data']['user']['id']?.toString();

        if (token != null) {
await getIt<CacheHelper>().saveData(key: 'token', value: token);
          final authStorage = getIt<AuthStorage>();
          authStorage.token = token;
          if (userId != null) {
            authStorage.userId = userId;
          }
        }
        return UserModel.fromJson(data['data']['user']);
      },
    );
  }

  @override
  Future<Either<String, String>> forgotPassword({
    required String phone,
  }) {
    return _executeApiCall<String>(
      apiCall: () => remoteDataSource.forgotPassword(phone: phone),
      onSuccess: (data) async => data['message'] ?? 'OTP Sent Successfully',
    );
  }

  @override
  Future<Either<String, String>> verifyOtp({
    required String phone,
    required String otp,
  }) {
    return _executeApiCall<String>(
      apiCall: () => remoteDataSource.verifyOtp(phone: phone, otp: otp),
      onSuccess: (data) async => data['message'] ?? 'OTP Verified Successfully',
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
      onSuccess: (data) async => data['message'] ?? 'Password Reset Successfully',
    );
  }
}