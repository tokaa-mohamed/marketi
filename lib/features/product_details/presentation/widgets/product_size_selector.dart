import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/product_details_entity.dart';

class ProductSizeSelector extends StatefulWidget {
  final List<ProductSizeEntity> sizes;

  const ProductSizeSelector({super.key, required this.sizes});

  @override
  State<ProductSizeSelector> createState() => _ProductSizeSelectorState();
}

class _ProductSizeSelectorState extends State<ProductSizeSelector> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.sizes.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.borderColor,
                      width: 1.2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.sizes[index].size,
                      style: getMediumStyle(
                        fontSize: 16.sp,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ),
                if (isSelected)
                  Positioned(
                    bottom: -2,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(2.r),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 10.sp,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
