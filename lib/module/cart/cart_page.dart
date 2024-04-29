import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/core/values/colors.dart';
import 'package:shoes_app/core/values/strings.dart';
import 'package:shoes_app/global_widgets/custom_appbar.dart';
import 'package:shoes_app/global_widgets/custom_button.dart';
import 'package:shoes_app/module/cart/cart_controller.dart';

import 'widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // CartController controller = Get.put(CartController());
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cart',
        automaticallyImplyLeading: false,
        trailingIcon: ImagePath.cartBlack,
      ),
      body: GetBuilder<CartController>(builder: (cartController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              itemCount: 3,
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 24.h,
                );
              },
              itemBuilder: (context, index) {
                return CartItem(controller: cartController);
              },
            ),
            SizedBox(
              height: 36.h,
            ),
            Container(
              color: AppColors.bgGrey.withOpacity(0.3),
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price Details',
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        '\$137.45',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discount',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        '10%',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Charge',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        '0',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        '\$123.70',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.lightGreen,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  CustomButton(
                    radius: 15.r,
                    onPress: () {},
                    btnText: 'Check Out',
                    loading: false,
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
