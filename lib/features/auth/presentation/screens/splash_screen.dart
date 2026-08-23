import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:marketi/core/constant/custom_svg_image.dart';
import 'package:marketi/core/routing/app_router.gr.dart'; 
import 'package:marketi/generated/assets.dart';

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
    _navigateToOnboarding();
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
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CustomSvgImage(
          path: Assets.images.logo.path, 
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}