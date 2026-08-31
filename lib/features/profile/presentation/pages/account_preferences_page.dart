import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/constant/app_constants.dart';
import 'package:marketi/core/constant/custom_button.dart';
import 'package:marketi/core/constant/custom_textformfield.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/routing/app_router.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_state.dart';

@RoutePage()
class AccountPreferencesPage extends StatefulWidget {
  const AccountPreferencesPage({super.key});

  @override
  State<AccountPreferencesPage> createState() => _AccountPreferencesPageState();
}

class _AccountPreferencesPageState extends State<AccountPreferencesPage> {
  // Controllers and Keys for Edit Profile
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _nameKey = GlobalKey<FormFieldState>();
  final _cityKey = GlobalKey<FormFieldState>();
  final _editProfileFormKey = GlobalKey<FormState>();

  // Controllers and Keys for Change Password
  final _currentPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _currentPassKey = GlobalKey<FormFieldState>();
  final _newPassKey = GlobalKey<FormFieldState>();
  final _changePasswordFormKey = GlobalKey<FormState>();

  bool _isEditingProfile = false;
  bool _isChangingPassword = false;

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _currentPassController.dispose();
    _newPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileCubit>(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            setState(() => _isEditingProfile = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully!')),
            );
          } else if (state is ProfilePasswordChangedSuccess) {
            setState(() => _isChangingPassword = false);
            _currentPassController.clear();
            _newPassController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password changed successfully!')),
            );
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Builder(
          builder: (context) {
            final profileCubit = context.read<ProfileCubit>();
            return Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                title: Text(
                  'Account Preferences',
                  style: getBoldStyle(fontSize: AppFonts.s18.sp, color: AppColors.navy),
                ),
                backgroundColor: AppColors.white,
                elevation: 0,
                iconTheme: const IconThemeData(color: AppColors.navy),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    if (context.router.canPop()) {
                      context.router.maybePop();
                    } else {
                      context.router.replace(const HomeRoute());
                    }
                  },
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  children: [
                    // Edit Profile Section / Card
                    Card(
                      elevation: 0,
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.defaultRadius.r),
                        side: BorderSide(color: AppColors.darkgrey.withValues(alpha: 0.2)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.person_outline, color: AppColors.primaryColor),
                              title: Text(
                                'Edit Account Info',
                                style: getMediumStyle(fontSize: AppFonts.s14.sp, color: AppColors.navy),
                              ),
                              subtitle: Text(
                                'Update name, city',
                                style: getRegularStyle(fontSize: AppFonts.s12.sp, color: AppColors.darkgrey),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  _isEditingProfile ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                  color: AppColors.darkgrey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isEditingProfile = !_isEditingProfile;
                                  });
                                },
                              ),
                            ),
                            if (_isEditingProfile) ...[
                              SizedBox(height: 8.h),
                              Form(
                                key: _editProfileFormKey,
                                child: Column(
                                  children: [
                                    CustomTextformfeild(
                                      formFieldKey: _nameKey,
                                      keyboardType: TextInputType.text,
                                      controller: _nameController,
                                      hintText: 'Name',
                                      hintColor: AppColors.darkgrey,
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return 'Please enter your name';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 12.h),
                                    CustomTextformfeild(
                                      keyboardType: TextInputType.text,
                                      formFieldKey: _cityKey,
                                      controller: _cityController,
                                      hintText: 'City',
                                      hintColor: AppColors.darkgrey,
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return 'Please enter your city';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 16.h),
                                    SizedBox(
                                      width: double.infinity,
                                      child: CustomButton(
                                        data: 'Save Changes',
                                        height: 45.h,
                                        fontSize: AppFonts.s14.sp,
                                        onTap: () {
                                          if (_editProfileFormKey.currentState!.validate()) {
                                            profileCubit.updateProfile(
                                              name: _nameController.text.trim(),
                                              city: _cityController.text.trim(),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Change Password Section / Card
                    Card(
                      elevation: 0,
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.defaultRadius.r),
                        side: BorderSide(color: AppColors.darkgrey.withValues(alpha: 0.2)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.lock_outline, color: AppColors.primaryColor),
                              title: Text(
                                'Change Password',
                                style: getMediumStyle(fontSize: AppFonts.s14.sp, color: AppColors.navy),
                              ),
                              subtitle: Text(
                                'Update your secure password',
                                style: getRegularStyle(fontSize: AppFonts.s12.sp, color: AppColors.darkgrey),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  _isChangingPassword ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                  color: AppColors.darkgrey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isChangingPassword = !_isChangingPassword;
                                  });
                                },
                              ),
                            ),
                            if (_isChangingPassword) ...[
                              SizedBox(height: 8.h),
                              Form(
                                key: _changePasswordFormKey,
                                child: Column(
                                  children: [
                                    CustomTextformfeild(
                                      keyboardType: TextInputType.visiblePassword,
                                      formFieldKey: _currentPassKey,
                                      controller: _currentPassController,
                                      isPassword: true,
                                      hintText: 'Current Password',
                                      hintColor: AppColors.darkgrey,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter current password';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 12.h),
                                    CustomTextformfeild(
                                      keyboardType: TextInputType.visiblePassword,
                                      formFieldKey: _newPassKey,
                                      controller: _newPassController,
                                      isPassword: true,
                                      hintText: 'New Password',
                                      hintColor: AppColors.darkgrey,
                                      validator: (value) {
                                        if (value == null || value.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 16.h),
                                    SizedBox(
                                      width: double.infinity,
                                      child: CustomButton(
                                        data: 'Update Password',
                                        height: 45.h,
                                        fontSize: AppFonts.s14.sp,
                                        onTap: () {
                                          if (_changePasswordFormKey.currentState!.validate()) {
                                            profileCubit.changePassword(
                                              currentPass: _currentPassController.text,
                                              newPass: _newPassController.text,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Card(
                    //   elevation: 0,
                    //   color: AppColors.white,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(AppConstants.defaultRadius.r),
                    //     side: BorderSide(color: AppColors.darkgrey.withValues(alpha: 0.2)),
                    //   ),
                    //   child: ListTile(
                    //     leading: const Icon(Icons.shopping_bag_outlined, color: AppColors.primaryColor),
                    //     title: Text(
                    //       'My Orders & Buy Again',
                    //       style: getMediumStyle(fontSize: AppFonts.s14.sp, color: AppColors.navy),
                    //     ),
                    //     subtitle: Text(
                    //       'View order history & re-order',
                    //       style: getRegularStyle(fontSize: AppFonts.s12.sp, color: AppColors.darkgrey),
                    //     ),
                    //     trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.darkgrey),
                    //     onTap: () {
                    //       context.read<ProfileCubit>().loadOrders();
                    //       // context.router.push(const OrdersRoute());
                    //     },
                    //   ),
                    // ),
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