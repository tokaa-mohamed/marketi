import 'package:dartz/dartz.dart';
import 'package:marketi/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, UserEntity>> login({
    required String identifier,
    required String password,
  });

  Future<Either<String, UserEntity>> register({
    required String name,
    required String username,
    required String phone,
    required String countryPhoneCode,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<String, String>> forgotPassword({
    required String phone,
  });

  Future<Either<String, String>> verifyOtp({
    required String phone,
    required String otp,
  });

  Future<Either<String, String>> resetPassword({
    required String phone,
    required String password,
    required String passwordConfirmation,
  });


  Future<bool> checkUserLoggedIn();
}