import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/routing/app_router.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../presentation/widgets/home_search_bar.dart';
import '../../domain/entities/brand_entity.dart';

class BrandsBody extends StatelessWidget {
  final List<BrandEntity> brands;

  const BrandsBody({super.key, required this.brands});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeSearchBar(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Text(
            'All Brands',
            style: getBoldStyle(
                fontSize: AppFonts.s18.sp, color: AppColors.secondaryColor),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.9,
            ),
            itemCount: brands.length,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return GestureDetector(
                onTap: () {
                  context.pushRoute(BrandProductsRoute(brand: brand));
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.r),
                          child: brand.image.isNotEmpty
                              ? Image.network(brand.image, fit: BoxFit.contain)
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      brand.name,
                      style: getBoldStyle(
                          fontSize: AppFonts.s14.sp,
                          color: AppColors.secondaryColor),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
