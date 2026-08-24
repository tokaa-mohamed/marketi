import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../features/home/inner_views/best_for_you/data/data_sources/best_for_you_remote_data_source.dart';
import '../features/home/inner_views/best_for_you/data/repos/best_for_you_repo_impl.dart';
import '../features/home/inner_views/best_for_you/domain/repos/best_for_you_repo.dart';
import '../features/home/inner_views/best_for_you/domain/use_cases/get_best_for_you_use_case.dart';
import '../features/home/inner_views/best_for_you/presentation/cubit/best_for_you_cubit.dart';
import '../features/home/inner_views/brands/presentation/cubit/brands_cubit.dart';
import '../features/home/inner_views/categories/presentation/cubit/categories_cubit.dart';
import '../features/home/inner_views/popular_products/data/data_sources/popular_products_remote_data_source.dart';
import '../features/home/inner_views/popular_products/data/repos/popular_products_repo_impl.dart';
import '../features/home/inner_views/popular_products/domain/repos/popular_products_repo.dart';
import '../features/home/inner_views/popular_products/domain/use_cases/get_popular_products_use_case.dart';
import '../features/home/inner_views/popular_products/presentation/cubit/popular_products_cubit.dart';
import '../features/home/presentation/cubit/home_cubit.dart';
import '../features/product_details/presentation/cubit/product_details_cubit.dart';
import 'save data/save_data.dart';
import 'security/security_helper.dart';
import 'api/dio_helper.dart';
import 'api/internet_connection_checker.dart';
import '../../features/home/data/data_sources/home_remote_data_source.dart';
import '../../features/home/data/repos/home_repo_impl.dart';
import '../../features/home/domain/repos/home_repo.dart';
import '../../features/home/domain/use_cases/get_home_data_use_case.dart';
import '../../features/home/inner_views/categories/data/data_sources/categories_remote_data_source.dart';
import '../../features/home/inner_views/categories/data/repos/categories_repo_impl.dart';
import '../../features/home/inner_views/categories/domain/repos/categories_repo.dart';
import '../../features/home/inner_views/categories/domain/use_cases/get_categories_use_case.dart';
import '../../features/home/inner_views/categories/domain/use_cases/get_category_products_use_case.dart';
import '../../features/home/inner_views/brands/data/data_sources/brands_remote_data_source.dart';
import '../../features/home/inner_views/brands/data/repos/brands_repo_impl.dart';
import '../../features/home/inner_views/brands/domain/repos/brands_repo.dart';
import '../../features/home/inner_views/brands/domain/use_cases/get_brands_use_case.dart';
import '../../features/home/inner_views/brands/domain/use_cases/get_brand_products_use_case.dart';
import '../../features/product_details/data/data_sources/product_details_remote_data_source.dart';
import '../../features/product_details/data/repos/product_details_repo_impl.dart';
import '../../features/product_details/domain/repos/product_details_repo.dart';
import '../../features/product_details/domain/use_cases/get_product_details_use_case.dart';
import 'routing/app_router.dart';

final GetIt getIt = GetIt.instance;

Future<void> initAppModule() async {
  // Core
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

  await DioHelper.init();
  getIt.registerLazySingleton<DioHelper>(() => DioHelper());

  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<InternetConnectionChecker>()),
  );

  // Home Feature
  getIt.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl());
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
    remoteDataSource: getIt(),
    networkInfo: getIt(),
  ));
  getIt.registerLazySingleton<GetHomeDataUseCase>(() => GetHomeDataUseCase(getIt()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

  // Categories Feature
  getIt.registerLazySingleton<CategoriesRemoteDataSource>(
    () => CategoriesRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetCategoryProductsUseCase>(
    () => GetCategoryProductsUseCase(getIt()),
  );
  getIt.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(getIt(), getIt()),
  );

  // Brands Feature
  getIt.registerLazySingleton<BrandsRemoteDataSource>(
    () => BrandsRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<BrandsRepository>(
    () => BrandsRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<GetBrandsUseCase>(
    () => GetBrandsUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetBrandProductsUseCase>(
    () => GetBrandProductsUseCase(getIt()),
  );
  getIt.registerFactory<BrandsCubit>(
    () => BrandsCubit(getIt(), getIt()),
  );

  // Popular Products Feature
  getIt.registerLazySingleton<PopularProductsRemoteDataSource>(
    () => PopularProductsRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<PopularProductsRepository>(
    () => PopularProductsRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<GetPopularProductsUseCase>(
    () => GetPopularProductsUseCase(getIt()),
  );
  getIt.registerFactory<PopularProductsCubit>(
    () => PopularProductsCubit(getIt()),
  );

  // Best For You Feature
  getIt.registerLazySingleton<BestForYouRemoteDataSource>(
    () => BestForYouRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<BestForYouRepository>(
    () => BestForYouRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<GetBestForYouUseCase>(
    () => GetBestForYouUseCase(getIt()),
  );
  getIt.registerFactory<BestForYouCubit>(
    () => BestForYouCubit(getIt()),
  );

  // Product Details Feature
  getIt.registerLazySingleton<ProductDetailsRemoteDataSource>(
    () => ProductDetailsRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<ProductDetailsRepository>(
    () => ProductDetailsRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );
  getIt.registerLazySingleton<GetProductDetailsUseCase>(
    () => GetProductDetailsUseCase(getIt()),
  );
  getIt.registerFactory<ProductDetailsCubit>(
    () => ProductDetailsCubit(getIt()),
  );
}
