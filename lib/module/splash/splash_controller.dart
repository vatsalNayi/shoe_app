import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/controller/config_controller.dart';
import 'package:shoes_app/module/address/location_controller.dart';
import 'package:shoes_app/module/cart/cart_controller.dart';
import 'package:shoes_app/module/home/products/controller/product_controller.dart';
import 'package:shoes_app/routes/pages.dart';

class SplashController extends GetxController {
  // GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  // TODO: dispose stream subscription in Dispose method.
  // late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void onInit() {
    int count = 0;
    // _onConnectivityChanged = Connectivity()
    //     .onConnectivityChanged
    //     .listen((ConnectivityResult result) {
    //   count += 1;
    //   if (count > 2) {
    //     bool isNotConnected = result != ConnectivityResult.wifi &&
    //         result != ConnectivityResult.mobile;

    //     isNotConnected
    //         ? SizedBox()
    //         : ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       backgroundColor: isNotConnected
    //           ? Colors.red
    //           : const Color.fromARGB(255, 69, 134, 71),
    //       duration: Duration(seconds: isNotConnected ? 6000 : 3),
    //       content: Text(
    //         isNotConnected ? 'no_connection'.tr : 'connected'.tr,
    //         textAlign: TextAlign.center,
    //       ),
    //     ));
    //     if (!isNotConnected) {
    //       Get.find<ConfigController>().getGeneralSettings();
    //       //Get.find<ConfigController>().getTaxSettings();
    //       Get.find<ConfigController>().getTaxClasses();
    //     }
    //   }
    // });
    Get.find<ConfigController>().initSharedData();
    Get.find<CartController>().getCartList();
    Get.find<ConfigController>().getTaxSettings();
    Get.find<ConfigController>().getTaxClasses();
    Get.find<CartController>().initList();
    Get.find<LocationController>().initList();
    Get.find<ProductController>().initDynamicLinks();
    SplashController().redirectToDestination();

    redirectToDestination();
    super.onInit();
  }

  // @override
  // void onClose() {
  // todo: not working here need to dispose
  //   _onConnectivityChanged.cancel();
  //   super.onClose();
  // }

  void redirectToDestination() async {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.find<ConfigController>().getTaxClasses();
      //
      Get.offAllNamed(Routes.dashboardPage);
      // }
    });
  }
}
