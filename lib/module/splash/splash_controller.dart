import 'dart:async';
import 'package:get/get.dart';
import 'package:shoes_app/controller/config_controller.dart';
import 'package:shoes_app/module/auth/controller/auth_controller.dart';
import 'package:shoes_app/routes/pages.dart';

class SplashController extends GetxController {
  void redirectToDestination() async {
    Future.delayed(const Duration(seconds: 3), () {
      Get.find<ConfigController>().getTaxClasses();

      if (Get.find<AuthController>().getIsWelcomed() != null &&
          Get.find<AuthController>().getIsWelcomed()) {
        Get.offAllNamed(Routes.dashboardPage);
      } else {
        Get.offAllNamed(Routes.welcomePage);
      }
    });
  }
}
