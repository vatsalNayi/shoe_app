import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/core/utils/dimensions.dart';
import 'package:shoes_app/core/values/colors.dart';
import 'package:shoes_app/global_widgets/custom_appbar.dart';
import 'package:shoes_app/global_widgets/custom_button.dart';
import 'package:shoes_app/global_widgets/custom_textfield.dart';
import 'package:shoes_app/global_widgets/show_snackbar.dart';
import 'package:shoes_app/module/auth/controller/auth_controller.dart';
import 'package:shoes_app/routes/pages.dart';

class NewPassPage extends StatefulWidget {
  final String? resetToken;
  final String? number;
  final bool fromPasswordChange;
  NewPassPage(
      {required this.resetToken,
      required this.number,
      required this.fromPasswordChange});

  @override
  State<NewPassPage> createState() => _NewPassPageState();
}

class _NewPassPageState extends State<NewPassPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'reset_password'.tr),
      body: SafeArea(
          child: Center(
              child: Scrollbar(
                  child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: context.width > 700 ? 700 : context.width,
          padding: context.width > 700
              ? const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
              : null,
          margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          decoration: context.width > 700
              ? BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[Get.isDarkMode ? 700 : 300]!,
                        blurRadius: 5,
                        spreadRadius: 1)
                  ],
                )
              : null,
          child: Column(children: [
            Text('enter_new_password'.tr,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center),
            const SizedBox(height: 50),
            Container(
              child: Column(children: [
                CustomTextfield(
                  hintText: 'new_password'.tr,
                  controller: _newPasswordController,
                  // focusNode: _newPasswordFocus,
                  // nextFocus: _confirmPasswordFocus,
                  inputType: TextInputType.visiblePassword,
                  // prefixIcon: Images.lock,
                  // isPassword: true,
                ),
                const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                CustomTextfield(
                  hintText: 'confirm_password'.tr,
                  controller: _confirmPasswordController,
                  // focusNode: _confirmPasswordFocus,
                  // inputAction: TextInputAction.done,
                  inputType: TextInputType.visiblePassword,
                  // prefixIcon: Images.lock,
                  // isPassword: true,
                ),
              ]),
            ),
            const SizedBox(height: 30),
            GetBuilder<AuthController>(builder: (authBuilder) {
              return
                  // (!authBuilder.isLoading) ?
                  CustomButton(
                loading: authBuilder.isLoading,
                bgColor: AppColors.lightGreen,
                btnText: 'done'.tr,
                // radius: Dimensions.RADIUS_EXTRA_LARGE,
                onPress: () => _resetPassword(widget.number, widget.resetToken,
                    _newPasswordController.text),
              );
              // : const Center(child: CircularProgressIndicator());
            }),
          ]),
        ),
      )))),
    );
  }

  void _resetPassword(String? email, String? otp, String password) async {
    String _password = _newPasswordController.text.trim();
    String _confirmPassword = _confirmPasswordController.text.trim();
    if (_password.isEmpty) {
      showCustomSnackBar('enter_password'.tr);
    } else if (_password.length < 4) {
      showCustomSnackBar('password_should_be'.tr);
    } else if (_password != _confirmPassword) {
      showCustomSnackBar('confirm_password_does_not_matched'.tr);
    } else {
      Response response =
          await Get.find<AuthController>().resetPassword(otp, email, password);
      if (response.body['status'] == '200') {
        Get.offAllNamed(Routes.getSignInRoute(from: Routes.resetPassword));
      } else {
        showCustomSnackBar(response.body['status']);
      }
    }
  }
}
