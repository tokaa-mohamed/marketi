import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/foundation.dart';

import 'api/dio_helper.dart';
import 'api/internet_connection_checker.dart';
import 'routing/app_router.dart';
import 'save data/save_data.dart';
import 'security/security_helper.dart';
import 'theme/theme_cubit.dart';

// Auth
import '../features/auth/data/datasources/auth_data_source.dart';
import '../features/auth/data/repos/auth_repo_impl.dart';
import '../features/auth/domain/repos/auth_repo.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/auth/presentation/cubit/forget_password_cubit.dart';

// Home & Sub-features
import '../features/home/data/data_sources/home_remote_data_source.dart';
import '../features/home/data/repos/home_repo_impl.dart';
import '../features/home/domain/repos/home_repo.dart';
import '../features/home/domain/use_cases/get_home_data_use_case.dart';
import '../features/home/inner_views/best_for_you/data/data_sources/best_for_you_remote_data_source.dart';
import '../features/home/inner_views/best_for_you/data/repos/best_for_you_repo_impl.dart';
import '../features/home/inner_views/best_for_you/domain/repos/best_for_you_repo.dart';
import '../features/home/inner_views/best_for_you/domain/use_cases/get_best_for_you_use_case.dart';
import '../features/home/inner_views/best_for_you/presentation/cubit/best_for_you_cubit.dart';
import '../features/home/inner_views/brands/data/data_sources/brands_remote_data_source.dart';
import '../features/home/inner_views/brands/data/repos/brands_repo_impl.dart';
import '../features/home/inner_views/brands/domain/repos/brands_repo.dart';
import '../features/home/inner_views/brands/domain/use_cases/get_brands_use_case.dart';
import '../features/home/inner_views/brands/domain/use_cases/get_brand_products_use_case.dart';
import '../features/home/inner_views/brands/presentation/cubit/brands_cubit.dart';
import '../features/home/inner_views/categories/data/data_sources/categories_remote_data_source.dart';
import '../features/home/inner_views/categories/data/repos/categories_repo_impl.dart';
import '../features/home/inner_views/categories/domain/repos/categories_repo.dart';
import '../features/home/inner_views/categories/domain/use_cases/get_categories_use_case.dart';
import '../features/home/inner_views/categories/domain/use_cases/get_category_products_use_case.dart';
import '../features/home/inner_views/categories/presentation/cubit/categories_cubit.dart';
import '../features/home/inner_views/popular_products/data/data_sources/popular_products_remote_data_source.dart';
import '../features/home/inner_views/popular_products/data/repos/popular_products_repo_impl.dart';
import '../features/home/inner_views/popular_products/domain/repos/popular_products_repo.dart';
import '../features/home/inner_views/popular_products/domain/use_cases/get_popular_products_use_case.dart';
import '../features/home/inner_views/popular_products/presentation/cubit/popular_products_cubit.dart';
import '../features/home/presentation/cubit/home_cubit.dart';

// Product Details
import '../features/product_details/data/data_sources/product_details_remote_data_source.dart';
import '../features/product_details/data/repos/product_details_repo_impl.dart';
import '../features/product_details/domain/repos/product_details_repo.dart';
import '../features/product_details/domain/use_cases/get_product_details_use_case.dart';
import '../features/product_details/presentation/cubit/product_details_cubit.dart';

// Favorites
import '../features/favorites/data/data_source/favourit_products_remote_data_source.dart';
import '../features/favorites/data/repositories/favourit_products_repository_impl.dart';
import '../features/favorites/domain/repositories/favourit_products_repositories.dart';
import '../features/favorites/domain/usecases/get_favourit_products.dart';
import '../features/favorites/presentation/cubit/favourit_products_cubit.dart';

// Cart
import '../features/cart/data/data_source/data_source_for_cart_products.dart';
import '../features/cart/data/repositories/cart_products_repository_impl.dart';
import '../features/cart/domain/repositories/cart_products_repository.dart';
import '../features/cart/domain/usecase/get_cart_products_usecase.dart';
import '../features/cart/presentation/cubit/cart_page_cubit.dart';

