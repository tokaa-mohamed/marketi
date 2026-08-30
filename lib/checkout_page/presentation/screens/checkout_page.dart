import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/checkout_page/presentation/widgets/custom_title_text.dart';
import 'package:marketi/checkout_page/presentation/widgets/delivry_time_widget.dart';
import 'package:marketi/checkout_page/presentation/widgets/location_widget.dart';
import 'package:marketi/checkout_page/presentation/widgets/payment_method_widget.dart';
import 'package:marketi/checkout_page/presentation/widgets/subtotal_widget.dart';
import 'package:marketi/core/constant/custom_app_bar.dart';
import 'package:marketi/core/constant/custom_button.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Checkout",
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(
                child: CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomTitleText(
                      sizeTxt: 15.sp,
                      title: "Address",
                    ),
                    LocationWidget(),
                    CustomTitleText(
                      sizeTxt: 15.sp,
                      title: "Delivery time",
                    ),
                    DeliveryTimeWidget(),
                    CustomTitleText(
                      sizeTxt: 15.sp,
                      title: "Payment Method",
                    ),
                    PaymentMethodWidget(),
                    CustomTitleText(
                      sizeTxt: 15.sp,
                      title: "Payment",
                    ),
                    SubTotalWidget(),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomButton(
                        data: "Place Order",
                        textStyle: getMediumStyle(
                            fontSize: 17.sp, color: AppColors.white),
                        width: 350.w,
                        height: 50.h,
                        color: AppColors.lightBlue100,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutPage(),
                              ));
                        }),
                  ],
                ),
              ),
            ]))
          ],
        ));
  }
}
