import 'package:get/get.dart';
import 'package:shoes_app/core/values/strings.dart';
import 'package:shoes_app/models/category_model.dart';
import 'package:shoes_app/module/auth/controller/auth_controller.dart';
import 'package:shoes_app/module/categories/controller/category_controller.dart';
import 'package:shoes_app/module/home/products/controller/product_controller.dart';
import 'package:shoes_app/module/more/profile/profile_controller.dart';
import 'package:shoes_app/module/wishlist/controller/wish_controller.dart';

class HomeController extends GetxController {
  List<String> logosList = [
    ImagePath.asicsLogo,
    ImagePath.nikeLogo,
    ImagePath.gucciLogo,
    ImagePath.reebokLogo,
    ImagePath.adidasLogo,
  ];

  var paymentStatusRes = {}.obs;
  Map<dynamic, dynamic> get getPaymentStatusRes => paymentStatusRes;
  set setPaymemtStatusRes(Map<dynamic, dynamic> val) =>
      paymentStatusRes.value = val;

  @override
  void onInit() {
    loadData(false);
    super.onInit();
  }

  void loadData(bool reload) {
    Get.find<WishListController>().getWishList();
    Get.find<CategoryController>().getCategoryList(reload, 1);
    // controller.getSubCategoryList(controller.selectedMainCategoryData);
    // Get.find<CategoryController>().getSubCategoryList();
    Get.find<ProductController>().getProductList(1, reload);
    Get.find<ProductController>().getPopularProductList(reload, false, 1);
    Get.find<ProductController>().getSaleProductList(reload, false, 1);
    Get.find<ProductController>().getReviewedProductList(reload, false);
    Get.find<ProductController>().getGroupedProductList(reload, false, 1);
    // Get.find<BannerController>().getBannerList();
    // if(AppConstants.vendorType != VendorType.singleVendor) {
    //   Get.find<ShopController>().getShopList(1);
    // }
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn && Get.find<ProfileController>().profileModel == null) {
      Get.find<ProfileController>().getUserInfo();
    }
  }
}
