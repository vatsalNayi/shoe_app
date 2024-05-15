import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/controller/config_controller.dart';
import 'package:shoes_app/module/address/location_controller.dart';
import 'package:shoes_app/module/cart/cart_controller.dart';
import 'package:shoes_app/module/home/products/controller/product_controller.dart';
import 'package:shoes_app/module/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  /// NOTE: Changed type of variable List<ConnectivityResult> from ConnectivityResult
  /// change back to ConnectivityResult (if not compatible)
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;

  @override
  void initState() {
    int count = 0;
    _onConnectivityChanged = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      count += 1;
      if (count >= 2) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;

        isNotConnected
            ? const SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected
              ? Colors.red
              : const Color.fromARGB(255, 69, 134, 71),
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected'.tr,
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          Get.find<ConfigController>().getGeneralSettings();
          //Get.find<ConfigController>().getTaxSettings();
          Get.find<ConfigController>().getTaxClasses();
        }
      }
    });
    Get.find<ConfigController>().initSharedData();
    Get.find<CartController>().getCartList();
    Get.find<ConfigController>().getTaxSettings();
    Get.find<ConfigController>().getTaxClasses();
    Get.find<CartController>().initList();
    Get.find<LocationController>().initList();
    Get.find<ProductController>().initDynamicLinks();
    SplashController().redirectToDestination();
    super.initState();
  }

  @override
  void dispose() {
    _onConnectivityChanged.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: Text(
          'Splash screen',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            // height: 0.03,
          ),
        ),
      ),
    );
  }
}
