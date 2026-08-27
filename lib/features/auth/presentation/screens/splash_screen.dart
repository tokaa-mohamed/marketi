import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:marketi/core/routing/app_router.gr.dart'; 

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToOnboarding();
    });
  }

  void _navigateToOnboarding() {
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        context.router.replace(const OnboardingRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
        'assets/images/Logo_Splash_Screen.png',
        width: 200,
        height: 200,
        fit: BoxFit.contain,
      ),
        ),
      ),
    );
  }
}