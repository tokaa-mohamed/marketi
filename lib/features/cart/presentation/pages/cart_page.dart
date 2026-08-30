import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:marketi/core/constant/custom_app_bar.dart';
import 'package:marketi/core/constant/custom_button.dart';
import 'package:marketi/core/routing/app_router.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

import '../widgets/cart_item_card.dart';

@RoutePage()
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20.h),
          SafeArea(child: CustomAppBar(title: "Cart")),
          SizedBox(height: 10.h),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(
                          "Products on Cart",
                          style: getMediumStyle(
                            fontSize: 20.w,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: CartItemCard(
                    title: "Pampers Swaddlers",
                    subtitle: "84 Diapers",
                    price: "345,00 EGP",
                    imageUrl:
                        "https://marketi.newcinderella.online/storage/banners/banner-2.jpg",
                    rating: 4.9,
                    quantity: 1,
                    // عند القيمة 1 يظهر زر الحذف سلة القمامة الحمراء تلقائياً
                    isFavorite: false,
                    onIncrement: () {},
                    onDecrement: () {},
                    onDelete: () {},
                    onFavoriteTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 107.h,
            color: AppColors.white,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Suptotal (3 items)",
                      style: getMediumStyle(
                        fontSize: 15.sp,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      "EGP 1,120,00",
                      style: getMediumStyle(
                        fontSize: 15.sp,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  data: "Checkout",
                  fontSize: 17.sp,
                  txtcolor: AppColors.white,
                  width: 300.w,
                  height: 50.h,
                  color: AppColors.lightBlue100,
                  onTap: () {
                    context.router.push(const CheckoutRoute());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
