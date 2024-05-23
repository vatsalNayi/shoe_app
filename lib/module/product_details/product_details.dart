import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/core/utils/dimensions.dart';
import 'package:shoes_app/core/values/colors.dart';
import 'package:shoes_app/core/values/strings.dart';
import 'package:shoes_app/global_widgets/custom_appbar.dart';
import 'package:shoes_app/global_widgets/custom_button_with_icon.dart';
import 'package:shoes_app/global_widgets/no_data_page.dart';
import 'package:shoes_app/global_widgets/product_card.dart';
import 'package:shoes_app/global_widgets/product_shimmer.dart';
import 'package:shoes_app/global_widgets/rating_bar.dart';
import 'package:shoes_app/global_widgets/svg_icon.dart';
import 'package:shoes_app/helper/date_converter.dart';
import 'package:shoes_app/models/cart_model.dart';
import 'package:shoes_app/models/product_model.dart';
import 'package:shoes_app/module/auth/controller/auth_controller.dart';
import 'package:shoes_app/module/cart/cart_controller.dart';
import 'package:shoes_app/module/home/home_controller.dart';
import 'package:shoes_app/module/home/products/controller/product_controller.dart';
import 'package:shoes_app/module/home/products/models/review_model.dart';
import 'package:shoes_app/module/home/products/product_price_view.dart';
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
                  ? Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PageViewWidget(
                                  product: productController.product),
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
                                      height: 30.h,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          product!.name ?? '',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.lightGreen,
                                          ),
                                        ),

                                        // Column(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.end,
                                        //   children: [
                                        //     Text(
                                        //       // '\$168',
                                        //       '₹${product.salePrice}',
                                        //       // '₹${product.variationProducts?[0].price}',
                                        //       style: GoogleFonts.poppins(
                                        //         fontSize: 20.sp,
                                        //         fontWeight: FontWeight.w600,
                                        //       ),
                                        //     ),
                                        //     Text(
                                        //       // '\$168',
                                        //       '₹${product.regularPrice}',
                                        //       style: GoogleFonts.poppins(
                                        //         fontSize: 20.sp,
                                        //         fontWeight: FontWeight.w600,
                                        //         decoration:
                                        //             TextDecoration.lineThrough,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                    ProductTitleView(
                                        product: productController.product),

                                    Html(
                                      data: '${product.description}',
                                      style: {
                                        "p1": Style(
                                          fontSize: FontSize(14.sp),
                                          fontWeight: FontWeight.w400,
                                          color:
                                              AppColors.black.withOpacity(0.72),
                                        ),
                                      },
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    productController
                                            .variationAttributes.isNotEmpty
                                        ? Wrap(
                                            direction: Axis.horizontal,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.start,
                                            children: List.generate(
                                              productController
                                                  .variationAttributes.length,
                                              (index) {
                                                Attributes data =
                                                    productController
                                                        .variationAttributes
                                                        .elementAt(index);
                                                debugPrint(
                                                    'ATTRIBUTES is: ${productController.variationAttributes[index].options}');
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(height: 5.h),
                                                    data.options!.isNotEmpty
                                                        ? Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                data.name !=
                                                                        null
                                                                    ? '${'please_select_a'.tr} ${data.name!.capitalizeFirst}'
                                                                    : '',
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              SizedBox(
                                                                  height: 10.h),
                                                              data.options !=
                                                                          null &&
                                                                      data.options!
                                                                          .isNotEmpty
                                                                  ? Wrap(
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      children:
                                                                          List.generate(
                                                                        data.options!
                                                                            .length,
                                                                        (i) {
                                                                          String
                                                                              option =
                                                                              data.options!.elementAt(i);
                                                                          return GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              productController.setCartVariationIndex(index, i, productController.product!);
                                                                            },
                                                                            child:
                                                                                AnimatedContainer(
                                                                              duration: 200.ms,
                                                                              margin: EdgeInsets.only(right: 10.w, bottom: 10.h),
                                                                              padding: EdgeInsets.symmetric(
                                                                                vertical: 10.h,
                                                                                horizontal: 20.w,
                                                                              ),
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(50.r),
                                                                                border: Border.all(color: productController.variationIndex![index] == i ? const Color.fromARGB(255, 217, 159, 178) : AppColors.lightRose),
                                                                              ),
                                                                              child: Text(
                                                                                option,
                                                                                style: GoogleFonts.poppins(
                                                                                  fontSize: 13,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  color: productController.variationIndex![index] == i ? const Color.fromARGB(255, 217, 159, 178) : AppColors.brightGrey,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    )
                                                                  : const SizedBox(),
                                                            ],
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                );
                                              },
                                            ),
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            const SvgIcon(
                                              imagePath:
                                                  ImagePath.yellowStarSvg,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                                double.parse(productController
                                                        .product!.averageRating
                                                        .toString())
                                                    .toStringAsFixed(1),
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w400,
                                                ).copyWith(
                                                  color: Theme.of(context)
                                                      .hintColor,
                                                  fontSize:
                                                      Dimensions.fontSizeLarge,
                                                )),
                                            const SizedBox(
                                                width: Dimensions
                                                    .PADDING_SIZE_DEFAULT),
                                            Text(
                                              '${productController.product!.reviewCount.toString()} ${'reviews'.tr}',
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                              ).copyWith(
                                                color:
                                                    Theme.of(context).hintColor,
                                                fontSize:
                                                    Dimensions.fontSizeLarge,
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(
                                                Routes.getWriteReviewRoute(
                                                    productController
                                                        .product!.id));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(
                                                Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            decoration: BoxDecoration(
                                              color: Get.isDarkMode
                                                  ? AppColors.lightRose
                                                  : Colors.transparent,
                                              borderRadius: BorderRadius
                                                  .circular(Dimensions
                                                      .PADDING_SIZE_DEFAULT),
                                              border: Border.all(
                                                color: Get.isDarkMode
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : AppColors.classicRose,
                                              ),
                                            ),
                                            child: Text(
                                              'give_review'.tr,
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                              ).copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeExtraSmall,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 26.h,
                                    ),
                                    productController.reviewList != null &&
                                            productController
                                                .reviewList!.isNotEmpty
                                        ? ListView.separated(
                                            shrinkWrap: true,
                                            itemCount:
                                                //  productController
                                                //             .reviewList!
                                                //             .length >
                                                //         5
                                                //     ? 5
                                                //     :
                                                productController
                                                    .reviewList!.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              ReviewModel reviewData =
                                                  productController.reviewList!
                                                      .elementAt(index);
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: AppColors
                                                                  .classicRose,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                '${reviewData.rating!}',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black45,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 12.w,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              SizedBox(
                                                                width: 200,
                                                                child: Text(
                                                                  reviewData
                                                                          .name ??
                                                                      '',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              RatingBar(
                                                                rating: reviewData
                                                                    .rating!
                                                                    .toDouble(),
                                                                ratingCount:
                                                                    null,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        DateConverter
                                                            .isoStringToLocalDateOnly(
                                                                reviewData
                                                                    .dateCreated!),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts
                                                            .poppins(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ).copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeExtraSmall,
                                                            color: Theme.of(
                                                                    context)
                                                                .disabledColor),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Text(
                                                    reviewData.review ?? '-',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  // Align(
                                                  //   alignment: Alignment
                                                  //       .centerRight,
                                                  //   child: productController
                                                  //                   .reviewList!
                                                  //                   .length >
                                                  //               5 &&
                                                  //           index == 4
                                                  //       ? Column(
                                                  //           children: [
                                                  //             const SizedBox(
                                                  //               height: Dimens
                                                  //                   .pixel_20,
                                                  //             ),
                                                  //             Text(
                                                  //               "See More Reviews",
                                                  //               style:
                                                  //                   textstyle16,
                                                  //             ),
                                                  //           ],
                                                  //         )
                                                  //       : const SizedBox(),
                                                  // ),
                                                ],
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                child: Divider(),
                                              );
                                            },
                                          )
                                        : Container(),

                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Text(
                                      'related_products'.tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    productController
                                            .product!.relatedIds!.isNotEmpty
                                        ? productController
                                                    .relatedProductList !=
                                                null
                                            ? GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio: .74,
                                                  // crossAxisSpacing: 10,
                                                  // mainAxisSpacing: 40,
                                                  mainAxisSpacing: 30,
                                                  crossAxisSpacing: Dimensions
                                                      .PADDING_SIZE_SMALL,
                                                ),
                                                itemCount: productController
                                                    .relatedProductList!.length,
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return ProductCard(
                                                      productModel:
                                                          productController
                                                                  .relatedProductList![
                                                              index],
                                                      allProduct: true,
                                                      index: index,
                                                      productList:
                                                          productController
                                                              .relatedProductList);
                                                },
                                              )
                                            : const ProductShimmer()
                                        : Center(
                                            child: Text(
                                                'no_related_product_found'.tr)),

                                    // Review previous design
                                    // Row(
                                    //   mainAxisSize: MainAxisSize.min,
                                    //   children: [
                                    //     SizedBox(
                                    //       height: 15.h,
                                    //       child: ListView.builder(
                                    //         shrinkWrap: true,
                                    //         scrollDirection: Axis.horizontal,
                                    //         itemCount: 5,
                                    //         itemBuilder: (context, index) {
                                    //           return const SvgIcon(
                                    //               imagePath: ImagePath.ratings);
                                    //         },
                                    //       ),
                                    //     ),
                                    //     SizedBox(
                                    //       width: 9.w,
                                    //     ),
                                    //     Text(
                                    //       '(Reviews)',
                                    //       style: GoogleFonts.poppins(
                                    //         fontSize: 14.sp,
                                    //         fontWeight: FontWeight.w500,
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),

                                    // SizedBox(
                                    //   height: 5.h,
                                    // ),
                                    // SizedBox(
                                    //   height: 15.h,
                                    //   child: ListView.separated(
                                    //     shrinkWrap: true,
                                    //     scrollDirection: Axis.horizontal,
                                    //     itemCount: 4,
                                    //     separatorBuilder: (context, index) {
                                    //       return SizedBox(
                                    //         width: 8.w,
                                    //       );
                                    //     },
                                    //     itemBuilder: (context, index) {
                                    //       return Container(
                                    //         width: 20.w,
                                    //         decoration: const BoxDecoration(
                                    //           color: AppColors.red,
                                    //           shape: BoxShape.circle,
                                    //         ),
                                    //       );
                                    //     },
                                    //   ),
                                    // ),

                                    ///
                                    // Product Size design
                                    // SizedBox(
                                    //   height: 35.h,
                                    //   child: ListView.separated(
                                    //     shrinkWrap: true,
                                    //     scrollDirection: Axis.horizontal,
                                    //     itemCount: 5,
                                    //     separatorBuilder: (context, index) {
                                    //       return SizedBox(
                                    //         width: 8.w,
                                    //       );
                                    //     },
                                    //     itemBuilder: (context, index) {
                                    //       return Container(
                                    //         width: 35.w,
                                    //         decoration: BoxDecoration(
                                    //           color: AppColors.bgGrey,
                                    //           borderRadius:
                                    //               BorderRadius.circular(10.r),
                                    //         ),
                                    //         child: Center(
                                    //           child: Text(
                                    //             '${index + 6}',
                                    //             style: GoogleFonts.poppins(
                                    //               fontSize: 13.sp,
                                    //               fontWeight: FontWeight.w400,
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       );
                                    //     },
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    // Align(
                                    //   alignment: Alignment.center,
                                    //   child: CustomButtonWithIcon(
                                    //     onTap: () {
                                    //       Get.find<CartController>().addToCart(
                                    //           productController.cartModel,
                                    //           productController.cartIndex);
                                    //     },
                                    //     title: 'Add To Cart',
                                    //     icon: ImagePath.cartBlack,
                                    //     iconBgColor: AppColors.white,
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   height: 10.h,
                                    // ),
                                    // Align(
                                    //   alignment: Alignment.center,
                                    //   child: CustomButtonWithIcon(
                                    //     onTap: () async {
                                    //       /// instamojo api demo
                                    //       await Get.toNamed(Routes.instamojoApi)
                                    //           ?.then((value) {
                                    //         if (value != null) {
                                    //           homeController.setPaymemtStatusRes =
                                    //               value;
                                    //         }
                                    //       });
                                    //     },
                                    //     title: 'Buy now',
                                    //     icon: ImagePath.arrowNext,
                                    //     iconBgColor: AppColors.black,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          ),
                        ),
                        Positioned.fill(
                          bottom: 70.h,
                          child: Align(
                            alignment: Alignment.bottomCenter,
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
                        ),
                      ],
                    )
                  : const Center(child: CupertinoActivityIndicator()),
        ),
      );
    });
  }
}
