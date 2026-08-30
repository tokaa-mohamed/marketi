import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

class SubTotalWidget extends StatelessWidget {
  const SubTotalWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 347.w,
        height: 130.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.lightBlue, width: 1.w),
        ),
        child: Column(
          children: [
            CustomItemInTotalSummry(
                title: "Subtotal(3 items)", price: "345,00 EGP"),
            SizedBox(
              height: 10.h,
            ),
            CustomItemInTotalSummry(title: "Delivery", price: "15,00 EGP"),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "----------------------------",
              style: getRegularStyle(
                  fontSize: 15.sp, color: AppColors.lightBlue100),
            ),
            CustomItemInTotalSummry(
                title: "Total",
                price: "EGP 360,00",
                color: AppColors.darkBlueColor),
          ],
        ));
  }
}

class CustomItemInTotalSummry extends StatelessWidget {
  final String title;
  final String price;
  final Color? color;
  const CustomItemInTotalSummry({
    super.key,
    required this.title,
    required this.price,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
          child: Text(
            title,
            style: getRegularStyle(
                fontSize: 15.sp, color: color ?? AppColors.grey),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
          child: Text(
            price,
            style: getRegularStyle(
                fontSize: 15.sp, color: color ?? AppColors.grey),
          ),
        )
      ],
    );
  }
}
