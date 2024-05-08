import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/core/utils/helper.dart';
import 'package:shoes_app/core/values/colors.dart';
import 'package:shoes_app/core/values/strings.dart';
import 'package:shoes_app/global_widgets/custom_appbar.dart';
import 'package:shoes_app/global_widgets/custom_button_with_icon.dart';
import 'package:shoes_app/global_widgets/no_data_page.dart';
import 'package:shoes_app/global_widgets/svg_icon.dart';
import 'package:shoes_app/models/cart_model.dart';
import 'package:shoes_app/models/product_model.dart';
import 'package:shoes_app/module/auth/controller/auth_controller.dart';
import 'package:shoes_app/module/cart/cart_controller.dart';
import 'package:shoes_app/module/home/home_controller.dart';
import 'package:shoes_app/module/home/products/controller/product_controller.dart';
import 'package:shoes_app/module/more/profile/profile_controller.dart';
import 'package:shoes_app/routes/pages.dart';
import 'widgets/pageview_widget.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel? product;
  final String? url;
  final bool formSplash;
  const ProductDetails({
    super.key,
    this.product,
    this.url,
    required this.formSplash,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<ProfileController>().getUserInfo();
    }
    if (widget.formSplash) {
      Get.find<ProductController>().getSlugProductDetails(widget.url, true);
    } else if (widget.product!.id != -1) {
      Get.find<ProductController>().getProductDetails(widget.product!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return GetBuilder<ProductController>(builder: (productController) {
      final product = productController.product;
      if (productController.product != null &&
          productController.variations == null &&
          productController.variationIndex != null) {
        List<String> _variationList = [];
        for (int index = 0;
            index < productController.product!.attributes!.length;
            index++) {
          if (productController
              .product!.attributes![index].options!.isNotEmpty) {
            _variationList.add(productController.product!.attributes![index]
                .options![productController.variationIndex![index]]
                .replaceAll(' ', ''));
          }
        }
        String variationType = '';
        bool isFirst = true;
        _variationList.forEach((variation) {
          if (isFirst) {
            variationType = '$variationType$variation';
            isFirst = false;
          } else {
            variationType = '$variationType-$variation';
          }
        });

        List<Variation> _variations = [];
        for (int index = 0;
            index < productController.product!.attributes!.length;
            index++) {
          if (productController
              .product!.attributes![index].options!.isNotEmpty) {
            _variations.add(Variation(
              attribute: productController.product!.attributes![index].name,
              value: productController.product!.attributes![index]
                  .options![productController.variationIndex![index]],
            ));
          }
        }
      }
      return PopScope(
        canPop: widget.formSplash ? false : true,
        onPopInvoked: (_) {
          if (widget.formSplash) {
            productController.resetImageIndex();

            productController.setCurrentProductImageDisplayIndex = 0;
            productController.setSelectedAttributeForProduct = '';
            Get.offNamed(Routes.dashboardPage);
          } else {
            //productController.resetImageIndex();
            productController.productDetailsBack();
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(
            // title: 'Nike',
            title: 'Details',
            leadingIcon: ImagePath.backLeftSvg,
            onTapLeading: () => Get.back(),
          ),
          body: (productController.noProductFound! == true)
              ? NoDataScreen(text: 'no_product_found'.tr)
              : (productController.product != null)
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PageViewWidget(product: productController.product),
                          SizedBox(
                            height: 25.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(
                                //   height: 49.h,
                                //   child: Center(
                                //     child: ListView.separated(
                                //       itemCount: 4,
                                //       shrinkWrap: true,
                                //       scrollDirection: Axis.horizontal,
                                //       separatorBuilder: ((context, index) {
                                //         return SizedBox(
                                //           width: 12.sp,
                                //         );
                                //       }),
                                //       itemBuilder: (context, index) {
                                //         return Container(
                                //           width: 56.w,
                                //           height: 49.h,
                                //           decoration: BoxDecoration(
                                //             color: AppColors.bgGrey,
                                //           ),
                                //           // child: Image.asset(ImagePath.shoe3),
                                //           child: Image.network(
                                //               '${widget.product!.images?.first.src}'),
                                //         );
                                //       },
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 39.h,
                                ),
                                Text(
                                  // 'Men’s shoes',
                                  // widget.product?.name.toString() ?? '',
                                  product!.name ?? '',
                                  style: GoogleFonts.poppins(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nike Epic React (static)',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.lightGreen,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          // '\$168',
                                          '₹${product.salePrice}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          // '\$168',
                                          '₹${product.regularPrice}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                Text(
                                  // 'Whether you\'re looking for running shoes, basketball sneakers, or casual footwear, Nike has a style to suit your needs. With iconic models like the Air Max, Air Jordan.......Read More',
                                  convertHtmlText(
                                      product.description.toString()),
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
                                          return SvgIcon(
                                              imagePath: ImagePath.ratings);
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
                                          borderRadius:
                                              BorderRadius.circular(10.r),
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
                                    onTap: () {
                                      Get.find<CartController>().addToCart(
                                          productController.cartModel,
                                          productController.cartIndex);
                                    },
                                    title: 'Add To Cart',
                                    icon: ImagePath.cartBlack,
                                    iconBgColor: AppColors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: CustomButtonWithIcon(
                                    onTap: () async {
                                      /// instamojo api demo
                                      await Get.toNamed(Routes.instamojoApi)
                                          ?.then((value) {
                                        if (value != null) {
                                          homeController.setPaymemtStatusRes =
                                              value;
                                        }
                                      });
                                    },
                                    title: 'Buy now',
                                    icon: ImagePath.arrowNext,
                                    iconBgColor: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                        ],
                      ),
                    )
                  : const Center(child: CupertinoActivityIndicator()),
        ),
      );
    });
  }
}
