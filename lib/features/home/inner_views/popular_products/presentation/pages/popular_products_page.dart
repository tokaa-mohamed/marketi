import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../core/di.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../cart/presentation/cubit/cart_page_cubit.dart';
import '../../../../../favorites/presentation/cubit/favourit_products_cubit.dart';
import '../../../../domain/entities/products_dummy_data.dart';
import '../../../../presentation/widgets/products_grid_body.dart';
import '../cubit/popular_products_cubit.dart';
import '../cubit/popular_products_state.dart';

@RoutePage()
class PopularProductsPage extends StatelessWidget {
  const PopularProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<PopularProductsCubit>()..getPopularProducts(),
        ),
        // CRITICAL: Use .value for singletons
        BlocProvider.value(value: getIt<FavouritProductsCubit>()..init()),
        BlocProvider.value(value: getIt<CartPageCubit>()),
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
            'Popular Product',
            style: getBoldStyle(
              fontSize: AppFonts.s18.sp,
              color: AppColors.secondaryColor,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<PopularProductsCubit, PopularProductsState>(
          builder: (context, state) {
            if (state is PopularProductsLoading ||
                state is PopularProductsSuccess) {
              final products = state is PopularProductsSuccess
                  ? state.products
                  : ProductsDummyData.products;
              return Skeletonizer(
                enabled: state is PopularProductsLoading,
                child: ProductsGridBody(products: products),
              );
            } else if (state is PopularProductsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
