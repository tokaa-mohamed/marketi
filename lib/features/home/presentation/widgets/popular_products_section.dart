import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/product_entity.dart';
import 'section_header.dart';
import 'product_item.dart';

class PopularProductsSection extends StatelessWidget {
  final List<ProductEntity> products;

  const PopularProductsSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: 'Popular Product', onViewAll: () {}),
        SizedBox(
          height: 220.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => ProductItem(product: products[index]),
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemCount: products.length,
          ),
        ),
      ],
    );
  }
}
