import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/constant/custom_button.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

class FavouritItemsWidget extends StatelessWidget {
  const FavouritItemsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 160.w,
        height: 220.h,
        child: Container(
          width: 50,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.lightGrayColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Takes only the height it needs
            children: [
              // 1. Product Image + Favorite Icon Stack
              Stack(
                children: [
                  Container(
                    height: 100.h, // Adjusted proportional height
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.r),
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.image, color: AppColors.grey),
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: CircleAvatar(
                      radius: 14.r,
                      backgroundColor: AppColors.white,
                      child: const Icon(
                        Icons.favorite,
                        color: AppColors.darkBlueColor,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),

              // 2. Product Details
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$150.00",
                      style: getRegularStyle(
                        fontSize: 12.sp,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Product Item",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getRegularStyle(
                        fontSize: 11.sp,
                        color: AppColors.black,
                      ),
                    ),
                    Center(
                      child: CustomButton(
                        data: "Add",
                        height: 30.h,
                        width: 90.w,
                        color: AppColors.white,
                        bordercolor: AppColors.lightBlue100,
                        textStyle: getRegularStyle(
                            fontSize: 11.5.sp, color: AppColors.lightBlue100),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
