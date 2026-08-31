import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/constant/app_constants.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';
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
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Text(
            'Subscription & Payment',
            style: getBoldStyle(fontSize: AppFonts.s18.sp, color: AppColors.navy),
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.navy),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileSubscriptionsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: getRegularStyle(fontSize: AppFonts.s14.sp, color: AppColors.darkgrey),
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppConstants.defaultRadius.r),
                          ),
                        ),
                        onPressed: () => context.read<ProfileCubit>().loadSubscriptions(),
                        child: Text(
                          'Try Again',
                          style: getMediumStyle(fontSize: AppFonts.s14.sp, color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ProfileSubscriptionsLoaded) {
              final subscriptions = state.subscriptions;

              if (subscriptions.isEmpty) {
                return Center(
                  child: Text(
                    'No active subscriptions found.',
                    style: getRegularStyle(fontSize: AppFonts.s14.sp, color: AppColors.darkgrey),
                  ),
                );
              }

              return RefreshIndicator(
                color: AppColors.primaryColor,
                onRefresh: () async => context.read<ProfileCubit>().loadSubscriptions(),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  itemCount: subscriptions.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
                    final sub = subscriptions[index];
                    final isActive = sub.status?.toLowerCase() == 'active';

                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(AppConstants.defaultRadius.r),
                            border: Border.all(
                              color: AppColors.darkgrey.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    sub.planName ?? 'My Subscription',
                                    style: getBoldStyle(fontSize: AppFonts.s16.sp, color: AppColors.navy),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? Colors.green.withValues(alpha: 0.1)
                                          : AppColors.darkgrey.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      sub.status ?? 'Active',
                                      style: getMediumStyle(
                                        fontSize: AppFonts.s12.sp,
                                        color: isActive ? Colors.green : AppColors.darkgrey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                children: [
                                  Icon(Icons.star_outline_rounded, size: 18.sp, color: AppColors.primaryColor),
                                  SizedBox(width: 8.w),
                                  Text(
                                    '${sub.planName ?? 'Plan'} - \$${sub.price ?? '0.00'}',
                                    style: getMediumStyle(fontSize: AppFonts.s14.sp, color: AppColors.navy),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today_outlined, size: 16.sp, color: AppColors.darkgrey),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Renews on: ${sub.renewalDate ?? 'N/A'}',
                                    style: getRegularStyle(fontSize: AppFonts.s12.sp, color: AppColors.darkgrey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(AppConstants.defaultRadius.r),
                            border: Border.all(
                              color: AppColors.darkgrey.withValues(alpha: 0.2),
                            ),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.payment_outlined, color: AppColors.primaryColor),
                            title: Text(
                              'Payment History',
                              style: getMediumStyle(fontSize: AppFonts.s14.sp, color: AppColors.navy),
                            ),
                            subtitle: Text(
                              'View past invoices and receipts',
                              style: getRegularStyle(fontSize: AppFonts.s12.sp, color: AppColors.darkgrey),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.darkgrey),
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