import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di.dart';
import 'core/bloc observe/bloc_service.dart';
import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await initAppModule();
  
  Bloc.observer = MyBlocObserver();
  
  runApp(const MarketiApp());
}

class MarketiApp extends StatelessWidget {
  const MarketiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: appRouter.config(),
          debugShowCheckedModeBanner: false,
          title: 'Marketi',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3F80FF)),
            fontFamily: 'Poppins',
          ),
        );
      },
    );
  }
}
