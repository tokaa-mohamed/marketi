import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/constant/custom_button.dart';
import '../../domain/entities/product_entity.dart';

class ProductItem extends StatelessWidget {
  final ProductEntity product;
  final bool showAddButton;

  const ProductItem({
    super.key,
    required this.product,
    this.showAddButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(ProductDetailsRoute(productId: product.id));
      },
      child: Container(
        width: 160.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                  child: Image.network(
                    product.image,
                    height: 120.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  ),
                ),
                if (product.discount != null)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        '${product.discount}% OFF',
                        style: getRegularStyle(fontSize: 10.sp, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: product.isFavorite ? AppColors.secondaryColor : AppColors.grey,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.price} LE',
                    style: getBoldStyle(fontSize: AppFonts.s14.sp, color: AppColors.secondaryColor),
                  ),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getRegularStyle(fontSize: AppFonts.s12.sp, color: AppColors.secondaryColor),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 14),
                      SizedBox(width: 4.w),
                      Text(
                        product.rating.toString(),
                        style: getRegularStyle(fontSize: 12.sp, color: AppColors.secondaryColor),
                      ),
                    ],
                  ),
                  if (showAddButton) ...[
                    SizedBox(height: 8.h),
                    CustomButton(
                      data: 'Add',
                      height: 32.h,
                      fontSize: 12.sp,
                      color: AppColors.white,
                      bordercolor: AppColors.primaryColor,
                      txtcolor: AppColors.primaryColor,
                      onTap: () {},
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
