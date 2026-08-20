import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../utils/app_styles.dart';
import 'app_constants.dart';

class CustomTextformfeild extends StatefulWidget {
  const CustomTextformfeild({
    required this.keyboardType,
    required this.controller,
    required this.validator,
    required this.formFieldKey,
    this.borderRadius,
    this.hintText,
    this.labelText,
    this.labelcolor,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.isPhoneField = false,
    this.errorText,
    this.onChanged,
    super.key,
  });

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final Key? formFieldKey;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final bool isPhoneField;
  final Color? labelcolor;
  final double? borderRadius;
  final String? errorText;
  final void Function(String)? onChanged;

  @override
  State<CustomTextformfeild> createState() => _CustomTextformfeildState();
}

class _CustomTextformfeildState extends State<CustomTextformfeild> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: EdgeInsetsDirectional.only(bottom: 8.h),
            child: Text(
              widget.labelText!,
              style: getMediumStyle(
                fontSize: AppFonts.s14.sp,
                color: widget.labelcolor ?? AppColors.secondaryColor,
              ),
            ),
          ),
        _buildTextField(isRTL),
      ],
    );
  }

  Widget _buildTextField(bool isRTL) {
    return TextFormField(
      key: widget.formFieldKey,
      validator: widget.validator,
      controller: widget.controller,
      onChanged: widget.onChanged,
      autofocus: false,
      obscureText: widget.isPassword ? _obscureText : false,
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      textAlign: isRTL ? TextAlign.right : TextAlign.left,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      style: getRegularStyle(
        fontSize: AppFonts.s14.sp,
        color: AppColors.textPrimaryColor,

      ),
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        errorText: widget.errorText,
        hintText: widget.hintText,
        hintStyle: getRegularStyle(
          fontSize: AppFonts.s14.sp,
          color: AppColors.textLightColor,
        ),
        filled: true,
        fillColor: Colors.transparent, // Figma shows white/transparent with border
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        errorStyle: getRegularStyle(
          fontSize: AppFonts.s12.sp,
          color: AppColors.errorColor,
          height: 1,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            (widget.borderRadius ?? AppConstants.defaultRadius).r,
          ),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            (widget.borderRadius ?? AppConstants.defaultRadius).r,
          ),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            (widget.borderRadius ?? AppConstants.defaultRadius).r,
          ),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            (widget.borderRadius ?? AppConstants.defaultRadius).r,
          ),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5),
        ),
        prefixIcon: widget.prefixIcon != null
            ? UnconstrainedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: widget.prefixIcon,
                ),
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.textSecondaryColor,
                  size: 20.sp,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.suffixIcon,
      ),
    );
  }
}
