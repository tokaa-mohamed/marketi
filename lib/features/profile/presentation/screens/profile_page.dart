import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/constant/custom_button.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/routing/app_router.dart';
import 'package:marketi/core/theme/theme_cubit.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_state.dart';
import 'package:marketi/features/profile/presentation/widgets/header_profile.dart';
import 'package:marketi/features/profile/presentation/widgets/profile_option_item.dart';
import 'package:marketi/features/profile/presentation/widgets/profile_switch_item.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..fetchUserProfile(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoggedOut) {
            context.router.replaceAll([const LoginRoute()]);
          }
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: Padding(
              padding: EdgeInsets.all(8.r),
              child: CustomButton(
                icon: Icon(
                  Icons.arrow_back_ios_new, 
                  size: 18, 
                  color: isDarkMode ? Colors.white : AppColors.primaryColor,
                ),
                width: 40.w,
                height: 40.h,
                color: isDarkMode ? Colors.transparent : AppColors.white,
                bordercolor: isDarkMode 
                    ? Colors.white.withValues(alpha: 0.2) 
                    : AppColors.primaryColor.withValues(alpha: 0.2),
                borderRadius: 20.r,
                onTap: () => context.router.maybePop(),
              ),
            ),
            title: Text(
              'My Profile',
              style: getBoldStyle(
                color: isDarkMode ? Colors.white : AppColors.navy,
                fontSize: AppFonts.s18.sp,
              ),
            ),
            actions: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  final cartCount = context.read<ProfileCubit>().cartItemsCount;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color: isDarkMode ? Colors.white : AppColors.primaryColor,
                          size: 24.sp,
                        ),
                        onPressed: () {
                          context.router.push(const CartRoute());
                        },
                      ),
                      if (cartCount > 0)
                        Positioned(
                          top: 8.h,
                          right: 8.w,
                          child: CircleAvatar(
                            radius: 7.r,
                            backgroundColor: Colors.red,
                            child: Text(
                              '$cartCount',
                              style: getBoldStyle(
                                color: Colors.white,
                                fontSize: AppFonts.s12.sp,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              SizedBox(width: 8.w),
            ],
          ),
          body: BlocBuilder<ProfileCubit, ProfileState>(
            buildWhen: (previous, current) =>
                current is ProfileLoading ||
                current is ProfileSuccess ||
                current is ProfileError,
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: isDarkMode ? Colors.white : AppColors.primaryColor,
                  ),
                );
              }

              if (state is ProfileError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        style: getMediumStyle(
                          color: isDarkMode ? Colors.white : AppColors.darkBlue,
                          fontSize: AppFonts.s14.sp,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      CustomButton(
                        data: 'Retry',
                        width: 120.w,
                        height: 40.h,
                        onTap: () {
                          context.read<ProfileCubit>().fetchUserProfile();
                        },
                      ),
                    ],
                  ),
                );
              }

              if (state is ProfileSuccess) {
                final user = state.profile;
                final cubit = context.watch<ProfileCubit>();

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  child: Column(
                    children: [
                      ProfileHeaderWidget(onCameraTap: () {},
                        name: user.name ?? "User Name",
                        username: (user.username != null && user.username!.isNotEmpty)
                            ? user.username!
                            : "@user",
                        imageUrl: user.avatar,
                      ),
                      SizedBox(height: 24.h),
                      ProfileOptionItem(
                        icon: Icons.person_outline,
                          iconColor: isDarkMode ? Colors.white : AppColors.navy,
                          textColor: isDarkMode ? Colors.white : AppColors.darkBlue,

                        title: 'Account Preferences',
                        onTap: () {
                          context.router.push(const AccountPreferencesRoute());
                        },
                      ),
                      ProfileOptionItem(
                        icon: Icons.credit_card_outlined,
                 iconColor: isDarkMode ? Colors.white : AppColors.navy,
                                           textColor: isDarkMode ? Colors.white : AppColors.darkBlue,

              
                        title: 'Subscription & Payment',
                        onTap: () {
                          context.router.push(const SubscriptionAndPaymentRoute());
                        },
                      ),
                      ProfileSwitchItem(

                        icon: Icons.notifications_none_outlined,
                        
                                         iconColor: isDarkMode ? Colors.white : AppColors.navy,

                        title: 'App Notifications',
                        value: cubit.isNotificationsEnabled,
                        onChanged: (val) {
                          cubit.toggleNotifications(val);
                        },
                      ),
                      ProfileSwitchItem(
                        icon: Icons.dark_mode_outlined,
                        
                                         iconColor: isDarkMode ? Colors.white : AppColors.navy,

                        title: 'Dark Mode',
                        value: isDarkMode,
                        onChanged: (val) {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                      ),
                      ProfileOptionItem(
                                                  textColor: isDarkMode ? Colors.white : AppColors.darkBlue,

                        icon: Icons.star_border_rounded,
                      iconColor: isDarkMode ? Colors.white : AppColors.navy,

                        title: 'Rate Us',
                        onTap: () {
                          cubit.rateApp();
                        },
                      ),
                      ProfileOptionItem(
                        icon: Icons.chat_bubble_outline_rounded,
                                                  textColor: isDarkMode ? Colors.white : AppColors.darkBlue,

                        iconColor: isDarkMode ? Colors.white : AppColors.navy,
                        title: 'Provide Feedback',
                        onTap: () {
                          // Navigate to Feedback
                        },
                      ),
                      ProfileOptionItem(
                        icon: Icons.logout_rounded,
                        
                        title: 'Log Out',
                          textColor: isDarkMode ? Colors.white : AppColors.darkBlue,
                        iconColor: Colors.redAccent,
                        onTap: () => cubit.logout(),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}