// import 'dart:developer';

// import 'package:e_commerce/custom_widgets/custom_button_comp.dart';
// import 'package:e_commerce/custom_widgets/custom_textfield.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';

// import '../../controller/config_controller.dart';
// import '../../core/utils/util_woo/dimensions.dart';
// import '../../core/utils/util_woo/styles.dart';
// import '../../custom_widgets/custom_appbar.dart';
// import '../../helper_woo/responsive_helper.dart';
// import '../auth_pages/controller_woo/auth_controller.dart';
// import '../bottom_pages/cart/controller/cart_controller.dart';
// import '../bottom_pages/cart/model/cart_model.dart';
// import '../bottom_pages/cart/model/coupon_model.dart';
// import '../bottom_pages/profile/address/location_controller.dart';
// import '../bottom_pages/profile/profile_controller.dart';
// import '../bottom_pages/profile/widgets/profile_address_card.dart';
// import '../order/controller/order_controller.dart';
// import 'models/shipping_method_model.dart';
// import 'widgets/address_card.dart';
// import 'widgets/payment_button.dart';

// class CheckoutScreen extends StatefulWidget {
//   final double? orderAmount;
//   final bool reOrder;
//   final bool orderNow;
//   final CouponModel? coupon;
//   final ShippingMethodModel? shippingMethod;
//   final List<CartModel?>? cartList;
//   final int? shippingIndex;
//   const CheckoutScreen(
//       {super.key,
//       required this.coupon,
//       required this.shippingMethod,
//       required this.orderAmount,
//       this.reOrder = false,
//       this.cartList,
//       this.shippingIndex,
//       this.orderNow = false});

//   @override
//   CheckoutScreenState createState() => CheckoutScreenState();
// }

// class CheckoutScreenState extends State<CheckoutScreen> {
//   final TextEditingController _noteController = TextEditingController();
//   bool? _isLoggedIn;
//   List<CartModel?>? _cartList;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _isLoggedIn = Get.find<AuthController>().isLoggedIn();
//     if (_isLoggedIn!) {
//       Get.find<ProfileController>().getUserInfo();
//     }

