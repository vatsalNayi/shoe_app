import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoes_app/global_widgets/custom_appbar.dart';
import 'package:shoes_app/global_widgets/no_data_page.dart';
import 'package:shoes_app/models/product_model.dart';
import 'package:shoes_app/module/wishlist/widgets/wished_items.dart';
import 'controller/wish_controller.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});
  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  void initState() {
    Get.find<WishListController>().getWishList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishListController>(builder: (wishListController) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        appBar: CustomAppBar(
          // leadingIcon: ImagePath.backLeftSvg,
          title: 'Favorites'.tr,
        ),
        body: wishListController.wishProductList != null
            ? wishListController.wishProductList!.isNotEmpty
                ? Container(
                    width: Get.width,
                    height: Get.height,
                    padding: EdgeInsets.all(25.w),
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: wishListController.wishProductList!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: Get.width / 680,
                        ),
                        itemBuilder: (context, index) {
                          ProductModel productData = wishListController
                              .wishProductList!
                              .elementAt(index);
                          return WishedItems(
                            productData: productData,
                            index: index,
                          );
                        },
                      ),
                    ),
                  )
                : NoDataScreen(
                    text: 'your_wish_list_is_empty'.tr, type: NoDataType.WISH)
            : const Center(
                child: CupertinoActivityIndicator(),
              ),
      );
    });
  }
}
