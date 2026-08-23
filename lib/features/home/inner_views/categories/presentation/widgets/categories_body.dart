import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/routing/app_router.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../presentation/widgets/home_search_bar.dart';
import '../../domain/entities/category_entity.dart';

class CategoriesBody extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoriesBody({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeSearchBar(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Text(
            'All Categories',
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
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  context.pushRoute(CategoryProductsRoute(category: category));
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
                          child: category.image.isNotEmpty
                              ? Image.network(category.image, fit: BoxFit.contain)
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      category.name,
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
