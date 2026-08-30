import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

class DeliveryTimeWidget extends StatelessWidget {
  const DeliveryTimeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 347.w,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.lightBlue, width: 1.w),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0).r,
            child: Icon(Icons.local_shipping_outlined,
                color: AppColors.darkBlueColor, size: 20.r),
          ),
          Text(
            "Within 3 days",
            style: getRegularStyle(
                fontSize: 15.sp, color: AppColors.darkBlueColor),
          ),
        ],
      ),
    );
  }
}
