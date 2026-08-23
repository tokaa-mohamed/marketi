import 'package:flutter/material.dart';

import 'package:marketi/core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          suffixIcon: Icon(
            Icons.tune_outlined,
            color: AppColors.lightBlue,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.lightBlue)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.lightBlue))),
    );
  }
}
