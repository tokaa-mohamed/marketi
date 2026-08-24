import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../core/di.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_fonts.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../cubit/categories_cubit.dart';
import '../cubit/categories_state.dart';
import '../widgets/categories_body.dart';
import '../../domain/entities/categories_dummy_data.dart';

@RoutePage()
class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CategoriesCubit>()..getCategories(),
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
            'Categories',
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
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoading || state is CategoriesSuccess) {
              final categories = state is CategoriesSuccess
                  ? state.categories
                  : CategoriesDummyData.categories;
              return Skeletonizer(
                enabled: state is CategoriesLoading,
                child: CategoriesBody(categories: categories),
              );
            } else if (state is CategoriesError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
