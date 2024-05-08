import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoes_app/core/values/colors.dart';
import 'package:shoes_app/core/values/strings.dart';
import 'package:shoes_app/global_widgets/svg_icon.dart';
import 'package:shoes_app/models/product_model.dart';
import 'package:shoes_app/module/product_details/product_details_controller.dart';
import 'package:shoes_app/module/wishlist/controller/wish_controller.dart';

class PageViewWidget extends StatelessWidget {
  final product;
  PageViewWidget({
    super.key,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    ProductDetailsController controller = Get.put(ProductDetailsController());
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 225.h,
            // width: 200.w,
            child: PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: product!.images!.length,
              itemBuilder: (context, index) {
                ImageModel imageData = product!.images!.elementAt(index);
                return Stack(
                  children: [
                    Positioned(
                      right: 0.0,
                      bottom: 25.0,
                      child: Container(
                        width: 340.w,
                        height: 159.h,
                        decoration: BoxDecoration(
                            color: AppColors.lightGreen.withOpacity(0.4),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.r),
                              topLeft: Radius.circular(20.r),
                            )),
                        child: Center(
                          child: Container(), // empty Container
                        ),
                      ),
                    ),
                    Positioned.fill(
                      bottom: -10,
                      child: Image.network(
                        '${imageData.src}',
                        // height: 180.h,
                        // width: 231.w,
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          ImagePath.shadow,
                          width: 300.w,
                          height: 12.h,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 24.0,
                      right: 24.0,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: [
                            GetBuilder<WishListController>(
                                builder: (wishlistController) {
                              return GestureDetector(
                                onTap: () async {
                                  Get.find<WishListController>()
                                      .addProductToWishlist(product!);
                                },
                                child: SvgIcon(
                                  imagePath: wishlistController.wishIdList
                                          .contains(product!.id)
                                      ? ImagePath.saved
                                      : ImagePath.unsave,
                                ),
                              );
                            }),
                            SizedBox(
                              height: 11.h,
                            ),
                            Container(
                              width: 28.w,
                              height: 28.h,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const SvgIcon(
                                imagePath: ImagePath.share,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              // children: <Widget>[
              // Stack(
              //   children: [
              //     Positioned(
              //       right: 0.0,
              //       bottom: 25.0,
              //       child: Container(
              //         width: 340.w,
              //         height: 159.h,
              //         decoration: BoxDecoration(
              //             color: AppColors.lightGreen.withOpacity(0.4),
              //             borderRadius: BorderRadius.only(
              //               bottomLeft: Radius.circular(20.r),
              //               topLeft: Radius.circular(20.r),
              //             )),
              //         child: Center(
              //           child: Container(), // empty Container
              //         ),
              //       ),
              //     ),
              //     Positioned.fill(
              //       bottom: -11,
              //       child: Image.asset(
              //         ImagePath.shoe3,
              //       ),
              //     ),
              //     Positioned.fill(
              //       child: Align(
              //         alignment: Alignment.bottomCenter,
              //         child: Image.asset(
              //           ImagePath.shadow,
              //           width: 300.w,
              //           height: 12.h,
              //         ),
              //       ),
              //     ),
              //     Positioned.fill(
              //       top: 24.0,
              //       right: 24.0,
              //       child: Align(
              //         alignment: Alignment.topRight,
              //         child: Column(
              //           children: [
              //             const SvgIcon(
              //               imagePath: ImagePath.saved,
              //             ),
              //             SizedBox(
              //               height: 11.h,
              //             ),
              //             Container(
              //               width: 28.w,
              //               height: 28.h,
              //               decoration: const BoxDecoration(
              //                 color: AppColors.white,
              //                 shape: BoxShape.circle,
              //               ),
              //               child: const SvgIcon(
              //                 imagePath: ImagePath.share,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // Container(
              //   height: 100.h,
              //   width: 100.w,
              //   color: AppColors.lightGreen,
              //   child: const Center(child: Text('Page 2')),
              // ),
              // Container(
              //   height: 100.h,
              //   width: 100.w,
              //   color: Colors.red,
              //   child: const Center(child: Text('Page 3')),
              // ),
              // ],
            ),
          ),
          const SizedBox(height: 20.0),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < product!.images!.length; i++)
          GetBuilder<ProductDetailsController>(builder: (controller) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    controller.getCurrentPage == i ? Colors.blue : Colors.grey,
              ),
            );
          }),
      ],
    );
  }
}
