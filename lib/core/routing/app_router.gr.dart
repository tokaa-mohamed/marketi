// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [BestForYouPage]
class BestForYouRoute extends PageRouteInfo<void> {
  const BestForYouRoute({List<PageRouteInfo>? children})
    : super(BestForYouRoute.name, initialChildren: children);

  static const String name = 'BestForYouRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BestForYouPage();
    },
  );
}

/// generated route for
/// [BrandProductsPage]
class BrandProductsRoute extends PageRouteInfo<BrandProductsRouteArgs> {
  BrandProductsRoute({
    Key? key,
    required BrandEntity brand,
    List<PageRouteInfo>? children,
  }) : super(
         BrandProductsRoute.name,
         args: BrandProductsRouteArgs(key: key, brand: brand),
         initialChildren: children,
       );

  static const String name = 'BrandProductsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BrandProductsRouteArgs>();
      return BrandProductsPage(key: args.key, brand: args.brand);
    },
  );
}

class BrandProductsRouteArgs {
  const BrandProductsRouteArgs({this.key, required this.brand});

  final Key? key;

  final BrandEntity brand;

  @override
  String toString() {
    return 'BrandProductsRouteArgs{key: $key, brand: $brand}';
  }
}

/// generated route for
/// [BrandsPage]
class BrandsRoute extends PageRouteInfo<void> {
  const BrandsRoute({List<PageRouteInfo>? children})
    : super(BrandsRoute.name, initialChildren: children);

  static const String name = 'BrandsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BrandsPage();
    },
  );
}

/// generated route for
/// [CartPage]
class CartRoute extends PageRouteInfo<void> {
  const CartRoute({List<PageRouteInfo>? children})
    : super(CartRoute.name, initialChildren: children);

  static const String name = 'CartRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CartPage();
    },
  );
}

/// generated route for
/// [CategoriesPage]
class CategoriesRoute extends PageRouteInfo<void> {
  const CategoriesRoute({List<PageRouteInfo>? children})
    : super(CategoriesRoute.name, initialChildren: children);

  static const String name = 'CategoriesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CategoriesPage();
    },
  );
}

/// generated route for
/// [CategoryProductsPage]
class CategoryProductsRoute extends PageRouteInfo<CategoryProductsRouteArgs> {
  CategoryProductsRoute({
    Key? key,
    required CategoryEntity category,
    List<PageRouteInfo>? children,
  }) : super(
         CategoryProductsRoute.name,
         args: CategoryProductsRouteArgs(key: key, category: category),
         initialChildren: children,
       );

  static const String name = 'CategoryProductsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoryProductsRouteArgs>();
      return CategoryProductsPage(key: args.key, category: args.category);
    },
  );
}

class CategoryProductsRouteArgs {
  const CategoryProductsRouteArgs({this.key, required this.category});

  final Key? key;

  final CategoryEntity category;

  @override
  String toString() {
    return 'CategoryProductsRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [FavoritesPage]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoritesPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainPage();
    },
  );
}

/// generated route for
/// [MenuPage]
class MenuRoute extends PageRouteInfo<void> {
  const MenuRoute({List<PageRouteInfo>? children})
    : super(MenuRoute.name, initialChildren: children);

  static const String name = 'MenuRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MenuPage();
    },
  );
}

/// generated route for
/// [PopularProductsPage]
class PopularProductsRoute extends PageRouteInfo<void> {
  const PopularProductsRoute({List<PageRouteInfo>? children})
    : super(PopularProductsRoute.name, initialChildren: children);

  static const String name = 'PopularProductsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PopularProductsPage();
    },
  );
}

/// generated route for
/// [ProductDetailsPage]
class ProductDetailsRoute extends PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    Key? key,
    required int productId,
    List<PageRouteInfo>? children,
  }) : super(
         ProductDetailsRoute.name,
         args: ProductDetailsRouteArgs(key: key, productId: productId),
         initialChildren: children,
       );

  static const String name = 'ProductDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailsRouteArgs>();
      return ProductDetailsPage(key: args.key, productId: args.productId);
    },
  );
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({this.key, required this.productId});

  final Key? key;

  final int productId;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, productId: $productId}';
  }
}
