import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

class NavBottomBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function()? onTap;
  const NavBottomBarIcon({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70.w,
        height: 50.h,
        child: Column(
          children: [
            Icon(icon, color: AppColors.grey),
            Text(label,
                style: getRegularStyle(fontSize: 12.w, color: AppColors.grey))
          ],
        ),
      ),
    );
  }
}
