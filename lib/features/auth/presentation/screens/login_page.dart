import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/constant/custom_button.dart';
import 'package:marketi/core/constant/custom_check_box.dart';
import 'package:marketi/core/constant/custom_svg_image.dart';
import 'package:marketi/core/constant/custom_textformfield.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/routing/app_router.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';
import 'package:marketi/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:marketi/features/auth/presentation/cubit/auth_state.dart';
import 'package:marketi/generated/assets.dart';

@RoutePage()
class LoginPage extends StatelessWidget implements AutoRouteWrapper {
  const LoginPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => getIt<AuthCubit>(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return const LoginBody();
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();

  final _identifierKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();

  bool _rememberMe = false;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login Successful!')),
              );
              context.router.replaceAll([const ProfileDrawerRoute()]);
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomButton(
                        data: 'Skip',
                        width: 55.w,
                        height: 44.h,
                        color: AppColors.white,
                        txtcolor: AppColors.primaryColor,
                        bordercolor: AppColors.primaryColor.withValues(
                          alpha: 0.3,
                        ),
                        borderRadius: 14.r,
                        fontSize: AppFonts.s14.sp,
                        onTap: () => context.router.replace(const MainRoute()),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Center(
                      child: Image.asset(
                        'assets/images/Logo_Sign_Up.png',
                        width: 272.w,
                        height: 232.h,
                      ),
                    ),
                    SizedBox(height: 40.h),

                    CustomTextformfeild(
                      formFieldKey: _identifierKey,
                      controller: _identifierController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Username or Email',
                      hintColor: AppColors.darkgrey,
                      prefixIcon: Assets.icons.emailIcon.path,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your username or email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),

                    CustomTextformfeild(
                      formFieldKey: _passwordKey,
                      controller: _passwordController,

                      keyboardType: TextInputType.visiblePassword,
                      hintText: '••••••••••••',
                      hintColor: AppColors.darkgrey,
                      isPassword: true,
                      prefixIcon: Assets.icons.passwordIcon.path,

                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomCheckBox(
                              check: _rememberMe,
                              onTap: () =>
                                  setState(() => _rememberMe = !_rememberMe),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Remember Me',
                              style: getRegularStyle(
                                fontSize: AppFonts.s12.sp,
                                color: AppColors.navy,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () =>
                              context.router.push(const ForgotPasswordRoute()),
                          child: Text(
                            'Forgot Password?',
                            style: getMediumStyle(
                              fontSize: AppFonts.s12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    state is LoginLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            data: 'Log In',
                            fontSize: AppFonts.s18.sp,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().login(
                                  identifier: _identifierController.text,
                                  password: _passwordController.text,
                                );
                              }
                            },
                          ),
                    SizedBox(height: 24.h),

                    Center(
                      child: Text(
                        'Or Continue With',
                        style: getRegularStyle(
                          fontSize: AppFonts.s12.sp,
                          height: 2.h,
                          color: AppColors.navy,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google Button
                        Container(
                          width: 44.w,
                          height: 44.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(22.r),
                            onTap: () {},
                            child: Center(
                              child: CustomSvgImage(
                                path: Assets.icons.googleIcon.path,
                                width: 44.w,
                                height: 44.h,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),

                        // Apple Button
                        Container(
                          width: 44.w,
                          height: 44.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(22.r),
                            onTap: () {},
                            child: Center(
                              child: CustomSvgImage(
                                path: Assets.icons.appleIcon.path,
                                width: 44.w,
                                height: 44.h,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),

                        // Facebook Button
                        Container(
                          width: 44.w,
                          height: 44.h,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.white,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(22.r),
                            onTap: () {},
                            child: Center(
                              child: CustomSvgImage(
                                path: Assets.icons.facebokIcon.path,
                                width: 44.w,
                                height: 44.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Are you new in Marketi? ',
                          style: getRegularStyle(
                            fontSize: AppFonts.s12.sp,
                            color: AppColors.navy,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              context.router.push(const RegisterRoute()),
                          child: Text(
                            'register?',
                            style: getBoldStyle(
                              fontSize: AppFonts.s12.sp,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