// Profile
import '../features/profile/data/datasources/profile_datasource.dart';
import '../features/profile/data/datasources/remote_datasource_impl.dart';
import '../features/profile/data/repos/profile_repo_impl.dart';
import '../features/profile/domain/repos/profile_repo.dart';
import '../features/profile/presentation/cubit/profile_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> initAppModule() async {
  // --- Core ---
  getIt.registerSingleton<AppRouter>(AppRouter());
  
  final cacheHelper = CacheHelper();
  await cacheHelper.init();
  getIt.registerLazySingleton<CacheHelper>(() => cacheHelper);

  final securityHelper = SecurityHelper();
  getIt.registerLazySingleton<SecurityHelper>(() => securityHelper);

  final authStorage = AuthStorage(getIt<SecurityHelper>());
  await authStorage.migrateFromCacheIfNeeded(cacheHelper);
  await authStorage.loadFromSecure();
  getIt.registerLazySingleton<AuthStorage>(() => authStorage);

  final dio = Dio();
  getIt.registerLazySingleton<Dio>(() => dio);
  
  final dioHelper = DioHelper(getIt<Dio>());
  dioHelper.setup();
  getIt.registerLazySingleton<DioHelper>(() => dioHelper);

  if (!kIsWeb) {
    getIt.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker.createInstance(),
    );
  }

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      kIsWeb ? null : getIt<InternetConnectionChecker>(),
    ),
  );

  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());

  // --- Auth Feature ---
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<DioHelper>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
getIt.registerLazySingleton<AuthCubit>(
  () => AuthCubit(getIt<AuthRepository>()),
);
  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(getIt<AuthRepository>()),
  );

  // --- Home Feature ---
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(getIt<DioHelper>()),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: getIt<HomeRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  getIt.registerLazySingleton<GetHomeDataUseCase>(
    () => GetHomeDataUseCase(getIt<HomeRepository>()),
  );
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<GetHomeDataUseCase>()));

  // --- Categories Feature ---
  getIt.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(getIt<DioHelper>()),
  );
  getIt.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(
      remoteDataSource: getIt<CategoriesRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt<CategoriesRepository>()),
  );
  getIt.registerLazySingleton<GetCategoryProductsUseCase>(
    () => GetCategoryProductsUseCase(getIt<CategoriesRepository>()),
  );
  getIt.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(getIt<GetCategoriesUseCase>(), getIt<GetCategoryProductsUseCase>()),
  );

  // --- Brands Feature ---
  getIt.registerLazySingleton<BrandsRemoteDataSource>(
    () => BrandsRemoteDataSourceImpl(getIt<DioHelper>()),
  );
  getIt.registerLazySingleton<BrandsRepository>(
    () => BrandsRepositoryImpl(
      remoteDataSource: getIt<BrandsRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  getIt.registerLazySingleton<GetBrandsUseCase>(
    () => GetBrandsUseCase(getIt<BrandsRepository>()),
  );
  getIt.registerLazySingleton<GetBrandProductsUseCase>(
    () => GetBrandProductsUseCase(getIt<BrandsRepository>()),
  );
  getIt.registerFactory<BrandsCubit>(
    () => BrandsCubit(getIt<GetBrandsUseCase>(), getIt<GetBrandProductsUseCase>()),
  );

  // --- Popular Products Feature ---
  getIt.registerLazySingleton<PopularProductsRemoteDataSource>(
    () => PopularProductsRemoteDataSourceImpl(getIt<DioHelper>()),
  );
  getIt.registerLazySingleton<PopularProductsRepository>(
    () => PopularProductsRepositoryImpl(
      remoteDataSource: getIt<PopularProductsRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  getIt.registerLazySingleton<GetPopularProductsUseCase>(
    () => GetPopularProductsUseCase(getIt<PopularProductsRepository>()),
  );
  getIt.registerFactory<PopularProductsCubit>(
    () => PopularProductsCubit(getIt<GetPopularProductsUseCase>()),
  );

  // --- Best For You Feature ---
  getIt.registerLazySingleton<BestForYouRemoteDataSource>(
    () => BestForYouRemoteDataSourceImpl(getIt<DioHelper>()),
  );
  getIt.registerLazySingleton<BestForYouRepository>(
    () => BestForYouRepositoryImpl(
      remoteDataSource: getIt<BestForYouRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  getIt.registerLazySingleton<GetBestForYouUseCase>(
    () => GetBestForYouUseCase(getIt<BestForYouRepository>()),
  );
  getIt.registerFactory<BestForYouCubit>(
    () => BestForYouCubit(getIt<GetBestForYouUseCase>()),
  );

  // --- Favorite Products Feature ---
  getIt.registerLazySingleton<FavouritProductsRemoteDataSource>(
    () => FavouritProductsRemoteDataSource(getIt<DioHelper>()),
  );
  getIt.registerLazySingleton<FavouritProductsRepositories>(
    () => FavouritProductsRepositoryImpl(
      remoteDataSource: getIt<FavouritProductsRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  getIt.registerLazySingleton<GetFavouritProductsUseCase>(
    () => GetFavouritProductsUseCase(repositorie: getIt<FavouritProductsRepositories>()),
  );
  getIt.registerFactory<FavouritProductsCubit>(
    () => FavouritProductsCubit(getIt<GetFavouritProductsUseCase>()),
  );

  // --- Cart Feature ---
  getIt.registerLazySingleton<CartProductsRemoteDataSource>(
    () => CartProductsRemoteDataSource(getIt<DioHelper>()),
  );
  getIt.registerLazySingleton<CartProductsRepository>(
    () => CartProductsRepositoryImpl(
      remoteDataSource: getIt<CartProductsRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  getIt.registerLazySingleton<GetCartProductsUsecase>(
    () => GetCartProductsUsecase(repository: getIt<CartProductsRepository>()),
  );
  getIt.registerFactory<CartPageCubit>(
    () => CartPageCubit(getIt<GetCartProductsUsecase>()),
  );

  // --- Product Details Feature ---
  getIt.registerLazySingleton<ProductDetailsRemoteDataSource>(
    () => ProductDetailsRemoteDataSourceImpl(getIt<DioHelper>()),
  );
  getIt.registerLazySingleton<ProductDetailsRepository>(
    () => ProductDetailsRepositoryImpl(
      remoteDataSource: getIt<ProductDetailsRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  getIt.registerLazySingleton<GetProductDetailsUseCase>(
    () => GetProductDetailsUseCase(getIt<ProductDetailsRepository>()),
  );
  getIt.registerFactory<ProductDetailsCubit>(
    () => ProductDetailsCubit(getIt<GetProductDetailsUseCase>()),
  );

  // --- Profile Feature ---
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(dioHelper: getIt<DioHelper>()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: getIt<ProfileRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(profileRepository: getIt<ProfileRepository>()),
  );
}
