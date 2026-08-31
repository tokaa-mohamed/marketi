import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'core/di.dart';
import 'core/bloc observe/bloc_service.dart';
import 'core/notifcation/fcm_service.dart';
import 'core/notifcation/notification_helper.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp();
    String? token = await FirebaseMessaging.instance.getToken();
    if (kDebugMode) {
      print("FCM Token: $token");
    }
  }
  await initAppModule();
  final FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();
  await NotificationHelper.initialize(fln);
  await FcmService.initialize();
  Bloc.observer = MyBlocObserver();

  runApp(const MarketiApp());
}

class MarketiApp extends StatelessWidget {
  const MarketiApp({super.key});

  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => getIt<ThemeCubit>(),
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, ThemeMode themeMode) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Marketi',
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeMode,
                routerConfig: _appRouter.config(),
              );
            },
          ),
        );
      },
    );
  }
}
