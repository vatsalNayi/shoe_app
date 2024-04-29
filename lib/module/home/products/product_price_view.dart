import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/styles.dart';
import '../../../core/values/colors.dart';
import '../../../helper/price_converter.dart';
import '../../../models/product_model.dart';
import 'controller/product_controller.dart';

class ProductTitleView extends StatelessWidget {
  final ProductModel? product;
  const ProductTitleView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double? _startingPrice;
    double? _startingDiscountedPrice;
    double? _endingPrice;
    double? _endingDiscountedPrice;
    bool _hasDiscount = false;
    int? _discountInPercentage;
    if (product!.variation!.isNotEmpty) {
      List<double> _priceList = [];
      List<double> _discountedPriceList = [];

      for (var variation in product!.variation!) {
        if (variation.regularPrice != null &&
            variation.regularPrice.toString().trim().isNotEmpty) {
          //if(variation.salePrice != null && variation.salePrice.toString().trim().isNotEmpty) {
          _priceList.add(double.parse(variation.regularPrice.toString()));
          //}
        } else {
          _priceList.add(0);
        }
      }

      for (var variation in product!.variation!) {
        if (variation.salePrice.toString() != 'null') {
          _hasDiscount = true;
          _discountedPriceList
              .add(double.parse(variation.salePrice.toString()));
        } else if (variation.regularPrice != null) {
          _discountedPriceList
              .add(double.parse(variation.regularPrice.toString()));
        }
      }

      // Get.find<ProductController>().variations.forEach((variation) {
      //   print('========${variation.toJson()}');
      //   if(variation.regularPrice != null && variation.regularPrice.trim().isNotEmpty) {
      //     _priceList.add(double.parse(variation.regularPrice));
      //   }else {
      //     _priceList.add(0);
      //   }
      // });
      // Get.find<ProductController>().variations.forEach((variation) {
      //   if(variation.salePrice.isNotEmpty) {
      //     _hasDiscount = true;
      //     _discountedPriceList.add(double.parse(variation.salePrice));
      //   }
      // });

      _priceList.sort((a, b) => a.compareTo(b));
      _discountedPriceList.sort((a, b) => a.compareTo(b));
      if (_priceList.isNotEmpty) {
        _startingPrice = _priceList[0];
        // log('Starting Price: $_startingPrice');
      }

      if (_discountedPriceList.isNotEmpty) {
        _startingDiscountedPrice = _discountedPriceList[0];
      }
      if (_priceList.isNotEmpty) {
        if (_priceList[0] < _priceList[_priceList.length - 1]) {
          _endingPrice = _priceList[_priceList.length - 1];
        }
      }
      if (_discountedPriceList.isNotEmpty &&
          _discountedPriceList[0] <
              _discountedPriceList[_discountedPriceList.length - 1]) {
        _endingDiscountedPrice =
            _discountedPriceList[_discountedPriceList.length - 1];
      }
    } else {
      _hasDiscount = product!.salePrice!.isNotEmpty;
      _startingPrice = product!.regularPrice != ''
          ? double.parse(product!.regularPrice.toString())
          : 0;
      _startingDiscountedPrice =
          product!.price != '' ? double.parse(product!.price!) : 0;
      _discountInPercentage =
          (100 - (_startingDiscountedPrice / _startingPrice) * 100).round();
      // log('Had Discount: $_hasDiscount');
      // log('Starting Price: $_startingPrice');
      // log('Starting Discounted Price: $_startingDiscountedPrice');
      // log('Discount: $_discountInPercentage');
      // (100 - (_salePrice / _regularPrice) * 100)
    }

    return GetBuilder<ProductController>(
      builder: (productController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_SMALL),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    productController.variationRegPrice ==
                            productController.priceWithQuantity
                        ? const SizedBox()
                        : productController.variationRegPrice != null
                            ? Text(
                                PriceConverter.convertPrice(productController
                                    .variationRegPrice
                                    .toString()),
                                style: poppinsRegular.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontSize: Dimensions.fontSizeDefault,
                                    decoration: TextDecoration.lineThrough))
                            : const SizedBox(),
                    productController.variationRegPrice ==
                            productController.priceWithQuantity
                        ? const SizedBox()
                        : const SizedBox(
                            width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Text(
                        PriceConverter.convertPrice(
                            productController.priceWithQuantity.toString()),
                        style: poppinsBold.copyWith(
                          color: const Color.fromARGB(255, 255, 154, 195),
                          fontSize: Dimensions.fontSizeLarge,
                        )),
                  ]),
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: [
                  //     _startingDiscountedPrice != null
                  //         ? Text(
                  //             '${PriceConverter.convertPrice(
                  //               _hasDiscount
                  //                   ? _startingDiscountedPrice.toString()
                  //                   : _startingPrice.toString(),
                  //               taxStatus: product!.taxStatus,
                  //               taxClass: product!.taxClass,
                  //             )}'
                  //             '${_endingPrice != null ? ' - ${PriceConverter.convertPrice(
                  //                 _endingDiscountedPrice != null
                  //                     ? _endingDiscountedPrice.toString()
                  //                     : _endingPrice.toString(),
                  //                 taxStatus: product!.taxStatus,
                  //                 taxClass: product!.taxClass,
                  //               )}' : ''}',
                  //             style: robotoBold.copyWith(
                  //                 color: Colors.black,
                  //                 fontSize: Dimensions.fontSizeLarge),
                  //           )
                  //         : const SizedBox(),
                  //     const SizedBox(width: 5),
                  //     _hasDiscount
                  //         ? Text(
                  //             '${PriceConverter.convertPrice(_startingPrice.toString(), taxStatus: product!.taxStatus, taxClass: product!.taxClass)}'
                  //             '${_endingPrice != null ? ' - ${PriceConverter.convertPrice(_endingPrice.toString(), taxStatus: product!.taxStatus, taxClass: product!.taxClass)}' : ''}',
                  //             style: robotoRegular.copyWith(
                  //                 color: Theme.of(context).hintColor,
                  //                 decoration: TextDecoration.lineThrough),
                  //           )
                  //         : const SizedBox(),
                  //     const SizedBox(
                  //       width: 5,
                  //     ),
                  //     _hasDiscount &&
                  //             (_discountInPercentage != null &&
                  //                 _discountInPercentage > 0)
                  //         ? Text(
                  //             '$_discountInPercentage% OFF',
                  //             style: robotoRegular.copyWith(
                  //               color: const Color.fromARGB(255, 255, 154, 195),
                  //             ),
                  //           )
                  //         : const SizedBox(),
                  //   ],
                  // ),
                ],
              ),
            ),
            (product!.manageStock! &&
                    (product!.stockQuantity != null &&
                        product!.stockQuantity! > 0))
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.lightRose,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                        '${'in_stock'.tr} : ${product!.stockQuantity ?? 0}',
                        style: poppinsRegular))
                : const SizedBox(),
            const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          ],
        );
      },
    );
  }
}
