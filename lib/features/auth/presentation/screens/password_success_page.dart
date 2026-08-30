import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketi/core/routing/app_router.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';
import 'package:marketi/generated/assets.dart';

@RoutePage()
class PasswordSuccessPage extends StatelessWidget {
  const PasswordSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.2)),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primaryColor, size: 18),
            onPressed: () => context.router.maybePop(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            SvgPicture.asset(
              Assets.images.congratulations.path,
              width: 343,
              height: 256,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 32),

            Text(
              'Congratulations',
              style: getBoldStyle(
                color: AppColors.navy,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'You have updated the password. please login again with your latest password',
              textAlign: TextAlign.center,
              style: getRegularStyle(
                color: AppColors.navy.withValues(alpha: 0.7),
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  context.router.replaceAll([const LoginRoute()]);
                },
                child: Text(
                  'Log In',
                  style: getBoldStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}