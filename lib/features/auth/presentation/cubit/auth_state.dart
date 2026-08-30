import 'package:marketi/features/auth/domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}
class LoginSuccess extends AuthState {
  final UserEntity user;
  LoginSuccess(this.user);
}
class LoginFailure extends AuthState {
  final String errorMessage;
  LoginFailure(this.errorMessage);
}

class RegisterLoading extends AuthState {}
class RegisterSuccess extends AuthState {
  final UserEntity user;
  RegisterSuccess(this.user);
}
class RegisterFailure extends AuthState {
  final String errorMessage;
  RegisterFailure(this.errorMessage);
}