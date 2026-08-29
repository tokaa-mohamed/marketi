import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:marketi/cart_page/domain/usecase/get_cart_products_usecase.dart';
import 'package:marketi/cart_page/presentation/cubit/cart_page_cubit.dart';
import 'package:marketi/favourit_page/data/data_source/favourit_products_remote_data_source.dart';
import 'package:marketi/favourit_page/data/repositories/favourit_products_repository_impl.dart';
import 'package:marketi/favourit_page/domain/repositories/favourit_products_repositories.dart';
import 'package:marketi/favourit_page/domain/usecases/get_favourit_products.dart';
import 'package:marketi/favourit_page/presentation/cubit/favourit_products_cubit.dart';
import 'save data/save_data.dart';
import 'security/security_helper.dart';
import 'api/dio_helper.dart';
import 'api/internet_connection_checker.dart';

final GetIt getIt = GetIt.instance;

Future<void> initAppModule() async {
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
  // ==================== Favourit Feature Dependencies ====================

  // 1. Data Source (استخدم الـ Concrete Class)
  getIt.registerLazySingleton<FavouritProductsRemoteDataSource>(
    () => FavouritProductsRemoteDataSource(),
  );

  // 2. Repository (ربط الواجهة بالـ Implementation)
  getIt.registerLazySingleton<FavouritProductsRepositories>(
    () => FavouritProductsRepositoryImpl(
      remoteDataSource: getIt<FavouritProductsRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // 3. Use Case
  getIt.registerLazySingleton<GetFavouritProductsUseCase>(
    () => GetFavouritProductsUseCase(
        repositorie: getIt<FavouritProductsRepositories>()),
  );

  getIt.registerFactory<FavouritProductsCubit>(
    () => FavouritProductsCubit(
      getIt<GetFavouritProductsUseCase>(),
    ),
  );
  getIt.registerFactory<CartPageCubit>(
    () => CartPageCubit(
      getIt<GetCartProductsUsecase>(),
    ),
  );
}
