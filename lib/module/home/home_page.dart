import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/core/values/strings.dart';
import 'package:shoes_app/global_widgets/custom_appbar.dart';
import 'package:shoes_app/global_widgets/custom_textfield.dart';
import 'package:shoes_app/global_widgets/svg_icon.dart';
import 'package:shoes_app/global_widgets/textfield_decoration.dart';
import 'package:shoes_app/helper/product_type.dart';
import 'package:shoes_app/module/home/home_controller.dart';
import 'package:shoes_app/module/home/products/all_product_screen.dart';
import 'package:shoes_app/module/home/products/controller/product_controller.dart';
import 'package:shoes_app/module/home/widgets/grid_product.dart';
import 'package:shoes_app/module/home/widgets/horizontal_product_list.dart';
import 'package:shoes_app/module/home/widgets/popular_product_view.dart';
import '../../routes/pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Hi there!',
        leadingIcon: ImagePath.homeMenu,
        trailingIcon: ImagePath.notification,
        onTapTrailing: () {
          debugPrint('Notification pressed');
          Get.toNamed(Routes.getNotificationRoute());
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.getSearchRoute());
                },
                child: customDecorationForTextfield(
                  child: CustomTextfield(
                    isEnabled: false,
                    hintText: 'Search for products',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    prefixIcon: const SvgIcon(
                      imagePath: ImagePath.search,
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 20.h,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text(
                  //   'Footwears For Men',
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // const HorizontalProductList(
                  //     image:
                  //         'https://plus.unsplash.com/premium_photo-1713163890188-6807aa2641de?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMjJ8fHxlbnwwfHx8fHw%3D'),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // const Text(
                  //   'Shop by color',
                  // ),
                  // SizedBox(
                  //   height: 17.h,
                  // ),
                  // const HorizontalProductList(
                  //     image:
                  //         'https://images.unsplash.com/photo-1712971578942-8d44b2d77143?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNDN8fHxlbnwwfHx8fHw%3D'),
                  // SizedBox(
                  //   height: 19.h,
                  // ),
                  // Text(
                  //   'Popular Brand',
                  //   style: GoogleFonts.poppins(
                  //     fontSize: 20.sp,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 18.h,
                  // ),
                  // SizedBox(
                  //   height: 90.h,
                  //   child: GetBuilder<ProductController>(
                  //       builder: (productController) {
                  //     return ListView.separated(
                  //       shrinkWrap: true,
                  //       scrollDirection: Axis.horizontal,
                  //       itemCount: controller.logosList.length,
                  //       separatorBuilder: (context, index) => SizedBox(
                  //         width: 24.w,
                  //       ),
                  //       itemBuilder: (context, index) {
                  //         return Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             CircleAvatar(
                  //               radius: 30.r,
                  //               backgroundColor: AppColors.bgColorLogo,
                  //               child: const SvgIcon(
                  //                 imagePath: ImagePath.notification,
                  //               ),
                  //             ),
                  //             Text(
                  //               'data',
                  //               style: GoogleFonts.poppins(
                  //                 fontSize: 13.sp,
                  //                 fontWeight: FontWeight.w500,
                  //               ),
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //   }),
                  // ),
                  SizedBox(
                    height: 18.h,
                  ),
                  const PopularProductView(isPopular: true),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'For You',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const AllProductScreen(
                                productType: ProductType.LATEST_PRODUCT,
                                // productType: isPopular
                                //     ? ProductType.POPULAR_PRODUCT
                                //     : newArrival
                                //         ? ProductType.LATEST_PRODUCT
                                //         : ProductType.REVIEWED_PRODUCT,
                              ));
                        },
                        child: Row(
                          children: [
                            Text(
                              'View more',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            const SvgIcon(
                              imagePath: ImagePath.doubleArrow,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  GetBuilder<ProductController>(
                    builder: (productController) {
                      final productList = productController.productList;
                      return productController.productList == null
                          ? const SizedBox()
                          : productController.isLoading
                              ? const Center(
                                  child: CupertinoActivityIndicator())
                              : GridView.builder(
                                  itemCount: productList!.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.w,
                                    mainAxisSpacing: 15.h,
                                    childAspectRatio:
                                        0.7, // Gridview's item's size
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            Routes.getProductDetailsRoute(
                                          productList[index].id,
                                          null,
                                          false,
                                        ));
                                      },
                                      child: GridProducts(
                                          productList: productList[index]),
                                    );
                                  },
                                );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
