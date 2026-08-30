import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';

class ProfileOptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const ProfileOptionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            icon,
            color: iconColor ?? AppColors.navy,
            size: 22.sp,
          ),
          title: Text(
            title,
            style: getMediumStyle(
              color: textColor ?? AppColors.navy,
              fontSize: AppFonts.s16.sp,
            ),
          ),
          trailing: Container(
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
          onTap: onTap,
        ),
        Divider(
          color: AppColors.grey.withOpacity(0.15),
          height: 1.h,
        ),
      ],
    );
  }
}