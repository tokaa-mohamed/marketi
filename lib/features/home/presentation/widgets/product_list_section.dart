import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/product_entity.dart';
import 'section_header.dart';
import 'product_item.dart';

class ProductListSection extends StatelessWidget {
  final String title;
  final List<ProductEntity> products;
  final bool showAddButton;
  final VoidCallback? onViewAll;

  const ProductListSection({
    super.key,
    required this.title,
    required this.products,
    this.showAddButton = false,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: title, onViewAll: onViewAll ?? () {}),
        SizedBox(
          height: showAddButton ? 260.h : 220.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => ProductItem(
              product: products[index],
              showAddButton: showAddButton,
            ),
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemCount: products.length,
          ),
        ),
      ],
    );
  }
}
