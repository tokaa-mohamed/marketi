import 'package:auto_route/auto_route.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/inner_views/categories/presentation/pages/categories_page.dart';
import '../../features/home/inner_views/categories/presentation/pages/category_products_page.dart';
import '../../features/home/inner_views/categories/domain/entities/category_entity.dart';
import '../../features/home/inner_views/brands/presentation/pages/brands_page.dart';
import '../../features/home/inner_views/brands/presentation/pages/brand_products_page.dart';
import '../../features/home/inner_views/brands/domain/entities/brand_entity.dart';
import '../../features/home/inner_views/popular_products/presentation/pages/popular_products_page.dart';
import '../../features/home/inner_views/best_for_you/presentation/pages/best_for_you_page.dart';
import '../../features/product_details/presentation/pages/product_details_page.dart';
import '../../features/main/presentation/pages/main_page.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/menu/presentation/pages/menu_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MainRoute.page,
      initial: true,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: CartRoute.page),
        AutoRoute(page: FavoritesRoute.page),
        AutoRoute(page: MenuRoute.page),
      ],
    ),
    AutoRoute(page: CategoriesRoute.page),
    AutoRoute(page: CategoryProductsRoute.page),
    AutoRoute(page: BrandsRoute.page),
    AutoRoute(page: BrandProductsRoute.page),
    AutoRoute(page: PopularProductsRoute.page),
    AutoRoute(page: BestForYouRoute.page),
    AutoRoute(page: ProductDetailsRoute.page),
  ];
}
