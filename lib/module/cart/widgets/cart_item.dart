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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 5.w, right: 10.h),
      tileColor: AppColors.bgGrey.withOpacity(0.5),
      title: Text(
        // 'Ultra Boost shoes',
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
            'Size: 5',
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
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<CartController>(
            builder: (_) {
              return Checkbox(
                activeColor: AppColors.lightGreen,
                value: controller.isSelectedItem,
                onChanged: controller.toggleSelectItem,
              );
            },
          ),
          Container(
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
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: controller.decrItemQty,
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
                '${controller.itemQty}',
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
            onTap: controller.incrItemQty,
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
    );
  }
}
