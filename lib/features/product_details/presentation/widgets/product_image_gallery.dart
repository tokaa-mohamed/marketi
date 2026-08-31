import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:marketi/core/constant/cached_image_widget.dart';
import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/product_details_entity.dart';

class ProductImageGallery extends StatefulWidget {
  final List<ProductImageEntity> images;

  const ProductImageGallery({super.key, required this.images});

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 250.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final imageUrl = widget.images[index].image;
              return Center(
                child: imageUrl.isNotEmpty
                    ? CachedImageWidget(
                        imageUrl: imageUrl,
                        fit: BoxFit.contain,
                        width: double.infinity,
                      )
                    : Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: AppColors.greychip,
                      ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        Skeleton.ignore(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.images.asMap().entries.map((entry) {
              final isSelected = _currentIndex == entry.key;
              return Container(
                width: isSelected ? 30.w : 8.w,
                height: 4.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.r),
                  color: isSelected
                      ? AppColors.secondaryColor
                      : AppColors.grey.withValues(alpha: 0.3),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: 70.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: widget.images.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final imageUrl = widget.images[index].image;
              return GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  width: 70.w,
                  decoration: BoxDecoration(
                    color: AppColors.greychip,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: _currentIndex == index
                          ? AppColors.primaryColor
                          : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Padding(
                      padding: EdgeInsets.all(4.r),
                      child: imageUrl.isNotEmpty
                          ? CachedImageWidget(
                              imageUrl: imageUrl,
                              fit: BoxFit.contain,
                            )
                          : Container(color: AppColors.grey),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
