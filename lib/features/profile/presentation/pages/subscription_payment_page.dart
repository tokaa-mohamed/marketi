import 'package:auto_route/auto_route.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/constant/app_constants.dart';
import 'package:marketi/core/di.dart'; 
import 'package:marketi/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_state.dart';

@RoutePage()
class SubscriptionAndPaymentPage extends StatelessWidget {
  const SubscriptionAndPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileCubit>()..loadSubscriptions(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Subscription & Payment')),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileSubscriptionsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context.read<ProfileCubit>().loadSubscriptions(),
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }

            if (state is ProfileSubscriptionsLoaded) {
              final subscriptions = state.subscriptions;

              if (subscriptions.isEmpty) {
                return const Center(child: Text('No active subscriptions found.'));
              }

              return RefreshIndicator(
                onRefresh: () async => context.read<ProfileCubit>().loadSubscriptions(),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: subscriptions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final sub = subscriptions[index];

                    return Column(
                      children: [
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      sub.planName ?? 'My Subscription',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    Chip(
                                      label: Text(sub.status ?? 'Active'),
                                      backgroundColor: sub.status?.toLowerCase() == 'active'
                                          ? Colors.greenAccent
                                          : Colors.grey[300],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text('${sub.planName ?? 'Plan'} - \$${sub.price ?? '0.00'}'),
                                const SizedBox(height: 4),
                                Text(
                                  'Renews on: ${sub.renewalDate ?? 'N/A'}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.payment_outlined),
                            title: const Text('Payment History'),
                            subtitle: const Text('View past invoices and receipts'),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              context.read<ProfileCubit>().loadOrders();
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}