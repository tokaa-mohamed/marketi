import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../inner_views/brands/domain/entities/brand_entity.dart';
import 'section_header.dart';

class BrandsSection extends StatelessWidget {
  final List<BrandEntity> brands;

  const BrandsSection({super.key, required this.brands});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: 'Brands',
          onViewAll: () {
            context.pushRoute(const BrandsRoute());
          },
        ),
        SizedBox(
          height: 80.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final brand = brands[index];
              return GestureDetector(
                onTap: () {
                  context.pushRoute(BrandProductsRoute(brand: brand));
                },
                child: Container(
                  width: 80.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Center(
                    child: Image.network(
                      brand.image,
                      width: 60.w,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.business),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemCount: brands.length,
          ),
        ),
      ],
    );
  }
}
