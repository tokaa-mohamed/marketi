import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/constant/custom_button.dart';
import 'package:marketi/core/constant/custom_svg_image.dart';
import 'package:marketi/core/routing/app_router.gr.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';
import 'package:marketi/features/auth/data/model/onboarding_model.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: OnboardingModel.onboardingList.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = OnboardingModel.onboardingList[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomSvgImage(
                          path: item.image,
                          height: 256.h,
                          width: 256.w,
                        ),
                        SizedBox(height: 32.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            OnboardingModel.onboardingList.length,
                            (dotIndex) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              width: _currentIndex == dotIndex ? 11.w : 11.w,
                              height: 10.h,
                              decoration: BoxDecoration(
                                color: _currentIndex == dotIndex
                                    ? AppColors.darkBlue
                                    : const Color(0xFFB3C8FF),
                                borderRadius:
                                _currentIndex == dotIndex?
                                 BorderRadius.circular(140.r):BorderRadius.circular(140.r),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32.h),
                        Text(
                          item.title,
style: getMediumStyle(
    fontSize: AppFonts.s20,
    color: AppColors.darkBlue, 

      ),                       
         textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          item.description,
style: getMediumStyle(
    fontSize: AppFonts.s12,
    color: AppColors.darkBlue, 

      ),                       
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: CustomButton(
  data: _currentIndex == OnboardingModel.onboardingList.length - 1
      ? 'Get Started'
      : 'Next',
  onTap: () {
    if (_currentIndex < OnboardingModel.onboardingList.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
context.router.replace(const LoginRoute());      
    }
  },
)
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}