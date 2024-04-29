import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // LoginRepository loginRepository = LoginRepository();
  TextEditingController usernameEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isShowPassword = true.obs;

  togglePasswordVisibility() {
    isShowPassword.value = !isShowPassword.value;
  }

  var loader = false.obs;
  bool get getLoader => loader.value;
  set setLoader(bool val) => loader.value = val;

  RxBool isLoadingPhoneVerify = false.obs;
  int? _resendToken;

  // login({required Map<String, dynamic> body}) async {
  //   try {
  //     setLoader = true;
  //     LoginResponse loginResponse = await loginRepository.login(body: body);
  //     debugPrint('Response message: ${loginResponse.message}');
  //     debugPrint('Response status: ${loginResponse.status}');
  //     if (loginResponse.status == 200) {
  //       setLoader = false;
  //       debugPrint('login success');
  //       Get.offAllNamed(Routes.welcomePage);
  //       Get.snackbar('Message', '${loginResponse.message}');
  //     } else {
  //       setLoader = false;
  //       // Get.snackbar('Message', '${loginResponse.message}');
  //     }
  //   } catch (e) {
  //     setLoader = false;
  //     debugPrint(e.toString());
  //   }
  // }

  // verify phone number for firebase auth (login)
  // verifyPhoneNumber({required String phoneNumber}) async {
  //   isLoadingPhoneVerify.value = true;
  //   return await FirebaseService.auth.verifyPhoneNumber(
  //     forceResendingToken: _resendToken,
  //     verificationCompleted: (PhoneAuthCredential credential) {
  //       // auto retrival (signin on success)
  //       // API call of login
  //       // Map<String, dynamic> userLoginData = {
  //       //   'mobile': phoneController.text.trim(),
  //       //   'password': passwordController.text.trim(),
  //       // };
  //       // login(body: userLoginData);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       isLoadingPhoneVerify.value = false;
  //       log('FirebaseAuthException',
  //           stackTrace: e.stackTrace, error: e, name: 'Exception');
  //       showSnackbar(title: 'Message', message: e.toString());
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       _resendToken = resendToken;
  //       isLoadingPhoneVerify.value = false;
  //       debugPrint('otp sent to your  phone number');
  //       // Navigate to otp screen
  //       showSnackbar(
  //           title: 'Message', message: 'OTP sent to your  phone number');
  //       Get.toNamed(
  //         Routes.otpVerifyPage,
  //         arguments: {
  //           'verificationId': verificationId,
  //           'navigateFrom': 'login',
  //         },
  //       );
  //     },
  //     codeAutoRetrievalTimeout: (String timeout) {},
  //     phoneNumber: phoneNumber,
  //   );
  // }

  /// Login woo
  // void loginWoo(AuthController authController) async {
  //   String _email = usernameEmailController.text.trim();
  //   String _password = passwordController.text.trim();
  //   if (_email.isEmpty) {
  //     showCustomSnackBar('enter_username_or_email'.tr);
  //   }
  //   // else if (_email.contains('@') && !GetUtils.isEmail(_email)) {
  //   //   showCustomSnackBar('invalid_email_address'.tr);
  //   // }
  //   else if (_password.isEmpty) {
  //     showCustomSnackBar('enter_password'.tr);
  //   } else if (_password.length < 6) {
  //     showCustomSnackBar('password_should_be'.tr);
  //   } else {
  //     authController.login(_email, _password, fromLogin: true);
  //   }
  // }
}
