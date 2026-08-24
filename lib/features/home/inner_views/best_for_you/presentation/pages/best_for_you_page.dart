import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../core/di.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../domain/entities/products_dummy_data.dart';
import '../../../../presentation/widgets/products_grid_body.dart';
import '../cubit/best_for_you_cubit.dart';
import '../cubit/best_for_you_state.dart';

@RoutePage()
class BestForYouPage extends StatelessWidget {
  const BestForYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BestForYouCubit>()..getBestForYouProducts(),
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
                child: Icon(Icons.arrow_back_ios_new, size: 18.sp, color: AppColors.secondaryColor),
              ),
            ),
          ),
          title: Text(
            'Best for You',
            style: getBoldStyle(fontSize: AppFonts.s18.sp, color: AppColors.secondaryColor),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<BestForYouCubit, BestForYouState>(
          builder: (context, state) {
            if (state is BestForYouLoading || state is BestForYouSuccess) {
              final products = state is BestForYouSuccess 
                  ? state.products 
                  : ProductsDummyData.products;
              return Skeletonizer(
                enabled: state is BestForYouLoading,
                child: ProductsGridBody(products: products),
              );
            } else if (state is BestForYouError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
