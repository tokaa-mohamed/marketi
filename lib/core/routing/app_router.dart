import 'package:auto_route/auto_route.dart';
import 'package:marketi/core/routing/app_router.gr.dart';



@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: OnboardingRoute.page), 
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: VerifyOtpRoute.page),
         AutoRoute(page: CreateNewPasswordRoute.page,),

        AutoRoute(page: PasswordSuccessRoute.page,),
      ];
}