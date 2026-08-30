import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketi/core/utils/app_colors.dart';
import 'package:marketi/core/utils/app_styles.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({
    super.key,
  });

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  String selectedPaymentMethod = 'Cash on delivery';
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 347.w,
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lightBlue100.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(
            selectedPaymentMethod == 'Cash on delivery'
                ? Icons.money
                : Icons.credit_card,
            color: AppColors.black,
            size: 20.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              selectedPaymentMethod,
              style: getMediumStyle(fontSize: 14.sp, color: AppColors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              _showPaymentMethodBottomSheet(context, setState);
            },
            child: Text(
              'Change',
              style:
                  getBoldStyle(fontSize: 14.sp, color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethodBottomSheet(
      BuildContext context, StateSetter setState) {
    final List<Map<String, dynamic>> paymentOptions = [
      {'title': 'Cash on delivery', 'icon': Icons.money},
      {'title': 'Credit / Debit Card', 'icon': Icons.credit_card},
      {
        'title': 'Vodafone Cash / E-Wallet',
        'icon': Icons.account_balance_wallet_outlined
      },
    ];

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      backgroundColor: AppColors.white,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Payment Method',
                style: getBoldStyle(fontSize: 18.sp, color: AppColors.black),
              ),
              SizedBox(height: 16.h),
              ...paymentOptions.map((option) {
                final isSelected = selectedPaymentMethod == option['title'];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading:
                      Icon(option['icon'], color: AppColors.black, size: 24.r),
                  title: Text(
                    option['title'],
                    style:
                        getMediumStyle(fontSize: 14.sp, color: AppColors.black),
                  ),
                  trailing: isSelected
                      ? Icon(Icons.check_circle,
                          color: AppColors.primaryColor, size: 22.r)
                      : Icon(Icons.radio_button_unchecked,
                          color: Colors.grey, size: 22.r),
                  onTap: () {
                    // تحديث القيمة وإغلاق الـ BottomSheet
                    setState(() {
                      selectedPaymentMethod = option['title'];
                    });
                    Navigator.pop(ctx);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
