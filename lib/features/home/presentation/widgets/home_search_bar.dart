import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/constant/custom_textformfield.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: CustomTextformfeild(
        keyboardType: TextInputType.text,
        controller: TextEditingController(),
        validator: (val) => null,
        formFieldKey: const Key('home_search'),
        hintText: 'What are you looking for ?',
        prefixIcon: Icon(Icons.search, color: AppColors.secondaryColor, size: 24.sp),
        suffixIcon: Icon(Icons.tune, color: AppColors.primaryColor, size: 24.sp),
      ),
    );
  }
}
