import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_app/global_widgets/show_snackbar.dart';
import 'package:shoes_app/models/signup_body.dart';
import 'package:shoes_app/module/auth/controller/auth_controller.dart';

class SignupController extends GetxController {
  // SignupRepository signupRepository = SignupRepository();
  RxBool isShowPassword = true.obs;
  RxBool isShowConfirmPassword = true.obs;
  RxBool isLoadingPhoneVerify = false.obs;

  togglePasswordVisibility() {
    isShowPassword.value = !isShowPassword.value;
  }

  toggleConfirmPasswordVisibility() {
    isShowConfirmPassword.value = !isShowConfirmPassword.value;
    debugPrint('toggle pass value: ${isShowConfirmPassword.value.toString()}');
  }

  var loader = false.obs;
  bool get getLoader => loader.value;
  set setLoader(bool val) => loader.value = val;
  RxString? selectedDate = ''.obs;

  RxBool isVisibleDateError = false.obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // register({
  //   required String apiSegment,
  //   required String apiVersion,
  //   required Map<String, dynamic> body,
  // }) async {
  //   try {
  //     setLoader = true;
  //     RegisterResponse registerResponse = await signupRepository.getRegister(
  //       apiSegment: apiSegment,
  //       apiVersion: apiVersion,
  //       body: body,
  //     );
  //     debugPrint('this: ${registerResponse.message}');
  //     if (registerResponse.code == '200' || registerResponse.code == '201') {
  //       setLoader = false;
  //       debugPrint('Register success');

  //       /// send otp (otp functionality removed because flow of woomond app)
  //       // verifyPhoneNumber(phoneNumber: '+91${phoneController.text.toString()}');

  //       // Navigate to home after registration
  //       Get.toNamed(Routes.bottomBarPage);
  //     } else if (registerResponse.code == '422') {
  //       showSnackbar(title: 'Message', message: 'Invalid credentials');
  //     } else if (registerResponse.code == '400') {
  //       showSnackbar(title: 'Message', message: 'User does not exist');
  //     } else {
  //       setLoader = false;
  //       debugPrint(registerResponse.code.toString());
  //       Get.snackbar(
  //         'Message',
  //         registerResponse.message.toString(),
  //       );
  //     }
  //   } catch (e) {
  //     setLoader = false;
  //     debugPrint(e.toString());
  //   }
  // }

  // verify phone number forsignup
  // verifyPhoneNumber({required String phoneNumber}) async {
  //   isLoadingPhoneVerify.value = true;
  //   return await FirebaseService.auth.verifyPhoneNumber(
  //     verificationCompleted: (PhoneAuthCredential credential) {
  //       // auto retrival (signin on success)
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       isLoadingPhoneVerify.value = false;
  //       log('FirebaseAuthException',
  //           stackTrace: e.stackTrace, error: e, name: 'Exception');
  //       showSnackbar(title: 'Message', message: '${e.toString()}');
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       isLoadingPhoneVerify.value = false;
  //       debugPrint('otp sent to your  phone number');
  //       // Navigate to otp screen
  //       showSnackbar(
  //           title: 'Message', message: 'OTP sent to your  phone number');
  //       Get.toNamed(
  //         Routes.otpVerifyPage,
  //         arguments: {
  //           'verificationId': verificationId,
  //           'navigateFrom': 'register',
  //         },
  //       );
  //     },
  //     codeAutoRetrievalTimeout: (String timeout) {},
  //     phoneNumber: phoneNumber,
  //   );
  // }

  // Woo register
  void registerWoo(
    AuthController authController,
  ) async {
    String _firstName = firstNameController.text.trim();
    String _lastName = lastNameController.text.trim();
    String _username = usernameController.text.trim();
    String _email = emailController.text.trim();
    String _password = passwordController.text.trim();
    String _confirmPassword = confirmPasswordController.text.trim();

    // if (authController.acceptTerms == false) {
    //   showSnackbar(title: 'Message', message: 'please_agree_with'.tr);
    // } else
    if (_firstName.isEmpty) {
      // showCustomSnackBar('enter_your_first_name'.tr);
      showSnackbar(title: 'Message', message: 'enter_your_first_name'.tr);
    } else if (_lastName.isEmpty) {
      // showCustomSnackBar('enter_your_last_name'.tr);
      showSnackbar(title: 'Message', message: 'enter_your_last_name'.tr);
    } else if (_username.isEmpty) {
      // showCustomSnackBar('enter_your_username'.tr);
      showSnackbar(title: 'Message', message: 'enter_your_username'.tr);
    } else if (_email.isEmpty) {
      // showCustomSnackBar('enter_email_address'.tr);
      showSnackbar(title: 'Message', message: 'enter_email_address'.tr);
    } else if (!GetUtils.isEmail(_email)) {
      // showCustomSnackBar('enter_a_valid_email_address'.tr);
      showSnackbar(title: 'Message', message: 'enter_a_valid_email_address'.tr);
    } else if (_password.isEmpty) {
      // showCustomSnackBar('enter_password'.tr);
      showSnackbar(title: 'Message', message: 'enter_password'.tr);
    } else if (_password.length < 6) {
      // showCustomSnackBar('password_should_be'.tr);
      showSnackbar(title: 'Message', message: 'password_should_be'.tr);
    } else if (_password != _confirmPassword) {
      // showCustomSnackBar('confirm_password_does_not_matched'.tr);
      showSnackbar(
          title: 'Message', message: 'confirm_password_does_not_matched'.tr);
    } else {
      debugPrint('authController.registration called');
      authController.registration(SignUpBody(
        firstName: _firstName,
        lastName: _lastName,
        email: _email,
        password: _password,
        username: _username,
      ));
    }
  }
}
