import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/dimensions.dart';
import '../core/utils/styles.dart';
import '../core/values/colors.dart';
import '../core/values/strings.dart';
import '../routes/pages.dart';
import 'custom_button.dart';

class NotLoggedInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            ImagePath.guest,
            width: MediaQuery.of(context).size.height * 0.25,
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            'sorry'.tr,
            style: poppinsBold.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.023,
                color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            'you_are_not_logged_in'.tr,
            style: poppinsRegular.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.0175,
                color: Theme.of(context).disabledColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          SizedBox(
            width: 200,
            child: CustomButton(
                loading: false,
                bgColor: AppColors.oysterPink,
                btnText: 'login_to_continue'.tr,
                // height: 40,
                onPress: () {
                  Get.toNamed(
                    Routes.getSignInRoute(),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
