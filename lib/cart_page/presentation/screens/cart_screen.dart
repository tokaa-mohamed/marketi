import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:marketi/core/constant/custom_app_bar.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 20.h),
        SafeArea(
          child: CustomAppBar(title: "Cart"),
        ),
        SizedBox(height: 30.h),
        Expanded(
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      "Products on Cart",
                      style: getMediumStyle(
                          fontSize: 20.w, color: AppColors.black),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: Container())
          ]),
        ),
      ],
    ));
  }
}
