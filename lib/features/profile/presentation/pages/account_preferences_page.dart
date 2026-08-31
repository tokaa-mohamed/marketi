import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/constant/app_constants.dart';
import 'package:marketi/core/constant/custom_button.dart';
import 'package:marketi/core/constant/custom_textformfield.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_state.dart';

@RoutePage()
class AccountPreferencesPage extends StatelessWidget {
  const AccountPreferencesPage({super.key});

  void _showEditProfileDialog(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    final nameController = TextEditingController();
    final cityController = TextEditingController();
    final nameKey = GlobalKey<FormFieldState>();
    final cityKey = GlobalKey<FormFieldState>();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius.r),
          ),
          title: Text(
            'Edit Account Info',
            style: getBoldStyle(fontSize: AppFonts.s16.sp, color: AppColors.navy),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextformfeild(
                  formFieldKey: nameKey,
                  keyboardType: TextInputType.text,
                  controller: nameController,
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
                  formFieldKey: cityKey,
                  controller: cityController,
                  hintText: 'City',
                  hintColor: AppColors.darkgrey,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                nameController.dispose();
                cityController.dispose();
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Cancel',
                style: getMediumStyle(fontSize: AppFonts.s14.sp, color: AppColors.darkgrey),
              ),
            ),
            CustomButton(
              data: 'Save',
              width: 90.w,
              height: 40.h,
              fontSize: AppFonts.s14.sp,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  profileCubit.updateProfile(
                    name: nameController.text.trim(),
                    city: cityController.text.trim(),
                  );
                  nameController.dispose();
                  cityController.dispose();
                  Navigator.pop(dialogContext);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    final currentPassController = TextEditingController();
    final newPassController = TextEditingController();
    final currentPassKey = GlobalKey<FormFieldState>();
    final newPassKey = GlobalKey<FormFieldState>();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.defaultRadius.r),
          ),
          title: Text(
            'Change Password',
            style: getBoldStyle(fontSize: AppFonts.s16.sp, color: AppColors.navy),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextformfeild(
                  keyboardType: TextInputType.visiblePassword,
                  formFieldKey: currentPassKey,
                  controller: currentPassController,
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
                  formFieldKey: newPassKey,
                  controller: newPassController,
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
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                currentPassController.dispose();
                newPassController.dispose();
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Cancel',
                style: getMediumStyle(fontSize: AppFonts.s14.sp, color: AppColors.darkgrey),
              ),
            ),
            CustomButton(
              data: 'Update',
              width: 90.w,
              height: 40.h,
              fontSize: AppFonts.s14.sp,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  profileCubit.changePassword(
                    currentPass: currentPassController.text,
                    newPass: newPassController.text,
                  );
                  currentPassController.dispose();
                  newPassController.dispose();
                  Navigator.pop(dialogContext);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileCubit>(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully!')),
            );
          } else if (state is ProfilePasswordChangedSuccess) {
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
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  children: [
                    Card(
                      elevation: 0,
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.defaultRadius.r),
                        side: BorderSide(color: AppColors.darkgrey.withValues(alpha: 0.2)),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.person_outline, color: AppColors.primaryColor),
                        title: Text(
                          'Edit Account Info',
                          style: getMediumStyle(fontSize: AppFonts.s14.sp, color: AppColors.navy),
                        ),
                        subtitle: Text(
                          'Update name, phone, city',
                          style: getRegularStyle(fontSize: AppFonts.s12.sp, color: AppColors.darkgrey),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.darkgrey),
                        onTap: () => _showEditProfileDialog(context),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Card(
                      elevation: 0,
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.defaultRadius.r),
                        side: BorderSide(color: AppColors.darkgrey.withValues(alpha: 0.2)),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.lock_outline, color: AppColors.primaryColor),
                        title: Text(
                          'Change Password',
                          style: getMediumStyle(fontSize: AppFonts.s14.sp, color: AppColors.navy),
                        ),
                        subtitle: Text(
                          'Update your secure password',
                          style: getRegularStyle(fontSize: AppFonts.s12.sp, color: AppColors.darkgrey),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.darkgrey),
                        onTap: () => _showChangePasswordDialog(context),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Card(
                      elevation: 0,
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppConstants.defaultRadius.r),
                        side: BorderSide(color: AppColors.darkgrey.withValues(alpha: 0.2)),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.shopping_bag_outlined, color: AppColors.primaryColor),
                        title: Text(
                          'My Orders & Buy Again',
                          style: getMediumStyle(fontSize: AppFonts.s14.sp, color: AppColors.navy),
                        ),
                        subtitle: Text(
                          'View order history & re-order',
                          style: getRegularStyle(fontSize: AppFonts.s12.sp, color: AppColors.darkgrey),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.darkgrey),
                        onTap: () {
                          context.read<ProfileCubit>().loadOrders();
                          // context.router.push(const OrdersRoute());
                        },
                      ),
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