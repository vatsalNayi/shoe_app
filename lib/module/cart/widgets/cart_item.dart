import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/core/values/strings.dart';
import 'package:shoes_app/global_widgets/svg_icon.dart';
import 'package:shoes_app/models/cart_model.dart';
import '../../../core/values/colors.dart';
import '../cart_controller.dart';

class CartItem extends StatelessWidget {
  final CartController controller;
  final CartModel? cartData;
  final int cartIndex;
  const CartItem({
    super.key,
    required this.controller,
    this.cartData,
    required this.cartIndex,
  });

  String formatVariationText(String? variationText) {
    if (variationText == null || !variationText.contains('-')) {
      return '';
    }

    // Split the variationText on '-'
    List<String> parts = variationText.split('-');

    // Assuming the format is always color-size
    String color = parts[0].toUpperCase();
    String size = parts[1];

    return 'Color: $color & Size: $size';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListTile(
          contentPadding: EdgeInsets.only(left: 5.w, right: 10.h),
          tileColor: AppColors.bgGrey.withOpacity(0.5),
          title: Text(
            cartData!.name ?? '',
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // 'Size: ${cartData!.variationText?.toUpperCase()}',
                formatVariationText(
                    '${cartData!.variationText?.toUpperCase()}'),
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  Text(
                    // '\$137.45',
                    '₹${cartData?.prices?.salePrice}',
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    '₹${cartData?.prices?.regularPrice}',
                    style: GoogleFonts.poppins(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          leading: Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Image.network(
              // ImagePath.shoeCart1,
              '${cartData?.images?.first.src}',
              width: 52.w,
              height: 32.h,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  if (cartData!.quantity != null && cartData!.quantity! > 1) {
                    cartData!.quantity = (cartData!.quantity! - 1);
                    controller.update();
                  }
                },
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: AppColors.bgGreyDark,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  padding: EdgeInsets.all(6.w),
                  child: const SvgIcon(
                    imagePath: ImagePath.minus,
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              GetBuilder<CartController>(
                builder: (_) {
                  return Text(
                    // '${controller.itemQty}',
                    '${cartData?.quantity}',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                onTap: () {
                  if (cartData!.quantity != null) {
                    cartData!.quantity = (cartData!.quantity! + 1);
                    controller.update();
                  }
                },
                child: Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: AppColors.lightGreen,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  padding: EdgeInsets.all(6.w),
                  child: const SvgIcon(
                    imagePath: ImagePath.plus,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 2.0,
          right: 2.0,
          child: GestureDetector(
            onTap: () {
              Get.find<CartController>().removeFromCart(cartIndex);
            },
            child: const Icon(
              Icons.close,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
