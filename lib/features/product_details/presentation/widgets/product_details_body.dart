import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/product_details_entity.dart';
import 'product_image_gallery.dart';
import 'product_size_selector.dart';

class ProductDetailsBody extends StatelessWidget {
  final ProductDetailsEntity product;
  final Function(String) onSizeSelected;

  const ProductDetailsBody({
    super.key,
    required this.product,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageGallery(images: product.gallery),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: Text(
                        'Free Shipping',
                        style: getRegularStyle(fontSize: 12.sp, color: AppColors.primaryColor),
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => Icon(
                            index < product.rating.floor() ? Icons.star : Icons.star_border,
                            color: Colors.black,
                            size: 18.sp,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '(${product.rating})',
                          style: getRegularStyle(fontSize: 14.sp, color: AppColors.secondaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  product.name,
                  style: getBoldStyle(fontSize: AppFonts.s18.sp, color: AppColors.secondaryColor),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Product Value',
                  style: getBoldStyle(fontSize: AppFonts.s14.sp, color: AppColors.secondaryColor),
                ),
                SizedBox(height: 8.h),
                RichText(
                  text: TextSpan(
                    style: getRegularStyle(fontSize: 12.sp, color: AppColors.secondaryColor, height: 1.5),
                    children: [
                      TextSpan(text: product.description),
                      TextSpan(
                        text: ' See more',
                        style: getBoldStyle(fontSize: 12.sp, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                if (product.sizes.isNotEmpty) ...[
                  SizedBox(height: 20.h),
                  Text(
                    'Select Size',
                    style: getBoldStyle(fontSize: AppFonts.s14.sp, color: AppColors.secondaryColor),
                  ),
                  SizedBox(height: 10.h),
                  ProductSizeSelector(
                    sizes: product.sizes,
                    onSizeSelected: onSizeSelected,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
