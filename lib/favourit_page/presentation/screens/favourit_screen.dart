import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:marketi/core/constant/custom_app_bar.dart';

import 'package:marketi/core/constant/custom_favourit_items.dart';
import 'package:marketi/core/constant/custom_text_field.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

class FavouritScreen extends StatefulWidget {
  const FavouritScreen({super.key});

  @override
  State<FavouritScreen> createState() => _FavouritScreenState();
}

TextEditingController controller = TextEditingController();

class _FavouritScreenState extends State<FavouritScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
              child: CustomAppBar(
            title: "Favourit",
          )),
          Padding(
            padding: EdgeInsets.only(
                top: 65.h, bottom: 30.h, right: 15.w, left: 15.w),
            child: CustomTextField(controller: controller),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          "All Products",
                          style: getMediumStyle(
                              fontSize: 20.w, color: AppColors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 15.w),
                  sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return FavouritItemsWidget();
                        },
                        childCount: 12,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12.h,
                          crossAxisSpacing: 12.w,
                          childAspectRatio: 0.7)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
