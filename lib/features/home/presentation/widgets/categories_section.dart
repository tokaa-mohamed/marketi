import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../inner_views/categories/domain/entities/category_entity.dart';
import '../../../../core/routing/app_router.dart';
import 'section_header.dart';

class CategoriesSection extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoriesSection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: 'Category',
          onViewAll: () {
            context.pushRoute(const CategoriesRoute());
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length > 6 ? 6 : categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.85, // Adjust based on image + text height
            ),
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
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Image.network(
                            category.image,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.category_outlined),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      category.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getMediumStyle(
                        fontSize: AppFonts.s12.sp,
                        color: AppColors.secondaryColor,
                      ),
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
