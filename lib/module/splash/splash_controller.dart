import 'package:get/get.dart';
import 'package:shoes_app/routes/pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    redirectToDestination();
    super.onInit();
  }

  void redirectToDestination() async {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.find<ConfigController>().getTaxClasses();
      //
      Get.offAllNamed(Routes.welcomePage);
      // }
    });
  }
}
