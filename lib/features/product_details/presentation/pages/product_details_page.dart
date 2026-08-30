import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/constant/custom_button.dart';
import '../../../../core/di.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_styles.dart';
import '../cubit/product_details_cubit.dart';
import '../cubit/product_details_state.dart';
import '../widgets/product_details_body.dart';
import '../../domain/entities/product_details_dummy_data.dart';

import '../../../cart/presentation/cubit/cart_page_cubit.dart';
import '../../../cart/presentation/cubit/cart_page_states.dart';
import '../../../favorites/presentation/cubit/favourit_products_cubit.dart';

@RoutePage()
class ProductDetailsPage extends StatefulWidget {
  final int productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String selectedSize = "M";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<ProductDetailsCubit>()..getProductDetails(widget.productId),
        ),
        BlocProvider.value(value: getIt<CartPageCubit>()),
        BlocProvider.value(value: getIt<FavouritProductsCubit>()..init()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(8.r),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18.sp,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
          title: Text(
            'Product Details',
            style: getBoldStyle(
              fontSize: AppFonts.s18.sp,
              color: AppColors.secondaryColor,
            ),
          ),
          centerTitle: true,
          actions: [
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.router.push(const CartRoute());
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: AppColors.primaryColor,
                    size: 24.sp,
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading ||
                state is ProductDetailsSuccess) {
              final product = state is ProductDetailsSuccess
                  ? state.product
                  : ProductDetailsDummyData.product;
              return Skeletonizer(
                enabled: state is ProductDetailsLoading,
                child: ProductDetailsBody(
                  product: product,
                  onSizeSelected: (size) {
                    setState(() {
                      selectedSize = size;
                    });
                  },
                ),
              );
            } else if (state is ProductDetailsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
        bottomNavigationBar: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading ||
                state is ProductDetailsSuccess) {
              final product = state is ProductDetailsSuccess
                  ? state.product
                  : ProductDetailsDummyData.product;
              return BlocBuilder<CartPageCubit, CartPageStates>(
                builder: (context, cartState) {
                  return Skeletonizer(
                    enabled: state is ProductDetailsLoading,
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border(
                          top: BorderSide(color: AppColors.borderColor),
                        ),
                      ),
                      child: Row(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                style: getBoldStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                              Text(
                                '${product.price} EGP',
                                style: getBoldStyle(
                                  fontSize: 18.sp,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: CustomButton(
                              data: 'Add to Cart',
                              isLoading: cartState is AddToCartLoadingState,
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                color: AppColors.primaryColor,
                                size: 20.sp,
                              ),
                              color: AppColors.white,
                              bordercolor: AppColors.primaryColor,
                              txtcolor: AppColors.primaryColor,
                              onTap: () {
                                context.read<CartPageCubit>().addToCart(
                                  productId: product.id,
                                  size: selectedSize,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
