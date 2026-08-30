import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/routing/app_router.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';
import 'package:marketi/features/auth/presentation/cubit/forget_password_cubit.dart';
import 'package:marketi/features/auth/presentation/cubit/forget_password_state.dart';
import 'package:marketi/generated/assets.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class VerifyOtpPage extends StatefulWidget {
  final String? targetDestination;

  const VerifyOtpPage({super.key, this.targetDestination});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<ForgotPasswordCubit>();
        if (widget.targetDestination != null) {
          cubit.currentIdentifier = widget.targetDestination!;
        }
        return cubit;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.2)),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: AppColors.primaryColor, size: 18),
              onPressed: () => context.router.maybePop(),
            ),
          ),
          title: Text(
            'Verification Code',
            style: getBoldStyle(
              color: AppColors.navy,
              fontSize: 18,
            ),
          ),
          centerTitle: false,
        ),
        body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is OtpVerifiedSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.green),
              );
              context.router.push(
                CreateNewPasswordRoute(phone: context.read<ForgotPasswordCubit>().currentIdentifier),
              );
            } else if (state is ForgotPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('OTP (Dev Only): ${state.message}'),
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 5),
                ),
              );
            } else if (state is ForgotPasswordError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error), backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            final String destination = widget.targetDestination ?? context.read<ForgotPasswordCubit>().currentIdentifier;
            final bool isEmail = destination.contains('@');

            final String imagePath = isEmail
                ? Assets.images.verificationCodeWithEmail.path
                : Assets.images.verificationCodeWithPhone.path;

            final defaultPinTheme = PinTheme(
              width: 48,
              height: 56,
              textStyle: getBoldStyle(
                color: AppColors.navy,
                fontSize: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.3)),
              ),
            );

            final focusedPinTheme = defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration?.copyWith(
                border: Border.all(color: AppColors.primaryColor, width: 1.5),
              ),
            );

            final bool isLoading = state is ForgotPasswordLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),

                  SvgPicture.asset(
                    imagePath,
                    width: 343,
                    height: 256,
                  ),

                  const SizedBox(height: 15),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: getRegularStyle(
                        color: AppColors.navy.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                      children: [
                        const TextSpan(text: 'Please enter the 6 digit code\nsent to: '),
                        TextSpan(
                          text: destination.isNotEmpty ? destination : 'You@gmail.com',
                          style: getBoldStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  Pinput(
                    length: 6,
                    controller: _otpController,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    showCursor: true,
                    onCompleted: (pin) {
                      context.read<ForgotPasswordCubit>().verifyOtp(pin);
                    },
                  ),

                  const SizedBox(height: 13),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_otpController.text.length == 6) {
                                context.read<ForgotPasswordCubit>().verifyOtp(_otpController.text);
                                context.router.push(
                                  CreateNewPasswordRoute(phone: context.read<ForgotPasswordCubit>().currentIdentifier),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please enter full 6-digit code'),
                                  ),
                                );
                              }
                            },
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Verify Code',
                              style: getBoldStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    '00:46',
                    style: getMediumStyle(
                      color: AppColors.navy,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 26),

                  GestureDetector(
                    onTap: isLoading
                        ? null
                        : () {
                            context.read<ForgotPasswordCubit>().sendOtp(destination);
                          },
                    child: Text(
                      'Resend Code',
                      style: getBoldStyle(
                        color: isLoading ? Colors.grey : AppColors.navy,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}