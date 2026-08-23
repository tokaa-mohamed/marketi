import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/auth/domain/repos/auth_repo.dart';
import 'package:marketi/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    emit(LoginLoading());

    final result = await _authRepository.login(
      identifier: identifier,
      password: password,
    );

    result.fold(
      (errorMessage) {
        emit(LoginFailure(errorMessage));
      },
      (user) {
        emit(LoginSuccess(user));
      },
    );
  }

  Future<void> register({
    required String name,
    required String username,
    required String phone,
    required String countryPhoneCode,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(RegisterLoading());

    final result = await _authRepository.register(
      name: name,
      username: username,
      phone: phone,
      countryPhoneCode: countryPhoneCode,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    result.fold(
      (errorMessage) {
        emit(RegisterFailure(errorMessage));
      },
      (user) {
        emit(RegisterSuccess(user));
      },
    );
  }
}