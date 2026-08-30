import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/constant/cached_image_widget.dart';
import 'package:marketi/core/constant/custom_button.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

class FavouritItemsWidget extends StatelessWidget {
  final String name;
  final double price;
  final double rating;
  final String mainImage;
  final VoidCallback? onAddTap;

  const FavouritItemsWidget({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    required this.mainImage,
    this.onAddTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 160.w,
        height: 220.h,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.lightGrayColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. Product Image + Favorite Icon Stack
              Stack(
                children: [
                  Container(
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.r),
                      ),
                    ),
                    child: Center(
                      child: mainImage.isNotEmpty
                          ? CachedImageWidget(
                              imageUrl: mainImage,
                              width: double.infinity,
                              height: 100.h,
                              fit: BoxFit.cover,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12.r),
                              ),
                            )
                          : const Icon(Icons.image, color: AppColors.grey),
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
                        color: Colors.red,
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
                      "$price LE",
                      style: getRegularStyle(
                        fontSize: 12.sp,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getRegularStyle(
                        fontSize: 11.sp,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Center(
                      child: CustomButton(
                        data: "Add",
                        height: 30.h,
                        width: 90.w,
                        color: AppColors.white,
                        bordercolor: AppColors.lightBlue100,
                        fontSize: 11.5.sp,
                        txtcolor: AppColors.lightBlue100,
                        onTap: onAddTap,
                      ),
                    ),
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
