import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:marketi/core/constant/custom_app_bar.dart';
import 'package:marketi/core/constant/custom_button.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/routing/app_router.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

import '../cubit/cart_page_cubit.dart';
import '../cubit/cart_page_states.dart';
import '../widgets/cart_item_card.dart';

@RoutePage()
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CartPageCubit>()..getCartProducts(),
      child: Scaffold(
        body: BlocConsumer<CartPageCubit, CartPageStates>(
          listener: (context, state) {
            if (state is GetCartPageErrorState) {
              if (state.error == "AuthRequired") {
                _showLoginDialog(context);
              }
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: 20.h),
                const SafeArea(child: CustomAppBar(title: "Cart")),
                SizedBox(height: 10.h),
                Expanded(
                  child: state is CartPageLoadingState
                      ? const Center(child: CircularProgressIndicator())
                      : state is GetCartPageSuccessState
                          ? CustomScrollView(
                              slivers: [
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
                                    child: Text(
                                      "Products on Cart",
                                      style: getMediumStyle(
                                        fontSize: 20.sp,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      final item = state.cartProductsModel[index];
                                      return CartItemCard(
                                        title: item.name,
                                        subtitle: "${item.stock_quantity} In stock",
                                        price: "${item.price} EGP",
                                        imageUrl: item.main_image,
                                        rating: item.rating,
                                        quantity: 1, // Assuming 1 for now
                                        isFavorite: false,
                                        onIncrement: () {},
                                        onDecrement: () {},
                                        onDelete: () {},
                                        onFavoriteTap: () {},
                                      );
                                    },
                                    childCount: state.cartProductsModel.length,
                                  ),
                                ),
                              ],
                            )
                          : const Center(child: Text("Your cart is empty")),
                ),
                if (state is GetCartPageSuccessState && state.cartProductsModel.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border(top: BorderSide(color: AppColors.borderColor)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Subtotal (${state.cartProductsModel.length} items)",
                              style: getMediumStyle(
                                fontSize: 15.sp,
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                              "${state.cartProductsModel.fold(0.0, (sum, item) => sum + item.price)} EGP",
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
            );
          },
        ),
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Required'),
        content: const Text('Please login to view your cart.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.router.push(const LoginRoute());
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
