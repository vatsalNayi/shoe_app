import 'package:get/get.dart';
import 'package:shoes_app/core/values/strings.dart';

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
}
