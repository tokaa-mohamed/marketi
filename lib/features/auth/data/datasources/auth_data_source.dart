import 'package:dio/dio.dart';
import 'package:marketi/core/api/dio_helper.dart';
import 'package:marketi/core/constant/app_constants.dart';

abstract class AuthRemoteDataSource {
  Future<Response> login({
    required String identifier,
    required String password,
  });

  Future<Response> register({
    required String name,
    required String username,
    required String phone,
    required String countryPhoneCode,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<Response> forgotPassword({
    required String phone,
  });

  Future<Response> verifyOtp({
    required String phone,
    required String otp,
  });

  Future<Response> resetPassword({
    required String phone,
    required String password,
    required String passwordConfirmation,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioHelper dioHelper;

  AuthRemoteDataSourceImpl(this.dioHelper);

  @override
  Future<Response> login({
    required String identifier,
    required String password,
  }) async {
    return await dioHelper.postData(
      url: AppConstants.loginEndpoint,
      data: {
        'identifier': identifier,
        'password': password,
      },
    );
  }

  @override
  Future<Response> register({
    required String name,
    required String username,
    required String phone,
    required String countryPhoneCode,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await dioHelper.postData(
      url: AppConstants.registerEndpoint,
      data: {
        'name': name,
        'username': username,
        'phone': phone,
        'country_phone_code': countryPhoneCode,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
  }

  @override
  Future<Response> forgotPassword({required String phone}) async {
    return await dioHelper.postData(
      url: AppConstants.forgotPasswordEndpoint,
      data: {
        'phone': phone,
      },
    );
  }

  @override
  Future<Response> verifyOtp({
    required String phone,
    required String otp,
  }) async {
    return await dioHelper.postData(
      url: AppConstants.verifyOtpEndpoint,
      data: {
        'phone': phone,
        'otp': otp,
      },
    );
  }

  @override
  Future<Response> resetPassword({
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await dioHelper.postData(
      url: AppConstants.resetPasswordEndpoint,
      data: {
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
  }
}
