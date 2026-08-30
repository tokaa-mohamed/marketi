import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/constant/custom_button.dart';
import '../../domain/entities/product_entity.dart';
import '../../../favorites/presentation/cubit/favourit_products_cubit.dart';
import '../../../favorites/presentation/cubit/favourit_products_states.dart';
import '../../../cart/presentation/cubit/cart_page_cubit.dart';

class ProductItem extends StatefulWidget {
  final ProductEntity product;
  final bool showAddButton;

  const ProductItem({
    super.key,
    required this.product,
    this.showAddButton = false,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final favoritesCubit = context.watch<FavouritProductsCubit>();
    final isFav = favoritesCubit.isFavorite(widget.product.id);

    return BlocListener<FavouritProductsCubit, FavouritProductsStates>(
      listenWhen: (previous, current) =>
          current is AddFavoriteErrorState || 
          current is AddFavoriteSuccessState ||
          (current is FailGetFavouritProducts && current.message == "AuthRequired"),
      listener: (context, state) {
        // No local state to rollback, context.watch handles UI
      },
      child: GestureDetector(
        onTap: () {
          context.pushRoute(ProductDetailsRoute(productId: widget.product.id));
        },
        child: Container(
          width: 160.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                    child: Image.network(
                      widget.product.image,
                      height: 120.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  if (widget.product.discount != null)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          '${widget.product.discount}% OFF',
                          style: getRegularStyle(
                              fontSize: 10.sp, color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<FavouritProductsCubit>()
                            .addFavorite(widget.product.id);
                      },
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav
                            ? AppColors.secondaryColor
                            : AppColors.grey,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.product.price} LE',
                      style: getBoldStyle(
                          fontSize: AppFonts.s14.sp,
                          color: AppColors.secondaryColor),
                    ),
                    Text(
                      widget.product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: getRegularStyle(
                          fontSize: AppFonts.s12.sp,
                          color: AppColors.secondaryColor),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        SizedBox(width: 4.w),
                        Text(
                          widget.product.rating.toString(),
                          style: getRegularStyle(
                              fontSize: 12.sp, color: AppColors.secondaryColor),
                        ),
                      ],
                    ),
                    if (widget.showAddButton) ...[
                      SizedBox(height: 8.h),
                      CustomButton(
                        data: 'Add',
                        height: 32.h,
                        fontSize: 12.sp,
                        color: AppColors.white,
                        bordercolor: AppColors.primaryColor,
                        txtcolor: AppColors.primaryColor,
                        onTap: () {
                          context
                              .read<CartPageCubit>()
                              .addToCart(productId: widget.product.id);
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
