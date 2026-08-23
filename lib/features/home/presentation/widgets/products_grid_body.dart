import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/product_entity.dart';
import 'product_item.dart';

class ProductsGridBody extends StatelessWidget {
  final List<ProductEntity> products;

  const ProductsGridBody({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16.r),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.58,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductItem(
          product: products[index],
          showAddButton: true,
        );
      },
    );
  }
}
