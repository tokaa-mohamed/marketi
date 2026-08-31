import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';

class ProfileSwitchItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
    final Color? iconColor;


  const ProfileSwitchItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(
            icon,
            color: AppColors.navy,
            size: 22.sp,
          ),
          title: Text(
            title,
            style: getMediumStyle(
              color: AppColors.darkBlue,
              fontSize: AppFonts.s16.sp,
            ),
          ),
          trailing: Switch(
            value: value,
            activeColor: AppColors.white,
            activeTrackColor: AppColors.primaryColor,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: AppColors.grey.withOpacity(0.5),
            onChanged: onChanged,
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