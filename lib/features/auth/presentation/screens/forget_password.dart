import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/routing/app_router.gr.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';
import 'package:marketi/features/auth/presentation/cubit/forget_password_cubit.dart';
import 'package:marketi/features/auth/presentation/cubit/forget_password_state.dart';
import 'package:marketi/generated/assets.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordScreen> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForgotPasswordCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.blue, size: 18),
              onPressed: () => context.router.maybePop(),
            ),
          ),
          title: Text(
            'Forgot Password',
            style: getMediumStyle(
              fontSize: AppFonts.s16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.navy,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordSuccess) {


ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Response: ${state.message}'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 10), 
        
      ),
    );
              context.router.push(
                VerifyOtpRoute(targetDestination: _inputController.text),
              );
            } else if (state is ForgotPasswordError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<ForgotPasswordCubit>();
            final isEmail = cubit.isEmailMethod;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  SvgPicture.asset(
                    isEmail
                        ? Assets.images.forgotPasswordWithEmail.path
                        : Assets.images.forgotPasswordWithPhone.path,
                    height: 343,
                    width: 256,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    isEmail
                        ? 'Please enter your email address to receive a verification code'
                        : 'Please enter your phone number to receive a verification code',
                    textAlign: TextAlign.center,
                    style: getMediumStyle(
                      fontSize: AppFonts.s16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.navy,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      isEmail ? 'Email' : 'Phone Number',
                      style: getMediumStyle(
                        fontSize: AppFonts.s12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  TextFormField(
                    controller: _inputController,
                    keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: isEmail
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                Assets.icons.emailIcon.path,
                                width: 20,
                                height: 20,
                              ),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 12),
                                SvgPicture.asset(
                                  Assets.icons.phoneIcon.path,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 4),
                                SvgPicture.asset(
                                  Assets.icons.arrowIcon.path,
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(width: 4),
                              ],
                            ),
                      hintText: isEmail ? 'You@gmail.com' : '+20 1501142409',
                      hintStyle: getRegularStyle(
                        fontSize: AppFonts.s12.sp,
                        color: AppColors.darkgrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue.shade100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue.shade100),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      onPressed: state is ForgotPasswordLoading
                          ? null
                          : () => cubit.sendOtp(_inputController.text),
                      child: state is ForgotPasswordLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Send Code',
                              style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () => cubit.toggleAuthMethod(),
                    child: Text(
                      isEmail ? 'Try Another Way (Use Phone)' : 'Try Another Way',
                      style: getMediumStyle(
                        fontSize: AppFonts.s16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}