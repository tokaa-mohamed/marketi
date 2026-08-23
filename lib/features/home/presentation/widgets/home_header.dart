import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.primaryColor,
            child: Icon(Icons.person, color: AppColors.secondaryColor),
          ),
          SizedBox(width: 10.w),
          Text(
            'Hi User!',

            style: getBoldStyle(fontSize: AppFonts.s18.sp, color: AppColors.secondaryColor),
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
