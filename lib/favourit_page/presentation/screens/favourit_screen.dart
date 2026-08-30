import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:marketi/core/constant/custom_app_bar.dart';
import 'package:marketi/core/constant/custom_toast.dart';

import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';
import 'package:marketi/favourit_page/presentation/cubit/favourit_products_cubit.dart';
import 'package:marketi/favourit_page/presentation/cubit/favourit_products_states.dart';
import 'package:marketi/favourit_page/presentation/widgets/custom_bottom_bar.dart';
import 'package:marketi/favourit_page/presentation/widgets/custom_favourit_items.dart';
import 'package:marketi/favourit_page/presentation/widgets/custom_text_field.dart';
import 'package:marketi/favourit_page/presentation/widgets/nav_bottom_bar_icon.dart';

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
              child:
                  BlocConsumer<FavouritProductsCubit, FavouritProductsStates>(
                      builder: (context, state) {
            if (state is GetFavouritProductsLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetFavouritPProductsSuccessfulState) {
              return CustomScrollView(
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
                            final products = state.favouritProducts[index];
                            return FavouritItemsWidget(
                              name: products.name,
                              price: products.price,
                              rating: products.rating,
                              mainImage: products.main_image,
                            );
                          },
                          childCount: state.favouritProducts.length,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12.h,
                            crossAxisSpacing: 12.w,
                            childAspectRatio: 0.7)),
                  )
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }, listener: (context, state) {
            if (state is FailGetFavouritProducts) {
              CustomToast.showWarning(state.message);
            }
          })),
          CustomBottomBar()
        ],
      ),
    );
  }
}
