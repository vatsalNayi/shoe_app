// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/core/values/colors.dart';
import 'package:shoes_app/global_widgets/custom_image.dart';
import 'package:shoes_app/models/product_model.dart';
import 'package:shoes_app/module/wishlist/controller/wish_controller.dart';
import 'package:shoes_app/routes/pages.dart';

class WishedItems extends StatelessWidget {
  final ProductModel productData;
  final int index;
  const WishedItems({
    Key? key,
    required this.productData,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishListController>(builder: (wishListController) {
      return wishListController.wishProductList != null
          ? wishListController.wishProductList!.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.getProductDetailsRoute(
                        productData.id!,
                        '',
                        false,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(3, 5)),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10.r)),
                                child: CustomImage(
                                  image: productData.images!.first.src,
                                  height: 240.h,
                                  width: double.maxFinite,
                                  fit: BoxFit.cover,
                                  // fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      width: double.maxFinite,
                                      child: Text(
                                        '${productData.name}',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          color: AppColors.black,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    // WishProductPriceWidget(
                                    //   // product: productData,
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          // '\$149.00',
                                          '₹${productData.salePrice}',
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            color: AppColors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          // '\$149.00',
                                          '₹${productData.regularPrice}',
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: AppColors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned.fill(
                          right: 10.w,
                          top: 10.h,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                Get.find<WishListController>()
                                    .removeProductWishlist(index);
                              },
                              child: Container(
                                width: 20.w,
                                height: 20.h,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 248, 248, 248),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )
          : const Center(
              child: CupertinoActivityIndicator(),
            );
    });
  }
}
