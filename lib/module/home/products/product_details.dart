import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/global_widgets/svg_icon.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/styles.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/strings.dart';
import '../../../global_widgets/custom_image.dart';
import '../../../global_widgets/no_data_page.dart';
import '../../../global_widgets/product_card.dart';
import '../../../global_widgets/product_shimmer.dart';
import '../../../global_widgets/rating_bar.dart';
import '../../../helper/date_converter.dart';
import '../../../models/cart_model.dart';
import '../../../models/product_model.dart';
import '../../../routes/pages.dart';
import '../../auth/controller/auth_controller.dart';
import '../../cart/cart_controller.dart';
import '../../more/profile/profile_controller.dart';
import '../home_controller.dart';
import 'controller/product_controller.dart';
import 'models/review_model.dart';
import 'product_price_view.dart';

class ProductDetails extends StatefulWidget {
  final bool formSplash;
  final String? url;
  final ProductModel? product;
  const ProductDetails(
      {super.key, required this.formSplash, this.url, this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with TickerProviderStateMixin {
  final Size size = Get.size;
  GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  // final GlobalKey<DetailsAppBarState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<ProfileController>().getUserInfo();
    }
    if (widget.formSplash) {
      Get.find<ProductController>().getSlugProductDetails(widget.url, true);
    } else if (widget.product!.id != -1) {
      Get.find<ProductController>().getProductDetails(widget.product!);
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return GetBuilder<ProductController>(builder: (productController) {
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
            // Get.offNamed(Routes.bottomBarPage);
          } else {
            //productController.resetImageIndex();
            productController.productDetailsBack();
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: (productController.noProductFound! == true)
                ? NoDataScreen(text: 'no_product_found'.tr)
                : (productController.product != null)
                    ? CustomScrollView(
                        physics: const ClampingScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            // backgroundColor: AppColors.white,
                            expandedHeight: 700,
                            pinned: true,
                            automaticallyImplyLeading: false,
                            leadingWidth: 45,
                            leading: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                margin: EdgeInsets.only(left: 10.w),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 248, 248, 248),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 20,
                                ),
                              ),
                            ),
                            actions: [
                              // GetBuilder<WishListController>(
                              //     builder: (wishlistController) {
                              //   return GestureDetector(
                              //     onTap: () async {
                              //       // Get.find<WishListController>()
                              //       //     .addProductToWishlist(
                              //       //         productController.product!);
                              //     },
                              //     child: Container(
                              //       width: 35,
                              //       height: 35,
                              //       decoration: const BoxDecoration(
                              //         color: Color.fromARGB(255, 248, 248, 248),
                              //         shape: BoxShape.circle,
                              //       ),
                              //       margin: const EdgeInsets.only(right: 10),
                              //       child: Center(
                              //           child: Icon(
                              //               wishlistController.wishIdList
                              //                       .contains(productController
                              //                           .product!.id)
                              //                   ? Icons.favorite
                              //                   : Icons.favorite_border,
                              //               color: wishlistController.wishIdList
                              //                       .contains(productController
                              //                           .product!.id)
                              //                   ? AppColors.red
                              //                   : Theme.of(context).hintColor)),
                              //     ),
                              //   );
                              // }),
                              GetBuilder<CartController>(
                                  builder: (cartController) {
                                return GestureDetector(
                                  onTap: () async {
                                    // Get.toNamed(Routes.getCartRoute());
                                  },
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 248, 248, 248),
                                      shape: BoxShape.circle,
                                    ),
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Badge(
                                      smallSize: 10,
                                      largeSize: 15,
                                      isLabelVisible: Get.find<CartController>()
                                          .cartList!
                                          .isNotEmpty,
                                      backgroundColor: Colors.pink,
                                      label: GetBuilder<CartController>(
                                          builder: (cartController) {
                                        return Center(
                                          child: Text(
                                            cartController.cartList!.length
                                                .toString(),
                                            style: poppinsMedium.copyWith(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        );
                                      }),
                                      child: const Center(
                                        child: SvgIcon(
                                          width: 18,
                                          height: 18,
                                          fit: BoxFit.contain,
                                          imagePath: ImagePath.cartSvg,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                            excludeHeaderSemantics: true,
                            collapsedHeight: 60,
                            surfaceTintColor: Colors.transparent,
                            flexibleSpace: LayoutBuilder(
                              builder: (context, constraint) {
                                return AnimatedSwitcher(
                                  duration: 200.milliseconds,
                                  transitionBuilder: (child, val) {
                                    return FadeTransition(
                                      opacity: val,
                                      child: child,
                                    );
                                  },
                                  child: constraint.biggest.height <= 60
                                      ? Container(
                                          height: 100,
                                          // color: AppColors.white,
                                          padding: EdgeInsets.only(left: 60.w),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              productController.product!.name ??
                                                  '',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.montserrat(
                                                color: AppColors.black,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w700,
                                                // height: 0.06,
                                              ),
                                            ),
                                          ),
                                        )
                                      : productController.product!.images ==
                                              null
                                          ? const CustomImage(
                                              image: '',
                                              fit: BoxFit.cover,
                                            )
                                          : Align(
                                              alignment: Alignment.topCenter,
                                              child: SizedBox(
                                                height: 690,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: PageView.builder(
                                                        pageSnapping: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        itemCount:
                                                            productController
                                                                .product!
                                                                .images!
                                                                .length,
                                                        onPageChanged: (index) {
                                                          productController
                                                                  .setCurrentProductImageDisplayIndex =
                                                              index;
                                                        },
                                                        itemBuilder:
                                                            (context, index) {
                                                          ImageModel imageData =
                                                              productController
                                                                  .product!
                                                                  .images!
                                                                  .elementAt(
                                                                      index);
                                                          return CustomImage(
                                                            image:
                                                                imageData.src ??
                                                                    '',
                                                            fit: BoxFit.cover,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                      child: ListView.builder(
                                                        itemCount:
                                                            productController
                                                                .product!
                                                                .images!
                                                                .length,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Obx(
                                                            () => Container(
                                                              width: 8,
                                                              height: 8,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: productController
                                                                            .getCurrentProductImageDisplayIndex ==
                                                                        index
                                                                    ? AppColors
                                                                        .black
                                                                    : AppColors
                                                                        .grey,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                );
                              },
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                                padding: EdgeInsets.only(bottom: 140.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //   height: 690.0,
                                    //   child: Stack(
                                    //     children: [
                                    // Positioned.fill(
                                    //   child: Align(
                                    //     alignment: Alignment.topCenter,
                                    //     child: Container(
                                    //       height: MediaQuery.of(context)
                                    //           .size
                                    //           .width,
                                    //       decoration: const BoxDecoration(
                                    //         image: DecorationImage(
                                    //             fit: BoxFit.cover,
                                    //             image: AssetImage(
                                    //               ImagePath
                                    //                   .productDetailBgPng,
                                    //             )),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // Positioned.fill(
                                    //   top: 60,
                                    //   child:
                                    //       productController
                                    //                   .product!.images ==
                                    //               null
                                    //           ? const CustomImage(
                                    //               image: '',
                                    //               fit: BoxFit.cover,
                                    //             )
                                    //           : Align(
                                    //               alignment:
                                    //                   Alignment.topCenter,
                                    //               child: SizedBox(
                                    //                 height: 630,
                                    //                 child: Column(
                                    //                   mainAxisAlignment:
                                    //                       MainAxisAlignment
                                    //                           .start,
                                    //                   crossAxisAlignment:
                                    //                       CrossAxisAlignment
                                    //                           .center,
                                    //                   children: [
                                    //                     Expanded(
                                    //                       child: PageView
                                    //                           .builder(
                                    //                         pageSnapping:
                                    //                             true,
                                    //                         scrollDirection:
                                    //                             Axis.horizontal,
                                    //                         physics:
                                    //                             const BouncingScrollPhysics(),
                                    //                         itemCount: productController
                                    //                             .product!
                                    //                             .images!
                                    //                             .length,
                                    //                         onPageChanged:
                                    //                             (index) {
                                    //                           productController
                                    //                                   .setCurrentProductImageDisplayIndex =
                                    //                               index;
                                    //                         },
                                    //                         itemBuilder:
                                    //                             (context,
                                    //                                 index) {
                                    //                           ImageModel imageData = productController
                                    //                               .product!
                                    //                               .images!
                                    //                               .elementAt(
                                    //                                   index);
                                    //                           return CustomImage(
                                    //                             image:
                                    //                                 imageData.src ??
                                    //                                     '',
                                    //                             fit: BoxFit
                                    //                                 .cover,
                                    //                           );
                                    //                         },
                                    //                       ),
                                    //                     ),
                                    //                     SizedBox(
                                    //                       height: 20,
                                    //                       child: ListView
                                    //                           .builder(
                                    //                         itemCount: productController
                                    //                             .product!
                                    //                             .images!
                                    //                             .length,
                                    //                         scrollDirection:
                                    //                             Axis.horizontal,
                                    //                         shrinkWrap:
                                    //                             true,
                                    //                         itemBuilder:
                                    //                             (context,
                                    //                                 index) {
                                    //                           return Obx(
                                    //                               () =>
                                    //                                   Container(
                                    //                                     width: 8,
                                    //                                     height: 8,
                                    //                                     margin: const EdgeInsets.symmetric(horizontal: 5),
                                    //                                     decoration: BoxDecoration(
                                    //                                       shape: BoxShape.circle,
                                    //                                       color: productController.getCurrentProductImageDisplayIndex == index ? AppColors.classicRose : AppColors.lightRose,
                                    //                                     ),
                                    //                                   ));
                                    //                         },
                                    //                       ),
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //             ),
                                    // ),
                                    // Positioned.fill(
                                    //   top: 80,
                                    //   left: 15,
                                    //   right: 15,
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment
                                    //             .spaceBetween,
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //     children: [
                                    //       GestureDetector(
                                    //         onTap: () {
                                    //           Get.back();
                                    //         },
                                    //         child: Container(
                                    //           width: 35,
                                    //           height: 35,
                                    //           decoration:
                                    //               const BoxDecoration(
                                    //             color: Color.fromARGB(
                                    //                 255, 248, 248, 248),
                                    //             shape: BoxShape.circle,
                                    //           ),
                                    //           child: const Icon(
                                    //             Icons
                                    //                 .arrow_back_ios_new_rounded,
                                    //             size: 20,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       Container(
                                    //         width: 35,
                                    //         height: 35,
                                    //         decoration:
                                    //             const BoxDecoration(
                                    //           color: Color.fromARGB(
                                    //               255, 248, 248, 248),
                                    //           shape: BoxShape.circle,
                                    //         ),
                                    //         child: const Center(
                                    //           child: LoadSvg(
                                    //             width: 18,
                                    //             height: 18,
                                    //             imagePath: ImagePath
                                    //                 .likeForLaterSvg,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 10.h,
                                        left: 15.w,
                                        right: 15.w,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            productController.product!.name ??
                                                '',
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.poppins(
                                              color: AppColors.black,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          productController
                                                      .product!.categories ==
                                                  null
                                              ? const SizedBox()
                                              : SizedBox(
                                                  height: 40,
                                                  child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: productController
                                                        .product!
                                                        .categories!
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      Categories data =
                                                          productController
                                                              .product!
                                                              .categories!
                                                              .elementAt(index);
                                                      return Text(
                                                        '${data.name} ${index != productController.product!.categories!.length - 1 ? ' > ' : ''} ',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: AppColors
                                                              .regentGrey,
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ).copyWith(height: 0.0),
                                                      );
                                                    },
                                                  ),
                                                ),
                                          ProductTitleView(
                                              product:
                                                  productController.product),

                                          SizedBox(
                                            height: 10.h,
                                          ),

                                          productController.variationAttributes
                                                  .isNotEmpty
                                              ? Wrap(
                                                  direction: Axis.horizontal,
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.start,
                                                  children: List.generate(
                                                    productController
                                                        .variationAttributes
                                                        .length,
                                                    (index) {
                                                      Attributes data =
                                                          productController
                                                              .variationAttributes
                                                              .elementAt(index);
                                                      return Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          data.options!
                                                                  .isNotEmpty
                                                              ? ListView
                                                                  .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  itemCount:
                                                                      productController
                                                                          .variationAttributes
                                                                          .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          data.name != null
                                                                              ? '${'please_select_a'.tr} ${data.name!.capitalizeFirst}'
                                                                              : '',
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.black),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10.h,
                                                                        ),
                                                                        data.options != null &&
                                                                                data.options!.isNotEmpty
                                                                            ? Wrap(
                                                                                direction: Axis.horizontal,
                                                                                children: List.generate(
                                                                                  data.options!.length,
                                                                                  (i) {
                                                                                    String option = data.options!.elementAt(i);
                                                                                    return GestureDetector(
                                                                                      onTap: () {
                                                                                        // if (productController.getSelectedAttributeForProduct == option) {
                                                                                        //   productController.setSelectedAttributeForProduct = '';
                                                                                        // } else {
                                                                                        //   productController.setSelectedAttributeForProduct = option;
                                                                                        // }

                                                                                        productController.setCartVariationIndex(index, i, productController.product!);
                                                                                      },
                                                                                      child: AnimatedContainer(
                                                                                        duration: 200.milliseconds,
                                                                                        margin: EdgeInsets.only(right: 10.w, bottom: 10.h),
                                                                                        padding: EdgeInsets.symmetric(
                                                                                          vertical: 10.h,
                                                                                          horizontal: 20.h,
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
                                                                    );
                                                                  },
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

                                          Text(
                                            'product_details'.tr,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),

                                          productController
                                                      .product!.description ==
                                                  null
                                              ? const SizedBox()
                                              : Html(
                                                  data: productController
                                                      .product!.description!,
                                                  shrinkWrap: true,
                                                ),
                                          // Text(
                                          //   productController
                                          //           .product!.shortDescription ??
                                          //       '',
                                          //   style: textstyle14.copyWith(
                                          //     height: 0.0,
                                          //     color: AppColors.black.withOpacity(0.5),
                                          //     fontWeight: FontWeight.w400,
                                          //   ),
                                          // ),
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
                                                      double.parse(
                                                              productController
                                                                  .product!
                                                                  .averageRating
                                                                  .toString())
                                                          .toStringAsFixed(1),
                                                      style: poppinsRegular
                                                          .copyWith(
                                                        color: Theme.of(context)
                                                            .hintColor,
                                                        fontSize: Dimensions
                                                            .fontSizeLarge,
                                                      )),
                                                  const SizedBox(
                                                      width: Dimensions
                                                          .PADDING_SIZE_DEFAULT),
                                                  Text(
                                                    '${productController.product!.reviewCount.toString()} ${'reviews'.tr}',
                                                    style:
                                                        poppinsRegular.copyWith(
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                      fontSize: Dimensions
                                                          .fontSizeLarge,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  // Get.toNamed(Routes
                                                  //     .getWriteReviewRoute(
                                                  //         productController
                                                  //             .product!.id));
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
                                                          : AppColors
                                                              .classicRose,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'give_review'.tr,
                                                    style: poppinsRegular.copyWith(
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

                                          productController.reviewList !=
                                                      null &&
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
                                                  itemBuilder:
                                                      (context, index) {
                                                    ReviewModel reviewData =
                                                        productController
                                                            .reviewList!
                                                            .elementAt(index);
                                                    return Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
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
                                                                  MainAxisSize
                                                                      .max,
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
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.w500,
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
                                                                      width:
                                                                          200,
                                                                      child:
                                                                          Text(
                                                                        reviewData.name ??
                                                                            '',
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          5.h,
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
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: poppinsBold.copyWith(
                                                                  fontSize:
                                                                      Dimensions
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
                                                          reviewData.review ??
                                                              '-',
                                                          style: GoogleFonts
                                                              .poppins(
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
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
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
                                          productController.product!.relatedIds!
                                                  .isNotEmpty
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
                                                          .relatedProductList!
                                                          .length,
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
                                                      'no_related_product_found'
                                                          .tr)),

                                          //! Just for Backup
                                          /*
                                        Text(
                                          Strings.lbl_select_colour,
                                          textAlign: TextAlign.center,
                                          style: textstyle18.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: Dimens.pixel_15_7,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: Dimens.pixel_20,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: 4,
                                            itemBuilder: (context, index) {
                                              return const CircleAvatar(
                                                backgroundColor: AppColors.black,
                                                radius: Dimens.pixel_12,
                                              );
                                            },
                                            separatorBuilder:
                                                (BuildContext context, int index) {
                                              return const SizedBox(
                                                width: Dimens.pixel_5,
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: Dimens.pixel_30_7,
                                        ),
                                        Text(
                                          Strings.lbl_select_size,
                                          textAlign: TextAlign.center,
                                          style: textstyle18.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: Dimens.pixel_15,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: Dimens.pixel_45,
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                // width: 37,
                                                // height: 37,
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: Dimens.pixel_10,
                                                  horizontal: Dimens.pixel_10,
                                                ),
                                                decoration: const ShapeDecoration(
                                                  shape: OvalBorder(
                                                    side: BorderSide(
                                                      width: 1,
                                                      color: AppColors.regentGrey,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  '38',
                                                  textAlign: TextAlign.center,
                                                  style: textstyle18,
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const SizedBox(
                                                width: Dimens.pixel_20,
                                              );
                                            },
                                            itemCount: 4,
                                          ),
                                        ) */
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: productController.product != null
              ? Padding(
                  padding: EdgeInsets.only(left: 18.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            /// instamojo api demo
                            await Get.toNamed(Routes.instamojoApiDemo)
                                ?.then((value) {
                              if (value != null) {
                                homeController.setPaymemtStatusRes = value;
                              }
                            });

                            // instamojo sdk demo
                            // Get.toNamed(Routes.instamojoPaymentScreen);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightoysterPink),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 27.h,
                              // horizontal: 94.0,
                            ),
                            child: Text(
                              'BUY NOW',
                              style: GoogleFonts.poppins(
                                color: AppColors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 38.w,
                      ),
                      Badge(
                        backgroundColor: Colors.white,
                        largeSize: 30,
                        smallSize: 20,
                        label: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 22,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            productController.calculateProductPrice(
                                productController.product!);
                            productController.createProductCartModel(
                                productController.product!, false);
                            Get.find<CartController>().addToCart(
                                productController.cartModel,
                                productController.cartIndex);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 20.h,
                            ),
                            decoration: const ShapeDecoration(
                              color: AppColors.brightGrey,
                              shape: OvalBorder(),
                            ),
                            child: const SvgIcon(
                              imagePath: ImagePath.cartSvg,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
        ),
      );
    });
  }
}
