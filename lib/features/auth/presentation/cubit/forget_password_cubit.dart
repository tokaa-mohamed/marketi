import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/features/auth/domain/repos/auth_repo.dart';
import 'package:marketi/features/auth/presentation/cubit/forget_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository authRepository;

  ForgotPasswordCubit(this.authRepository) : super(ForgotPasswordInitial());

  bool isEmailMethod = false;
  
  String currentIdentifier = '';

  void toggleAuthMethod() {
    isEmailMethod = !isEmailMethod;
    emit(ForgotPasswordInitial());
  }

  Future<void> sendOtp(String identifier) async {
    if (identifier.trim().isEmpty) {
      emit(ForgotPasswordError("Please enter your input"));
      return;
    }
    currentIdentifier = identifier.trim();
    emit(ForgotPasswordLoading());

    final result = await authRepository.forgotPassword(phone: currentIdentifier);
    result.fold(
      (error) => emit(ForgotPasswordError(error)),
      (message) => emit(ForgotPasswordSuccess(message)),
    );
  }

  Future<void> verifyOtp(String otp) async {
    if (otp.length < 4) {
      emit(ForgotPasswordError("Please enter complete OTP"));
      return;
    }
    emit(ForgotPasswordLoading());

    final result = await authRepository.verifyOtp(phone: currentIdentifier, otp: otp);
    result.fold(
      (error) => emit(ForgotPasswordError(error)),
      (message) => emit(OtpVerifiedSuccess(message)),
    );
  }

  Future<void> resetPassword(String newPassword, String confirmPassword) async {
    if (newPassword != confirmPassword) {
      emit(ForgotPasswordError("Passwords do not match"));
      return;
    }
    emit(ForgotPasswordLoading());

    final result = await authRepository.resetPassword(
      phone: currentIdentifier,
      password: newPassword,
      passwordConfirmation: confirmPassword,
    );
    result.fold(
      (error) => emit(ForgotPasswordError(error)),
      (message) => emit(ResetPasswordSuccess(message)),
    );
  }
}