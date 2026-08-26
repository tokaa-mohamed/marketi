import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/cart_page/presentation/screens/cart_screen.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/favourit_page/presentation/widgets/nav_bottom_bar_icon.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // لون وشفافية الظل
            offset: const Offset(0, 4), // إزاحة للأسفل فقط
            blurRadius: 4, // درجة درحة انتشار الظل
            spreadRadius: -4, // 👈 القيمة السالبة تمنع الظل من بقية الجهات
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavBottomBarIcon(icon: Icons.home, label: 'Home'),
          NavBottomBarIcon(
            icon: Icons.shopping_cart,
            label: 'Cart',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ));
            },
          ),
          NavBottomBarIcon(icon: Icons.favorite, label: 'Favorites'),
          NavBottomBarIcon(icon: Icons.menu, label: 'Menu'),
        ],
      ),
    );
  }
}
