import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/app_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const SectionHeader({super.key, required this.title, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getBoldStyle(fontSize: AppFonts.s18.sp, color: AppColors.secondaryColor),
          ),
          TextButton(
            onPressed: onViewAll,
            child: Text(
              'View all',
              style: getRegularStyle(fontSize: AppFonts.s14.sp, color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
