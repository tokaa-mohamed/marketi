import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/utils/app_colors.dart';
import '../../domain/entities/home_entity.dart';

class BannersSection extends StatelessWidget {
  final List<BannerEntity> banners;

  const BannersSection({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          height: 150.h,
          width: double.infinity,
          child: PageView.builder(
            itemCount: banners.length,
            itemBuilder: (context, index) => Image.network(
              banners[index].image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey.shade500,
                child: const Center(child: Text('NO AVIALABLE OFFERS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
