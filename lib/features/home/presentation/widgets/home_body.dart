import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../core/routing/app_router.dart';
import '../../domain/entities/home_entity.dart';
import 'home_header.dart';
import 'home_search_bar.dart';
import 'banners_section.dart';
import 'popular_products_section.dart';
import 'categories_section.dart';
import 'brands_section.dart';
import 'product_list_section.dart';

class HomeBody extends StatelessWidget {
  final HomeDataEntity homeData;

  const HomeBody({super.key, required this.homeData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          const HomeHeader(),
          const HomeSearchBar(),
          if (homeData.banners.isNotEmpty)
            BannersSection(banners: homeData.banners),
          if (homeData.popularProducts.isNotEmpty)
            PopularProductsSection(products: homeData.popularProducts),
          if (homeData.categories.isNotEmpty)
            CategoriesSection(categories: homeData.categories),
          if (homeData.bestForYou.isNotEmpty)
            ProductListSection(
              title: 'Best for You',
              products: homeData.bestForYou,
              showAddButton: true,
              onViewAll: () {
                context.pushRoute(const BestForYouRoute());
              },
            ),
          if (homeData.brands.isNotEmpty)
            BrandsSection(brands: homeData.brands),
          if (homeData.buyAgain.isNotEmpty)
            ProductListSection(

              title: 'Buy Again',
              products: homeData.buyAgain,
              showAddButton: true,
              onViewAll: () {
                // Navigate to Buy Again page if implemented
              },
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
