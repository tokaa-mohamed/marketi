import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

class CustomTitleText extends StatelessWidget {
  final double sizeTxt;
  final String title;
  const CustomTitleText({
    super.key,
    required this.sizeTxt,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0).r,
          child: Text(
            title,
            style: getMediumStyle(
                fontSize: sizeTxt, color: AppColors.darkBlueColor),
          ),
        ),
      ],
    );
  }
}
