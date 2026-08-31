import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_fonts.dart';
import 'package:marketi/core/utils/app_styles.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String username;
  final String? imageUrl;
  final VoidCallback onCameraTap;
  
  const ProfileHeaderWidget({
    super.key,
    required this.name,
    required this.username,
    this.imageUrl,
    required this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasValidImage = imageUrl != null && imageUrl!.trim().isNotEmpty;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = AppColors.primaryColor;

    return Column(
      children: [
        SizedBox(
          height: 220.h,
          width: 1.sw,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: -0.25,
                child: SizedBox(
                  width: 340.w,
                  height: 170.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 340.w,
                        height: 170.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: primaryColor.withOpacity(isDarkMode ? 0.15 : 0.25),
                            width: 1.5,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 60.h,
                        left: 80.w,
                        child: Container(
                          width: 10.r,
                          height  : 10.r,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(isDarkMode ? 0.4 : 0.6),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 60.h,
                        right: 80.w,
                        child: Container(
                          width: 10.r,
                          height: 10.r,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(isDarkMode ? 0.4 : 0.6),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Transform.rotate(
                angle: 0.4, 
                child: SizedBox(
                  width: 310.w,
                  height: 155.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 310.w,
                        height: 155.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: primaryColor.withOpacity(isDarkMode ? 0.1 : 0.15),
                            width: 1,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 60.h,
                        left: 80.w,
                        child: Container(
                          width: 9.r,
                          height: 9.r,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(isDarkMode ? 0.35 : 0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 60.h,
                        right: 80.w,
                        child: Container(
                          width: 9.r,
                          height: 9.r,
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(isDarkMode ? 0.35 : 0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Stack(
                children: [
                  Container(
                    width: 110.w,
                    height: 110.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor.withOpacity(0.1),
                      border: Border.all(color: primaryColor, width: 2.5),
                      image: hasValidImage
                          ? DecorationImage(
                              image: NetworkImage(imageUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: !hasValidImage
                        ? Icon(
                            Icons.person,
                            size: 55.sp,
                            color: primaryColor,
                          )
                        : null,
                  ),
                  
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: GestureDetector(
                      onTap: onCameraTap,
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: primaryColor,
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          size: 16.sp,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          name,
          style: getBoldStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: AppFonts.s18.sp,
          ),
        ),
        if (username.isNotEmpty) ...[
          SizedBox(height: 4.h),
          Text(
            username,
            style: getMediumStyle(
              color: AppColors.grey,
              fontSize: AppFonts.s14.sp,
            ),
          ),
        ],
      ],
    );
  }
}