import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/module/splash/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Center(
        child: Text(
          'Splash screen',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            // height: 0.03,
          ),
        ),
      ),
    );
  }
}
