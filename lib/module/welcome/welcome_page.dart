import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/core/values/colors.dart';
import 'package:shoes_app/core/values/strings.dart';
import 'package:shoes_app/global_widgets/custom_button_with_icon.dart';
import 'package:shoes_app/module/auth/controller/auth_controller.dart';
import 'package:shoes_app/routes/pages.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      body: Stack(
        children: [
          Positioned.fill(
            top: 120.h,
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    ImagePath.triangleLeft,
                    height: 325.h,
                    // width: 385.w,
                  ),
                  Image.asset(
                    ImagePath.triangleRight,
                    height: 325.h,
                    // width: 385.w,
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Positioned.fill(
                top: -300,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImagePath.welcomePng,
                  ),
                ),
              ),
              Positioned.fill(
                bottom: -180,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 80.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(180),
                        topRight: Radius.circular(180),
                      ),
                      // shape: BoxShape.circle,
                      // borderRadius: BorderRadius.vertical(
                      //   bottom: Radius.circular(30),
                      // ),
                    ),
                    width: 1.sw,
                    height: 1.sh / 1.5,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 149.w,
                          child: Text(
                            'YOUR STYLE WILL TELL ABOUT YOU',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        CustomButtonWithIcon(
                          onTap: () {
                            // Get.toNamed(Routes.loginPage);
                            Get.find<AuthController>().setIsWelcomed(true);
                            Get.offAllNamed(Routes.dashboardPage);
                          },
                          title: 'Get Started',
                          icon: ImagePath.arrowNext,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
