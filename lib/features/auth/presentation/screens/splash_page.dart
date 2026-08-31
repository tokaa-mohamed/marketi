import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketi/core/di.dart';
import 'package:marketi/core/routing/app_router.dart';
import 'package:marketi/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:marketi/features/auth/presentation/cubit/auth_state.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) async {
          await Future.delayed(const Duration(milliseconds: 800));
          if (!context.mounted) return;

          if (state is UserAuthenticated) {
            context.router.replaceAll([const HomeRoute()]);
          } else if (state is UserUnauthenticated) {
            context.router.replaceAll([const OnboardingRoute()]);
          }
        },
        builder: (context, state) {
          if (state is UserUnauthenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                context.router.replaceAll([const OnboardingRoute()]);
              }
            });
          } else if (state is UserAuthenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                context.router.replaceAll([const HomeRoute()]);
              }
            });
          }

          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/images/Logo_Splash_Screen.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}