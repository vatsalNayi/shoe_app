import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/module/cart/cart_page.dart';
import 'package:shoes_app/module/home/home_page.dart';
import 'package:shoes_app/module/more/more_page.dart';

class DashboardController extends GetxController {
  RxInt selectedIndex = 0.obs;

  onItemTapped(int index) {
    selectedIndex.value = index;
  }

  RxList<Widget> pages = [
    const HomePage(),
    const CartPage(),
    // const CartPage(
    //   fromNav: true,
    // ),
    // const LikePage(),
    // const CategoriesPage(),
    Container(),
    Container(),
    const MorePage(),
  ].obs;
}
