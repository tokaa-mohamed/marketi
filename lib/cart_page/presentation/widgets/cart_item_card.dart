import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/constant/cached_image_widget.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

class CartItemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String imageUrl;
  final double rating;
  final int quantity;
  final bool isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onDelete;

  const CartItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.quantity,
    this.isFavorite = false,
    this.onFavoriteTap,
    this.onIncrement,
    this.onDecrement,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.blue.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. صورة المنتج
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: SizedBox(
              width: 90.w,
              height: 110.h,
              child: CachedImageWidget(imageUrl: imageUrl),
            ),
          ),
          SizedBox(width: 12.w),

          // 2. تفاصيل المنتج وزر التحكم بالكميات
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان مع أيقونة المفضلة
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getBoldStyle(
                            fontSize: 16.sp, color: AppColors.black),
                      ),
                    ),
                    InkWell(
                      onTap: onFavoriteTap,
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color:
                            isFavorite ? Colors.blue.shade900 : Colors.black54,
                        size: 22.r,
                      ),
                    ),
                  ],
                ),

                // الوصف الفرعي
                Text(
                  subtitle,
                  style: getRegularStyle(fontSize: 13.sp, color: Colors.grey),
                ),
                SizedBox(height: 6.h),

                // السعر والتقييم
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Price: ',
                            style: getMediumStyle(
                                fontSize: 14.sp, color: AppColors.black),
                          ),
                          TextSpan(
                            text: price,
                            style: getBoldStyle(
                                fontSize: 14.sp, color: AppColors.black),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star_border_rounded,
                            color: Colors.black87, size: 18.r),
                        SizedBox(width: 2.w),
                        Text(
                          '$rating',
                          style: getMediumStyle(
                              fontSize: 13.sp, color: AppColors.black),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),

                // أزرار زيادة ونقصان/حذف الكمية
                Row(
                  children: [
                    // زر الحذف أو النقصان
                    GestureDetector(
                      onTap: quantity == 1 ? onDelete : onDecrement,
                      child: Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBF3FF),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          quantity == 1 ? Icons.delete_outline : Icons.remove,
                          color: quantity == 1 ? Colors.redAccent : Colors.blue,
                          size: 20.r,
                        ),
                      ),
                    ),

                    // خانة القيمة الحالية
                    Expanded(
                      child: Container(
                        height: 36.h,
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7FAFF),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            '$quantity',
                            style: getBoldStyle(
                                fontSize: 15.sp, color: Colors.blue),
                          ),
                        ),
                      ),
                    ),

                    // زر الزيادة
                    GestureDetector(
                      onTap: onIncrement,
                      child: Container(
                        width: 36.w,
                        height: 36.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBF3FF),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.blue,
                          size: 20.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
