import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/routing/app_router.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_state.dart';

@RoutePage()
class ProfileDrawerPage extends StatelessWidget {
  const ProfileDrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileCubit>()..fetchUserProfile(),
      child: Drawer(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileSuccess) {
              final user = state.profile;
              return Column(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(user.name ?? "User"),
                    accountEmail: Text(user.email ?? ""),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: user.avatar != null
                          ? NetworkImage(user.avatar!)
                          : null,
                      child: user.avatar == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text('My Profile'),
                    onTap: () {
                      Navigator.pop(context);
                      context.router.push(const ProfileRoute());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_bag_outlined),
                    title: const Text('My Orders'),
                    onTap: () {
                      Navigator.pop(context);
                      // context.router.push(const OrdersRoute());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.credit_card_outlined),
                    title: const Text('Subscription & Payment'),
                    onTap: () {
                      Navigator.pop(context);
                      context.router.push(const SubscriptionAndPaymentRoute());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('Account Preferences'),
                    onTap: () {
                      Navigator.pop(context);
                      context.router.push(const AccountPreferencesRoute());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help_outline_rounded),
                    title: const Text('Support'),
                    onTap: () {
                      Navigator.pop(context);
                      context.router.push(const SupportRoute());
                    },
                  ),
                  const Spacer(),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout_rounded, color: Colors.red),
                    title: const Text('Log Out', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      context.read<ProfileCubit>().logout();
                      context.router.replaceAll([const LoginRoute()]);
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              );
            }

            return const Center(child: Text('Failed to load user info'));
          },
        ),
      ),
    );
  }
}