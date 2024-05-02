import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/controller/config_controller.dart';
import 'package:shoes_app/core/values/colors.dart';
import 'package:shoes_app/core/values/strings.dart';
import 'package:shoes_app/global_widgets/custom_appbar.dart';
import 'package:shoes_app/global_widgets/custom_button.dart';
import 'package:shoes_app/global_widgets/no_data_page.dart';
import 'package:shoes_app/global_widgets/show_snackbar.dart';
import 'package:shoes_app/models/cart_model.dart';
import 'package:shoes_app/models/coupon_model.dart';
import 'package:shoes_app/module/address/location_controller.dart';
import 'package:shoes_app/module/cart/cart_controller.dart';
import 'package:shoes_app/module/checkout/checkout_screen.dart';
import 'package:shoes_app/module/checkout/models/shipping_method_model.dart';
import 'package:shoes_app/module/coupon/controller/coupon_controller.dart';
import 'package:shoes_app/module/more/profile/profile_controller.dart';
import 'package:shoes_app/module/order/controller/order_controller.dart';
import 'widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  final bool fromOrder;
  final fromNav;
  final CartModel? cartModel;
  const CartPage({
    super.key,
    this.fromOrder = false,
    required this.fromNav,
    this.cartModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cart',
        automaticallyImplyLeading: false,
        trailingIcon: ImagePath.cartBlack,
      ),
      body: GetBuilder<CartController>(builder: (cartController) {
        return GetBuilder<LocationController>(builder: (locationController) {
          return GetBuilder<ProfileController>(builder: (profileController) {
            return GetBuilder<CouponController>(builder: (couponController) {
              return GetBuilder<OrderController>(builder: (orderController) {
                double _shippingFee = 0;
                double _shippingTax = 0;
                double _tax = 0;
                double _couponDiscount = couponController.discount;
                double minShippingAmount = 0;
                List<CartModel?>? _cartList = [];

                if (cartModel != null) {
                  _cartList = [cartModel];
                } else {
                  _cartList = cartController.cartList;
                }

                if (_cartList != null) {
                  cartController.calculateProductPrice(_cartList!);
                }
                _shippingFee = cartController.calculateShippingFee(
                    _cartList!,
                    ((orderController.shippingIndex != -1 &&
                            orderController.shippingMethodList!.isNotEmpty)
                        ? orderController
                            .shippingMethodList![orderController.shippingIndex!]
                        : null));
                if (Get.find<ConfigController>().calculateTax()) {
                  _tax = cartController.calculateTax(
                      _cartList,
                      Get.find<ConfigController>().taxClassList,
                      couponController.itemDiscountList,
                      locationController.selectedShippingAddressIndex != -1
                          ? locationController.addressList![
                              locationController.selectedShippingAddressIndex!]
                          : null,
                      profileController.profileShippingAddress,
                      locationController.profileShippingSelected == true);
                  _shippingTax = cartController.calculateShippingTax(
                      _cartList,
                      Get.find<ConfigController>().taxClassList!,
                      _tax,
                      locationController.selectedShippingAddressIndex != -1
                          ? locationController.addressList![
                              locationController.selectedShippingAddressIndex!]
                          : null,
                      profileController.profileShippingAddress,
                      locationController.profileShippingSelected == true);
                }
                cartController.couponController.text =
                    Get.find<CouponController>().selectedCouponCode != null
                        ? Get.find<CouponController>().selectedCouponCode!
                        : '';

                double _subTotal =
                    cartController.productPrice - cartController.discount;
                double _total = _subTotal -
                    _couponDiscount +
                    _tax +
                    _shippingFee +
                    _shippingTax;
                return _cartList.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              itemCount: 3,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 24.h,
                                );
                              },
                              itemBuilder: (context, index) {
                                return CartItem(controller: cartController);
                              },
                            ),
                            SizedBox(
                              height: 36.h,
                            ),
                            Container(
                              color: AppColors.bgGrey.withOpacity(0.3),
                              padding: EdgeInsets.all(20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Price Details',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Amount',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              AppColors.black.withOpacity(0.7),
                                        ),
                                      ),
                                      Text(
                                        '\$137.45',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Discount',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              AppColors.black.withOpacity(0.7),
                                        ),
                                      ),
                                      Text(
                                        '10%',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Delivery Charge',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              AppColors.black.withOpacity(0.7),
                                        ),
                                      ),
                                      Text(
                                        '0',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Amount',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              AppColors.black.withOpacity(0.7),
                                        ),
                                      ),
                                      Text(
                                        '\$123.70',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.lightGreen,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  CustomButton(
                                    radius: 15.r,
                                    onPress: () {
                                      if (locationController
                                                  .selectedShippingAddressIndex ==
                                              -1 &&
                                          !locationController
                                              .profileShippingSelected) {
                                        showCustomSnackBar(
                                            'please_select_your_shipping_address'
                                                .tr);
                                      } else {
                                        CouponModel? _coupon;
                                        if (couponController.coupon != null) {
                                          _coupon = couponController.coupon;
                                          _coupon!.amount = couponController
                                              .discount
                                              .toString();
                                        }
                                        ShippingMethodModel? _shipping;
                                        if (orderController
                                            .shippingMethodList!.isNotEmpty) {
                                          _shipping = orderController
                                                  .shippingMethodList![
                                              orderController.shippingIndex!];
                                          _shipping.methodDescription =
                                              _shippingFee.toString();

                                          print(
                                              'ShippingFee-->${_shippingFee.toString()}');
                                          //_shipping.title = _total.toString();
                                        }
                                        Get.to(() => CheckoutScreen(
                                            cartList:
                                                fromOrder ? _cartList : null,
                                            coupon: _coupon,
                                            shippingMethod: _shipping,
                                            orderAmount: _total,
                                            shippingIndex: Get.find<
                                                    LocationController>()
                                                .selectedShippingAddressIndex,
                                            orderNow: fromOrder));
                                        // Get.toNamed(RouteHelper.getCheckoutRoute('cart', _coupon, _shipping));
                                        // Get.find<CouponController>().removeCouponData(false);
                                      }
                                    },
                                    btnText: 'Check Out',
                                    loading: false,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : NoDataScreen(
                        type: NoDataType.CART, text: 'cart_is_empty'.tr);
              });
            });
          });
        });
      }),
    );
  }
}
