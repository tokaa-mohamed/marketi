import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../generated/assets.dart';
import '../../../favorites/presentation/cubit/favourit_products_cubit.dart';
import '../../../favorites/presentation/cubit/favourit_products_states.dart';
import '../../../cart/presentation/cubit/cart_page_cubit.dart';
import '../../../cart/presentation/cubit/cart_page_states.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // CRITICAL: Use .value for GetIt Singletons to prevent them from closing
        BlocProvider.value(value: getIt<FavouritProductsCubit>()..init()),
        BlocProvider.value(value: getIt<CartPageCubit>()..getCartProducts()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<FavouritProductsCubit, FavouritProductsStates>(
            listener: (context, state) {
              if (state is AddFavoriteSuccessState) {
                _showSuccessSnackBar(context, state.message);
              } else if (state is FailGetFavouritProducts &&
                  state.message == "AuthRequired") {
                _showLoginDialog(context);
              }
            },
          ),
          BlocListener<CartPageCubit, CartPageStates>(
            listener: (context, state) {
              if (state is AddToCartSuccessState) {
                _showSuccessSnackBar(context, state.message);
              } else if (state is AddToCartErrorState &&
                  state.message == "AuthRequired") {
                _showLoginDialog(context);
              }
            },
          ),
        ],
        child: AutoTabsScaffold(
          routes: const [
            HomeRoute(),
            CartRoute(),
            FavoritesRoute(),
            MenuRoute(),
          ],
          bottomNavigationBuilder: (_, tabsRouter) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: (index) {
                  tabsRouter.setActiveIndex(index);
                  // Refresh data when switching tabs for immediate feedback
                  if (index == 1) getIt<CartPageCubit>().getCartProducts();
                  if (index == 2) {
                    getIt<FavouritProductsCubit>().getFavouritProducts();
                  }
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: AppColors.grey,
                selectedLabelStyle: getBoldStyle(
                    fontSize: 12.sp, color: AppColors.primaryColor),
                unselectedLabelStyle:
                    getRegularStyle(fontSize: 12.sp, color: AppColors.grey),
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Assets.icons.homeIcon.svg(
                        color: tabsRouter.activeIndex == 0
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        colorBlendMode: BlendMode.srcIn,
                        width: 24.w,
                      ),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Assets.icons.cartIcon.svg(
                        color: tabsRouter.activeIndex == 1
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        colorBlendMode: BlendMode.srcIn,
                        width: 24.w,
                      ),
                    ),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Assets.icons.heartIcon.svg(
                        color: tabsRouter.activeIndex == 2
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        colorBlendMode: BlendMode.srcIn,
                        width: 24.w,
                      ),
                    ),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Assets.icons.menuIcon.svg(
                        color: tabsRouter.activeIndex == 3
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        colorBlendMode: BlendMode.srcIn,
                        width: 24.w,
                      ),
                    ),
                    label: 'Menu',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars(); // Prevent overlapping
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Required'),
        content: const Text('Please login to continue.'),
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
