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
import '../cubit/brands_cubit.dart';
import '../cubit/brands_state.dart';
import '../widgets/brands_body.dart';
import '../../domain/entities/brands_dummy_data.dart';

@RoutePage()
class BrandsPage extends StatelessWidget {
  const BrandsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<BrandsCubit>()..getBrands()),
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
                child: Icon(Icons.arrow_back_ios_new,
                    size: 18.sp, color: AppColors.secondaryColor),
              ),
            ),
          ),
          title: Text(
            'Brands',
            style: getBoldStyle(
                fontSize: AppFonts.s18.sp, color: AppColors.secondaryColor),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.only(end: 16.w),
              child: CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColors.greychip,
                child: Icon(Icons.person,
                    color: AppColors.secondaryColor, size: 20.sp),
              ),
            ),
          ],
        ),
        body: BlocBuilder<BrandsCubit, BrandsState>(
          builder: (context, state) {
            if (state is BrandsLoading || state is BrandsSuccess) {
              final brands = state is BrandsSuccess
                  ? state.brands
                  : BrandsDummyData.brands;
              return Skeletonizer(
                enabled: state is BrandsLoading,
                child: BrandsBody(brands: brands),
              );
            } else if (state is BrandsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
