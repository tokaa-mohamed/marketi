import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';

class ProfileOptionItem extends StatelessWidget {
  final String iconPath; 
    final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const ProfileOptionItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 22.sp,
                  height: 22.sp,
                  colorFilter: ColorFilter.mode(
                    iconColor ?? AppColors.navy,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    title,
                    style: getMediumStyle(
                      color: textColor ?? AppColors.navy,
                      fontSize: AppFonts.s16.sp,
                    ),
                  ),
                ),
                Container(
                  width: 28.w,
                  height: 28.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.15),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 12.sp,
                    color: AppColors.primaryColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: AppColors.grey.withOpacity(0.15),
          height: 1.h,
        ),
      ],
    );
  }
}