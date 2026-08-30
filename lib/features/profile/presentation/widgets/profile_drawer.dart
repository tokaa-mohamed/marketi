import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/routing/app_router.gr.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_state.dart';

@RoutePage()
class ProfileDrawerScreen extends StatelessWidget {
  const ProfileDrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileCubit>(),
      child: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                buildWhen: (previous, current) =>
                    current is ProfileLoaded || current is ProfileLoading,
                builder: (context, state) {
                  String userName = 'User';
                  String? avatarUrl;

                  if (state is ProfileLoaded) {
                    userName = state.profile.name ?? 'User';
                    avatarUrl = state.profile.avatar;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              avatarUrl != null && avatarUrl.isNotEmpty
                                  ? NetworkImage(avatarUrl)
                                  : null,
                          child: avatarUrl == null || avatarUrl.isEmpty
                              ? const Icon(Icons.person, size: 28)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome,',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color(0xFF1B254B),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Color(0xFF1B254B),
                          ),
                          onPressed: () => Navigator.of(context).pop(), 
                                                  ),
                      ],
                    ),
                  );
                },
              ),
              const Divider(height: 1),
              const SizedBox(height: 16),

              // Options List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  children: [
                    _buildDrawerItem(
                      icon: Icons.autorenew_rounded,
                      title: 'Buy Again',
                      onTap: () {
                        Navigator.of(context).pop(); 
                                                getIt<ProfileCubit>().loadOrders();
                        // context.router.push(const MyOrdersRoute());
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.shopping_bag_outlined,
                      title: 'My Orders',
                      onTap: () {
                        Navigator.of(context).pop(); 
                                                getIt<ProfileCubit>().loadOrders();
                        // context.router.push(const MyOrdersRoute());
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.credit_card_outlined,
                      title: 'Payments',
                      onTap: () {
                        Navigator.of(context).pop();
                                                context.router.push(
                          const SubscriptionAndPaymentRoute(),
                        );
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.settings_outlined,
                      title: 'Account Settings',
                      onTap: () {
                        Navigator.of(context).pop();
                        
                        context.router.push(const AccountPreferencesRoute());
                      },
                    ),
                    _buildDrawerItem(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: 'Support',
                      onTap: () {
                        Navigator.of(context).pop();
                                                context.router.push(const SupportRoute());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1B254B), size: 24),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF1B254B),
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
    );
  }
}