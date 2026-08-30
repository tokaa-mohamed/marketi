import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:marketi/core/constant/custom_app_bar.dart';
import 'package:marketi/core/routing/app_router.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

import '../../../cart/presentation/cubit/cart_page_cubit.dart';
import '../../data/models/favourit_products_model.dart';
import '../cubit/favourit_products_cubit.dart';
import '../cubit/favourit_products_states.dart';
import '../widgets/custom_favourit_items.dart';
import '../widgets/custom_text_field.dart';

@RoutePage()
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SafeArea(child: CustomAppBar(title: "Favorite")),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            child: CustomTextField(controller: controller),
          ),
          Expanded(
            child: BlocBuilder<FavouritProductsCubit, FavouritProductsStates>(
              builder: (context, state) {
                if (state is GetFavouritProductsLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetFavouritPProductsSuccessfulState) {
                  if (state.favouritProducts.isEmpty) {
                    return const Center(child: Text("No favorites yet"));
                  }
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w, bottom: 10.h),
                          child: Text(
                            "All Products",
                            style: getMediumStyle(
                              fontSize: 18.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = state.favouritProducts[index];
                              final product = item as FavouritProductsModel;
                              return FavouritItemsWidget(
                                name: product.name,
                                price: product.price,
                                rating: product.rating,
                                mainImage: product.main_image,
                                onAddTap: () {
                                  context.read<CartPageCubit>().addToCart(
                                        productId: product.productId,
                                      );
                                },
                              );
                            },
                            childCount: state.favouritProducts.length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12.h,
                            crossAxisSpacing: 12.w,
                            childAspectRatio: 0.7,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const Center(
                    child: Text("Start adding your favorite products!"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
