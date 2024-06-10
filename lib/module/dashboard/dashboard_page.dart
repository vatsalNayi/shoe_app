import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/core/values/colors.dart';
import 'package:shoes_app/core/values/strings.dart';
import 'package:shoes_app/global_widgets/svg_icon.dart';
import 'package:shoes_app/module/cart/cart_controller.dart';
import 'package:shoes_app/module/dashboard/dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.put(DashboardController());
    return Scaffold(
      body: Obx(
        () => dashboardController.pages
            .elementAt(dashboardController.selectedIndex.value),
      ),
      // extendBody: true, // Extend the body to avoid bottom insets

      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          bottom: 24.w,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.r),
          child: BottomNavigationBar(
            backgroundColor: AppColors.lightGreen,
            currentIndex: dashboardController.selectedIndex.value,
            onTap: dashboardController.onItemTapped,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            useLegacyColorScheme: true,
            items: [
              BottomNavigationBarItem(
                icon: Obx(
                  () => Container(
                    height: 63.h,
                    width: 63.w,
                    decoration: BoxDecoration(
                      color: dashboardController.selectedIndex.value == 0
                          ? AppColors.white
                          : AppColors.lightGreen,
                      shape: BoxShape.circle,
                    ),
                    child: SvgIcon(
                      imagePath: ImagePath.homeSvg,
                      fit: BoxFit.scaleDown,
                      color: dashboardController.selectedIndex.value == 0
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Obx(() => Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Badge(
                        alignment: Alignment.topRight,
                        smallSize: 10,
                        largeSize: 18,
                        isLabelVisible:
                            Get.find<CartController>().cartList != null &&
                                Get.find<CartController>().cartList!.isNotEmpty,
                        label: GetBuilder<CartController>(
                            builder: (cartController) {
                          return Center(
                            child: Text(
                              cartController.cartList!.length.toString(),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                              ).copyWith(color: Colors.white, fontSize: 14),
                            ),
                          );
                        }),
                        child: Container(
                          height: 63.h,
                          width: 63.w,
                          decoration: BoxDecoration(
                            color: dashboardController.selectedIndex.value == 1
                                ? AppColors.white
                                : AppColors.lightGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgIcon(
                              imagePath: ImagePath.cartSvg,
                              fit: BoxFit.scaleDown,
                              color:
                                  dashboardController.selectedIndex.value == 1
                                      ? AppColors.black
                                      : AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    )),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Obx(
                  () => Container(
                    height: 63.h,
                    width: 63.w,
                    decoration: BoxDecoration(
                      color: dashboardController.selectedIndex.value == 2
                          ? AppColors.white
                          : AppColors.lightGreen,
                      shape: BoxShape.circle,
                    ),
                    child: SvgIcon(
                      imagePath: ImagePath.likeSvg,
                      fit: BoxFit.scaleDown,
                      color: dashboardController.selectedIndex.value == 2
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Obx(
                  () => Container(
                    height: 63.h,
                    width: 63.w,
                    decoration: BoxDecoration(
                      color: dashboardController.selectedIndex.value == 3
                          ? AppColors.white
                          : AppColors.lightGreen,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.category_outlined,
                      color: dashboardController.selectedIndex.value == 3
                          ? AppColors.black
                          : AppColors.white,
                      size: 30,
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Obx(
                  () => Container(
                    height: 63.h,
                    width: 63.w,
                    decoration: BoxDecoration(
                      color: dashboardController.selectedIndex.value == 4
                          ? AppColors.white
                          : AppColors.lightGreen,
                      shape: BoxShape.circle,
                    ),
                    child: SvgIcon(
                      imagePath: ImagePath.profileSvg,
                      fit: BoxFit.scaleDown,
                      color: dashboardController.selectedIndex.value == 4
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
