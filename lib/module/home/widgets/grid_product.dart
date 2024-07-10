import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/core/values/colors.dart';
import 'package:shoes_app/core/values/strings.dart';
import 'package:shoes_app/global_widgets/svg_icon.dart';
import 'package:shoes_app/models/product_model.dart';
import 'package:shoes_app/module/home/products/controller/product_controller.dart';
import 'package:shoes_app/module/wishlist/controller/wish_controller.dart';

class GridProducts extends StatelessWidget {
  ProductModel productList;
  int index;
  GridProducts({
    super.key,
    required this.productList,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.h),
      decoration: BoxDecoration(
        color: AppColors.bgColorCard,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              children: [
                // Image.network(
                //   '${productList.images?.first.src}',
                //   fit: BoxFit.cover,
                //   height: 100.h,
                //   width: 150.w,
                // ),
                CachedNetworkImage(
                  imageUrl: '${productList.images?.first.src}',
                  fit: BoxFit.cover,
                  height: 100.h,
                  width: 150.w,
                ),
                Positioned.fill(
                  top: -3.0,
                  // left: -2.0,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 54.w,
                      height: 21.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            // '(4.0)',
                            '(${productList.ratingCount})',
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          const SvgIcon(
                            imagePath: ImagePath.ratings,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GetBuilder<WishListController>(
                      builder: (wishListController) {
                        return GestureDetector(
                          onTap: () {
                            Get.find<WishListController>()
                                .addProductToWishlist(productList);
                          },
                          child: SvgIcon(
                            imagePath: wishListController.wishIdList
                                    .contains(productList.id)
                                ? ImagePath.saved
                                : ImagePath.unsave,
                            height: 15.h,
                            width: 15.h,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 22.h,
          ),
          Text(
            // 'Nike Air Jorden x Air (Men’s)',
            '${productList.name}',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 9.h,
          ),
          Row(
            children: [
              Text(
                '₹${productList.price}',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // SizedBox(
              //   width: 8.w,
              // ),
              // Text(
              //   // '\$135.00',
              //   '₹${productList.regularPrice}',
              //   style: GoogleFonts.poppins(
              //     decoration: TextDecoration.lineThrough,
              //     fontSize: 14.sp,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 7.h,
          ),

          /// Free delivery widget:
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 4.w),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(9.r),
          //     gradient: LinearGradient(
          //       begin: Alignment.centerLeft,
          //       end: Alignment.centerRight,
          //       colors: [
          //         AppColors.bgGrey,
          //         AppColors.lightGreen.withOpacity(0.7),
          //       ],
          //     ),
          //   ),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       const SvgIcon(
          //         imagePath: ImagePath.freeDelivery,
          //       ),
          //       SizedBox(
          //         width: 2.w,
          //       ),
          //       Text(
          //         'Free Delivery',
          //         style: GoogleFonts.poppins(
          //           fontSize: 14.sp,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            'Only 2 Left',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 22.h,
                  width: 105.w,
                  decoration: BoxDecoration(
                    color: AppColors.lightGreen.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      'Buy Now',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              GetBuilder<ProductController>(builder: (productController) {
                return GestureDetector(
                  onTap: () {
                    debugPrint('icon pressed');
                    // Get.find<CartController>().addToCart(
                    //   productController.cartModel,
                    //   productController.cartIndex,
                    // );
                  },
                  child: Container(
                    width: 31.w,
                    height: 22.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: const SvgIcon(
                      imagePath: ImagePath.cartBlack,
                    ),
                  ),
                );
              }),
            ],
          )
        ],
      ),
    );
  }
}
