// import 'dart:async';
// import 'dart:developer';
// import 'package:e_commerce/core/values/strings.dart';
// import 'package:e_commerce/custom_widgets/custom_button_comp.dart';
// import 'package:e_commerce/routes/pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../core/utils/util_woo/dimensions.dart';
// import '../../core/utils/util_woo/styles.dart';
// import '../auth_pages/controller_woo/auth_controller.dart';
// import '../order/order_tracking_screen.dart';
// import 'widgets/payment_failed_dialog.dart';

// class OrderSuccessfulScreen extends StatefulWidget {
//   final String? orderID;
//   final bool success;
//   final bool orderNow;
//   const OrderSuccessfulScreen(
//       {super.key,
//       required this.orderID,
//       required this.success,
//       required this.orderNow});

//   @override
//   State<OrderSuccessfulScreen> createState() => _OrderSuccessfulScreenState();
// }

// class _OrderSuccessfulScreenState extends State<OrderSuccessfulScreen> {
//   @override
//   void initState() {
//     super.initState();

//     if (!widget.success) {
//       Future.delayed(const Duration(seconds: 1), () {
//         Get.dialog(PaymentFailedDialog(orderID: int.parse(widget.orderID!)),
//             barrierDismissible: false);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     log('----order=id--->${widget.orderID}');
//     log('-----OrderNowSuccessScreen---->${widget.orderNow}');

//     return PopScope(
//       canPop: true,
//       onPopInvoked: (_) async {
//         if (widget.orderNow) {
//           Get.toNamed(Routes.bottomBarPage);
//         } else {
//           Get.toNamed(Routes.bottomBarPage);
//         }
//       },
//       child: Scaffold(
//         body: Center(
//           child: SingleChildScrollView(
//             child: SizedBox(
//                 width: Dimensions.WEB_MAX_WIDTH,
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                           widget.success
//                               ? ImagePath.success
//                               : ImagePath.warning,
//                           width: 100,
//                           height: 100),
//                       const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
//                       Text(
//                         widget.success
//                             ? 'you_placed_the_order_successfully'.tr
//                             : 'your_order_is_failed_to_place'.tr,
//                         style: robotoMedium.copyWith(
//                             fontSize: Dimensions.fontSizeLarge),
//                       ),
//                       const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: Dimensions.PADDING_SIZE_LARGE,
//                             vertical: Dimensions.PADDING_SIZE_SMALL),
//                         child: Text(
//                           widget.success
//                               ? 'your_order_is_placed_successfully'.tr
//                               : 'your_order_is_failed_to_place_because'.tr,
//                           style: robotoMedium.copyWith(
//                               fontSize: Dimensions.fontSizeSmall,
//                               color: Theme.of(context).hintColor),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       if (!Get.find<AuthController>().isLoggedIn())
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: Dimensions.PADDING_SIZE_LARGE,
//                               vertical: Dimensions.PADDING_SIZE_SMALL),
//                           child: Text(
//                             '${'your_order_id_is'.tr} : ${widget.orderID.toString()}',
//                             style: robotoMedium.copyWith(
//                                 fontSize: Dimensions.fontSizeDefault),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       const SizedBox(height: 50),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => OrderTrackingScreen(
//                                     order: null,
//                                     orderId:
//                                         int.parse(widget.orderID.toString()))),
//                           );
//                           // Get.to(()=> OrderTrackingScreen(orderId: int.parse(widget.orderID.toString())));
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(
//                               Dimensions.PADDING_SIZE_DEFAULT),
//                           child: Text(
//                             'track_order'.tr,
//                             style: robotoBold.copyWith(
//                                 color: Theme.of(context).primaryColor),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding:
//                             const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//                         child: CustomButtonSec(
//                             buttonText: 'continue_shopping'.tr,
//                             radius: 50,
//                             width: 250,
//                             onPressed: () =>
//                                 Get.offAllNamed(Routes.bottomBarPage)),
//                       ),
//                     ])),
//           ),
//         ),
//       ),
//     );
//   }
// }
