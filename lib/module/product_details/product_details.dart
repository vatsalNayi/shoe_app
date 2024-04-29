import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/core/values/colors.dart';
import 'package:shoes_app/core/values/strings.dart';
import 'package:shoes_app/global_widgets/custom_appbar.dart';
import 'package:shoes_app/global_widgets/custom_button_with_icon.dart';
import 'package:shoes_app/global_widgets/svg_icon.dart';

import 'widgets/pageview_widget.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Nike',
        leadingIcon: ImagePath.backLeftSvg,
        onTapLeading: () => Get.back(),
      ),
      body: Column(
        children: [
          PageViewWidget(),
          SizedBox(
            height: 25.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 49.h,
                  child: Center(
                    child: ListView.separated(
                      itemCount: 4,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: ((context, index) {
                        return SizedBox(
                          width: 12.sp,
                        );
                      }),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 56.w,
                          height: 49.h,
                          decoration: BoxDecoration(
                            color: AppColors.bgGrey,
                          ),
                          child: Image.asset(ImagePath.shoe3),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 39.h,
                ),
                Text(
                  'Men’s shoes',
                  style: GoogleFonts.poppins(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nike Epic React',
                      style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightGreen,
                      ),
                    ),
                    Text(
                      '\$168',
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  'Whether you\'re looking for running shoes, basketball sneakers, or casual footwear, Nike has a style to suit your needs. With iconic models like the Air Max, Air Jordan.......Read More',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black.withOpacity(0.72),
                  ),
                ),
                SizedBox(
                  height: 11.h,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 15.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return SvgIcon(imagePath: ImagePath.ratings);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Text(
                      '(Reviews)',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 11.h,
                ),
                Text(
                  'Color',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  height: 15.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 8.w,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        width: 20.w,
                        decoration: BoxDecoration(
                          color: AppColors.red,
                          shape: BoxShape.circle,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 11.h,
                ),
                Text(
                  'Size',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                SizedBox(
                  height: 35.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 8.w,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: AppColors.bgGrey,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 6}',
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButtonWithIcon(
                    onTap: () {},
                    title: 'Add To Cart',
                    icon: ImagePath.cartBlack,
                    iconBgColor: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
