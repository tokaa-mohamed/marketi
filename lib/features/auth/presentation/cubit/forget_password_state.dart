
abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}
class ForgotPasswordLoading extends ForgotPasswordState {}
class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;
  ForgotPasswordSuccess(this.message);
}
class OtpVerifiedSuccess extends ForgotPasswordState {
  final String message;
  OtpVerifiedSuccess(this.message);
}
class ResetPasswordSuccess extends ForgotPasswordState {
  final String message;
  ResetPasswordSuccess(this.message);
}
class ForgotPasswordError extends ForgotPasswordState {
  final String error;
  ForgotPasswordError(this.error);
}