//     _cartList = [];
//     if (widget.cartList != null) {
//       _cartList!.addAll(widget.cartList!);
//       log("${widget.cartList!.length}");
//       log("${_cartList!.length}");
//     } else {
//       _cartList!.addAll(Get.find<CartController>().cartList!);
//     }
//     Get.find<OrderController>().initData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: (Get.find<OrderController>().isLoading) ? false : true,
//       child: Scaffold(
//         appBar: CustomAppBar(
//           title: 'checkout'.tr,
//         ),
//         body: GetBuilder<LocationController>(builder: (locationController) {
//           return GetBuilder<ProfileController>(builder: (profileController) {
//             return GetBuilder<OrderController>(builder: (orderController) {
//               return (Get.find<ConfigController>().settings!.accountSettings !=
//                           null) &&
//                       (!_isLoggedIn! || profileController.profileModel != null)
//                   ? Column(
//                       children: [
//                         Expanded(
//                             child: Scrollbar(
//                                 child: SingleChildScrollView(
//                           physics: const BouncingScrollPhysics(),
//                           padding: const EdgeInsets.all(
//                               Dimensions.PADDING_SIZE_SMALL),
//                           child: SizedBox(
//                             width: Dimensions.WEB_MAX_WIDTH,
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   locationController.profileBillingSelected ==
//                                           true
//                                       ? ProfileAddressCard(
//                                           title: 'select_billing_address'.tr,
//                                           address: Get.find<ProfileController>()
//                                               .profileBillingAddress,
//                                           billingAddress: true,
//                                           fromProfile: false,
//                                         )
//                                       : const SizedBox(),
//                                   locationController.profileBillingSelected ==
//                                           true
//                                       ? const SizedBox()
//                                       : AddressCard(
//                                           title: 'select_billing_address'.tr,
//                                           address: locationController
//                                                       .selectedBillingAddressIndex ==
//                                                   -1
//                                               ? null
//                                               : locationController
//                                                       .addressList!.isNotEmpty
//                                                   ? locationController
//                                                           .addressList![
//                                                       locationController
//                                                           .selectedBillingAddressIndex!]
//                                                   : null,
//                                           billingAddress: true,
//                                           fromProfile: false,
//                                         ),
//                                   const SizedBox(
//                                       height: Dimensions.PADDING_SIZE_LARGE),
//                                   Get.find<ConfigController>().payment.isEmpty
//                                       ? const SizedBox()
//                                       : Text('choose_payment_method'.tr,
//                                           style: robotoMedium),
//                                   Get.find<ConfigController>().payment.isEmpty
//                                       ? const SizedBox()
//                                       : const SizedBox(
//                                           height:
//                                               Dimensions.PADDING_SIZE_SMALL),
//                                   Get.find<ConfigController>().payment.isEmpty
//                                       ? const SizedBox()
//                                       : SizedBox(
//                                           height: 65,
//                                           child: ListView.builder(
//                                             scrollDirection: Axis.horizontal,
//                                             shrinkWrap: true,
//                                             itemCount:
//                                                 Get.find<ConfigController>()
//                                                     .payment
//                                                     .length,
//                                             padding: EdgeInsets.zero,
//                                             itemBuilder: (context, index) {
//                                               return PaymentButton(
//                                                 isSelected: orderController
//                                                         .paymentMethodIndex ==
//                                                     index,
//                                                 title:
//                                                     Get.find<ConfigController>()
//                                                         .payment[index]
//                                                         .title
//                                                         .tr,
//                                                 subtitle:
//                                                     Get.find<ConfigController>()
//                                                         .payment[index]
//                                                         .description
//                                                         .tr,
//                                                 icon:
//                                                     Get.find<ConfigController>()
//                                                         .payment[index]
//                                                         .icon,
//                                                 onTap: () => orderController
//                                                     .setPaymentMethod(index),
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                   const SizedBox(
//                                       height: Dimensions.PADDING_SIZE_LARGE),
//                                   CustomTextfield(
//                                     controller: _noteController,
//                                     hintText: 'additional_note'.tr,
//                                     maxLines: 3,
//                                     inputType: TextInputType.multiline,
//                                     textInputAction: TextInputAction.newline,
//                                     capitalization:
//                                         TextCapitalization.sentences,
//                                   ),
//                                   const SizedBox(
//                                       height: Dimensions.PADDING_SIZE_LARGE),
//                                   (!Get.find<AuthController>().isLoggedIn() &&
//                                           Get.find<ConfigController>()
//                                               .checkoutLoginReminder())
//                                       ? Padding(
//                                           padding: const EdgeInsets.all(
//                                               Dimensions.PADDING_SIZE_SMALL),
//                                           child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Text('returning_customer'.tr,
//                                                     style: robotoRegular),
//                                                 const SizedBox(
//                                                     width: Dimensions
//                                                         .PADDING_SIZE_EXTRA_SMALL),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     // Get.toNamed(RouteHelper
//                                                     //     .getSignInRoute());
//                                                   },
//                                                   child: Text(
//                                                       'click_here_to_login'.tr,
//                                                       style: robotoMedium.copyWith(
//                                                           color: Get.isDarkMode
//                                                               ? Theme.of(
//                                                                       context)
//                                                                   .colorScheme
//                                                                   .primaryContainer
//                                                                   .withOpacity(
//                                                                       0.90)
//                                                               : Theme.of(
//                                                                       context)
//                                                                   .primaryColor)),
//                                                 )
//                                               ]),
//                                         )
//                                       : const SizedBox(),
//                                   ResponsiveHelper.isDesktop(context)
//                                       ? Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: Dimensions
//                                                   .PADDING_SIZE_LARGE),
//                                           child: _orderPlaceButton(
//                                               orderController,
//                                               profileController,
//                                               locationController),
//                                         )
//                                       : const SizedBox(),
//                                 ]),
//                           ),
//                         ))),
//                         _orderPlaceButton(orderController, profileController,
//                             locationController),
//                       ],
//                     )
//                   : const Center(child: CircularProgressIndicator());
//             });
//           });
//         }),
//       ),
//     );
//   }

//   Widget _orderPlaceButton(
//       OrderController orderController,
//       ProfileController profileController,
//       LocationController locationController) {
//     return Container(
//       width: Dimensions.WEB_MAX_WIDTH,
//       alignment: Alignment.center,
//       padding: ResponsiveHelper.isDesktop(context)
//           ? null
//           : const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//       // !orderController.isLoading
//       child: (!orderController.isLoading && !orderController.isPaymentLoading)
//           ? CustomButtonSec(
//               buttonText: 'confirm_order'.tr,
//               radius: 50,
//               onPressed: () async {
//                 log("${locationController.selectedBillingAddressIndex == -1 && !locationController.profileBillingSelected}");
//                 orderController.checkout(
//                   Get.find<ConfigController>().enabledGuestCheckout(),
//                   _isLoggedIn,
//                   (locationController.selectedBillingAddressIndex == -1 &&
//                       !locationController.profileBillingSelected),
//                   (Get.find<ConfigController>().payment.isNotEmpty),
//                   Get.find<ConfigController>().payment.isNotEmpty
//                       ? Get.find<ConfigController>()
//                           .payment[orderController.paymentMethodIndex]
//                       : null,
//                   _noteController.text.trim(),
//                   locationController.profileShippingSelected
//                       ? Get.find<ProfileController>().profileShippingAddress
//                       : Get.find<ProfileController>().convertProfileAddress(
//                           locationController
//                               .addressList![widget.shippingIndex!]),
//                   locationController.profileBillingSelected
//                       ? Get.find<ProfileController>().profileBillingAddress
//                       : locationController.selectedBillingAddressIndex != -1
//                           ? Get.find<ProfileController>().convertProfileAddress(
//                               locationController.addressList![locationController
//                                   .selectedBillingAddressIndex!])
//                           : null,
//                   _cartList,
//                   widget.coupon,
//                   widget.shippingMethod,
//                   widget.orderAmount,
//                   widget.orderNow,
//                 );
//                 if (orderController.isLoading ||
//                     orderController.isPaymentLoading) {
//                   if (_isLoading == true) {
//                     setState(() {
//                       _isLoading = false;
//                     });
//                   }
//                 }
//               })
//           : const SizedBox(),
//     );
//   }
// }
