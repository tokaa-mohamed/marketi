import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../generated/assets.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
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
            onTap: tabsRouter.setActiveIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: AppColors.grey,
            selectedLabelStyle: getBoldStyle(fontSize: 12.sp, color: AppColors.primaryColor),
            unselectedLabelStyle: getRegularStyle(fontSize: 12.sp, color: AppColors.grey),
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
    );
  }
}
