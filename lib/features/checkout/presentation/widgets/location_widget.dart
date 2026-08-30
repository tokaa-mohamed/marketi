import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 347.w,
        height: 220.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.lightBlue, width: 1.w),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: SizedBox(
                height: 120.h,
                width: double.infinity,
                child: Image.network(
                  'https://static.maps.locationiq.com/staticmapbox/staticmap.php?key=dummy&center=30.0444,31.2357&zoom=13&size=600x300',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFEBF3FF),
                    child: Center(
                      child: Icon(Icons.location_on,
                          color: AppColors.primaryColor, size: 36.r),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on_outlined,
                      color: AppColors.darkBlueColor, size: 20.r),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Home',
                          style: getBoldStyle(
                              fontSize: 15.sp, color: AppColors.darkBlueColor),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Anshas, Al-sharqia, Egypt.',
                          style: getRegularStyle(
                              fontSize: 13.sp, color: Colors.grey.shade600),
                        ),
                        Text(
                          'Mobile: +20 101 840 3043',
                          style: getRegularStyle(
                              fontSize: 13.sp, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Change',
                      style: getBoldStyle(
                          fontSize: 14.sp, color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
