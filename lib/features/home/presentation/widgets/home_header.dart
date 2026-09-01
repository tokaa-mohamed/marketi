import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/routing/app_router.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_state.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/app_fonts.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
GestureDetector(
  onTap: () {
    context.router.push(const ProfileDrawerRoute()); 
  },
  child: CircleAvatar(
    radius: 20.r,
    backgroundColor: AppColors.primaryColor,
    child: Icon(Icons.person, color: AppColors.secondaryColor),
  ),
),
          SizedBox(width: 10.w),
BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              String userName = "User"; 
              
              if (state is ProfileLoaded) {
                userName = state.profile.name ?? "User";
              }

              return Text(
                'Hi $userName!',
                style: getBoldStyle(fontSize: AppFonts.s18.sp, color: AppColors.secondaryColor),
              );
            },
          ),
                    const Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: AppColors.primaryColor, size: 28.sp),
          ),
        ],
      ),
    );
  }
}
