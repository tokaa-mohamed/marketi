import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/constant/custom_button.dart';
import 'package:marketi/core/constant/custom_svg_image.dart';
import 'package:marketi/core/constant/custom_textformfield.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';
import 'package:marketi/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:marketi/features/auth/presentation/cubit/auth_state.dart';
import 'package:marketi/generated/assets.dart';

@RoutePage()
class RegisterPage extends StatefulWidget implements AutoRouteWrapper {
  const RegisterPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: this,
    );
  }

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _fullNameKey = GlobalKey<FormFieldState>();
  final _usernameKey = GlobalKey<FormFieldState>();
  final _phoneKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _confirmPasswordKey = GlobalKey<FormFieldState>();

  final String _countryPhoneCode = '+20';

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = AppColors.primaryColor.withValues(alpha: 0.4);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Registration Successful!')),
              );
            } else if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
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
                        icon: const Icon(Icons.arrow_back_ios_new),
                        width: 40.w,
                        height: 40.h,
                        color: AppColors.white,
                        bordercolor: AppColors.primaryColor.withValues(alpha: 0.2),
                        borderRadius: 20.r,
                        onTap: () => context.router.maybePop(),
                      ),
                    ),

                    Center(
                      child: Image.asset('assets/images/Logo_Sign_Up.png', width: 272.w, height: 232.h),
                    ),
                    SizedBox(height: 20.h),

                    CustomTextformfeild(
                      formFieldKey: _fullNameKey,
                      controller: _fullNameController,
                      labelText: 'Your Name',
                      labelcolor: AppColors.darkBlue,
                      hintText: 'Full Name',
                      hintColor: AppColors.grey,
                      borderColor: borderColor,
                      borderRadius: 12,
                      keyboardType: TextInputType.name,
                      prefixIcon: Assets.icons.nameIcon.path,             
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter your name' : null,
                    ),
                    SizedBox(height: 12.h),

                    CustomTextformfeild(
                      formFieldKey: _usernameKey,
                      controller: _usernameController,
                      labelText: 'Username',
                      labelcolor: AppColors.darkBlue,
                      hintText: 'Username',
                      hintColor: AppColors.grey,
                      borderColor: borderColor,
                      borderRadius: 12,
                      keyboardType: TextInputType.text,
                      prefixIcon: Assets.icons.userIcon.path,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter username' : null,
                    ),
                    SizedBox(height: 12.h),

                    CustomTextformfeild(
                      formFieldKey: _phoneKey,
                      controller: _phoneController,
                      labelText: 'Phone Number',
                      labelcolor: AppColors.darkBlue,
                      hintText: '1501142409',
                      hintColor: AppColors.grey,
                      borderColor: borderColor,
                      borderRadius: 12,
                      keyboardType: TextInputType.phone,
                      prefixIcon: Assets.icons.phoneIcon.path,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter phone number' : null,
                    ),
                    SizedBox(height: 12.h),

                    CustomTextformfeild(
                      formFieldKey: _emailKey,
                      controller: _emailController,
                      labelText: 'Email',
                      labelcolor: AppColors.darkBlue,
                      hintText: 'You@gmail.com',
                      hintColor: AppColors.grey,
                      borderColor: borderColor,
                      borderRadius: 12,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(Icons.email_outlined, color: AppColors.black, size: 20.sp),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter email' : null,
                    ),
                    SizedBox(height: 12.h),

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
                      validator: (value) =>
                          value == null || value.length < 6 ? 'Password too short' : null,
                    ),
                    SizedBox(height: 12.h),

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
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),

                    state is RegisterLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            data: 'Sign Up',
                            fontSize: AppFonts.s18.sp,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().register(
                                      name: _fullNameController.text,
                                      username: _usernameController.text,
                                      phone: _phoneController.text,
                                      countryPhoneCode: _countryPhoneCode,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      passwordConfirmation: _confirmPasswordController.text,
                                    );
                              }
                            },
                          ),
                    SizedBox(height: 20.h),

                    Center(
                      child: Text(
                        'Or Continue With',
                        style: getRegularStyle(fontSize: AppFonts.s12.sp, color: AppColors.navy),
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