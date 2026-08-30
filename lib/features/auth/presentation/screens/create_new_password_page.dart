import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/constant/custom_button.dart';
import 'package:marketi/core/constant/custom_svg_image.dart';
import 'package:marketi/core/constant/custom_textformfield.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/routing/app_router.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';
import 'package:marketi/features/auth/presentation/cubit/forget_password_cubit.dart';
import 'package:marketi/features/auth/presentation/cubit/forget_password_state.dart';
import 'package:marketi/generated/assets.dart';

@RoutePage()
class CreateNewPasswordPage extends StatefulWidget {
  final String phone;

  const CreateNewPasswordPage({super.key, required this.phone});

  @override
  State<CreateNewPasswordPage> createState() =>
      _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _passwordKey = GlobalKey<FormFieldState>();
  final _confirmPasswordKey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = AppColors.primaryColor.withValues(alpha: 0.4);

    return BlocProvider(
      create: (context) {
        final cubit = getIt<ForgotPasswordCubit>();
        cubit.currentIdentifier = widget.phone;

        return cubit;
      },
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            context.router.push(const PasswordSuccessRoute());
          } else if (state is ForgotPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                        width: 40.w,
                        height: 40.h,
                        color: AppColors.white,
                        bordercolor: AppColors.primaryColor.withValues(alpha: 0.2),
                        borderRadius: 20.r,
                        onTap: () => context.router.maybePop(),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Center(
                      child: CustomSvgImage(
                        path: Assets.images.createNewPassword.path,
                        width: 343.w,
                        height: 256.h,
                      ),
                    ),

                    SizedBox(height: 24.h),

                    Center(
                      child: Text(
                        'New password must be\ndifferent from last password',
                        textAlign: TextAlign.center,
                        style: getMediumStyle(
                          color: AppColors.navy.withValues(alpha: 0.7),
                          fontSize: AppFonts.s14.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    CustomTextformfeild(
                      formFieldKey: _passwordKey,
                      controller: _passwordController,
                      labelText: 'Password',
                      labelcolor: AppColors.darkBlue,
                      hintText: '••••••••••••',
                      hintColor: AppColors.grey,
                      borderColor: borderColor,
                      borderRadius: 12,
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: Assets.icons.passwordIcon.path,
                      validator: (value) => value == null || value.length < 6
                          ? 'Password too short'
                          : null,
                    ),

                    SizedBox(height: 16.h),

                    CustomTextformfeild(
                      formFieldKey: _confirmPasswordKey,
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      labelcolor: AppColors.darkBlue,
                      hintText: '••••••••••••',
                      hintColor: AppColors.grey,
                      borderColor: borderColor,
                      borderRadius: 12,
                      isPassword: true,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: Assets.icons.passwordIcon.path,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 32.h),

                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder: (context, state) {
                        final isLoading = state is ForgotPasswordLoading;

                        return CustomButton(
                          data: isLoading ? 'Saving...' : 'Save Password',
                          fontSize: AppFonts.s18.sp,
                          onTap: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<ForgotPasswordCubit>()
                                        .resetPassword(
                                          _passwordController.text,
                                          _confirmPasswordController.text,
                                        );
                                  }
                                },
                        );
                      },
                    ),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}