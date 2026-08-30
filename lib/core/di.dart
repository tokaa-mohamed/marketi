import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:marketi/core/theme/theme_cubit.dart';
import 'package:marketi/features/auth/data/datasources/auth_data_source.dart';
import 'package:marketi/features/auth/data/repos/auth_repo_impl.dart';
import 'package:marketi/features/auth/domain/repos/auth_repo.dart';
import 'package:marketi/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:marketi/features/auth/presentation/cubit/forget_password_cubit.dart';
import 'package:marketi/features/profile/data/datasources/profile_datasource.dart';
import 'package:marketi/features/profile/data/datasources/remote_datasource_impl.dart';
import 'package:marketi/features/profile/data/repos/profile_repo_impl.dart';
import 'package:marketi/features/profile/domain/repos/profile_repo.dart';
import 'package:marketi/features/profile/presentation/cubit/profile_cubit.dart';
import 'save data/save_data.dart';
import 'security/security_helper.dart';
import 'api/dio_helper.dart';
import 'api/internet_connection_checker.dart';

import 'package:flutter/foundation.dart'; 


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


getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt<AuthRepository>()),
  );

  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(getIt<AuthRepository>()),
  );

// 1. Data Source
// 1. Data Source
// 1. Data Source
getIt.registerLazySingleton<ProfileRemoteDataSource>(
  () => ProfileRemoteDataSourceImpl(dioHelper: getIt<DioHelper>()),
);
// 2. Repository
getIt.registerLazySingleton<ProfileRepository>(
  () => ProfileRepositoryImpl(
    remoteDataSource: getIt<ProfileRemoteDataSource>(),
    networkInfo: getIt<NetworkInfo>(),
  ),
);

// 3. Cubit
getIt.registerFactory<ProfileCubit>(
  () => ProfileCubit(profileRepository: getIt<ProfileRepository>()),
); 

getIt.registerFactory(() => ThemeCubit());

 }
