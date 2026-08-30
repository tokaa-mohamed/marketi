import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
import '../../features/checkout/presentation/screens/checkout_page.dart';

import '../../features/auth/presentation/screens/splash_page.dart';
import '../../features/auth/presentation/screens/onboarding_page.dart';
import '../../features/auth/presentation/screens/login_page.dart';
import '../../features/auth/presentation/screens/register_page.dart';
import '../../features/auth/presentation/screens/forget_password_page.dart';
import '../../features/auth/presentation/screens/verify_otp_page.dart';
import '../../features/auth/presentation/screens/create_new_password_page.dart';
import '../../features/auth/presentation/screens/password_success_page.dart';

import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/subscription_payment_page.dart';
import '../../features/profile/presentation/pages/account_preferences_page.dart';
import '../../features/profile/presentation/pages/support_page.dart';
import '../../features/profile/presentation/pages/profile_drawer_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Auth Flow
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: VerifyOtpRoute.page),
    AutoRoute(page: CreateNewPasswordRoute.page),
    AutoRoute(page: PasswordSuccessRoute.page),

    // Main App with Tabs
    AutoRoute(
      page: MainRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: CartRoute.page),
        AutoRoute(page: FavoritesRoute.page),
        AutoRoute(page: MenuRoute.page),
      ],
    ),

    // Inner Views & Details
    AutoRoute(page: CategoriesRoute.page),
    AutoRoute(page: CategoryProductsRoute.page),
    AutoRoute(page: BrandsRoute.page),
    AutoRoute(page: BrandProductsRoute.page),
    AutoRoute(page: PopularProductsRoute.page),
    AutoRoute(page: BestForYouRoute.page),
    AutoRoute(page: ProductDetailsRoute.page),
    AutoRoute(page: CheckoutRoute.page),

    // Profile Pages
    AutoRoute(page: ProfileRoute.page),
    AutoRoute(page: SubscriptionAndPaymentRoute.page),
    AutoRoute(page: AccountPreferencesRoute.page),
    AutoRoute(page: SupportRoute.page),
    AutoRoute(page: ProfileDrawerRoute.page),
  ];
}
