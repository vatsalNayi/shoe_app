import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoes_app/core/utils/textfield_validations.dart';
import 'package:shoes_app/core/values/colors.dart';
import 'package:shoes_app/core/values/strings.dart';
import 'package:shoes_app/global_widgets/custom_button.dart';
import 'package:shoes_app/global_widgets/custom_textfield.dart';
import 'package:shoes_app/global_widgets/svg_icon.dart';
import 'package:shoes_app/global_widgets/textfield_decoration.dart';
import 'package:shoes_app/module/auth/controller/auth_controller.dart';
import 'package:shoes_app/module/auth/signup/sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final apiService = ApiService(dio);
  // final ApiService apiService = ApiService(dio);

  @override
  Widget build(BuildContext context) {
    SignupController controller = Get.put(SignupController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              top: 24.h,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome you’ve been missed!',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkGray,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'We need to verify you. We will send you a one time verification code.',
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      color: AppColors.darkGray,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  customDecorationForTextfield(
                    borderRadius: 5.r,
                    child: CustomTextfield(
                      controller: controller.firstNameController,
                      hintText: 'First Name',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16.sp,
                      ),
                      textStyle: GoogleFonts.poppins(
                        fontSize: 16.sp,
                      ),
                      validator: Validations.validateName,
                      border: InputBorder.none,
                      prefixIcon: SvgIcon(
                        imagePath: ImagePath.personSvg,
                        width: 17.w,
                        height: 17.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  customDecorationForTextfield(
                    borderRadius: 5.r,
                    child: CustomTextfield(
                      hintText: 'Last Name',
                      controller: controller.lastNameController,
                      border: InputBorder.none,
                      validator: Validations.validateName,
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16.sp,
                      ),
                      textStyle: GoogleFonts.poppins(
                        fontSize: 16.sp,
                      ),
                      prefixIcon: SvgIcon(
                        imagePath: ImagePath.personSvg,
                        width: 17.w,
                        height: 17.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  customDecorationForTextfield(
                    borderRadius: 5.r,
                    child: CustomTextfield(
                      hintText: 'Username',
                      controller: controller.usernameController,
                      border: InputBorder.none,
                      validator: Validations.validateName,
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16.sp,
                      ),
                      textStyle: GoogleFonts.poppins(
                        fontSize: 16.sp,
                      ),
                      prefixIcon: SvgIcon(
                        imagePath: ImagePath.personSvg,
                        width: 17.w,
                        height: 17.h,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  customDecorationForTextfield(
                    borderRadius: 5.r,
                    child: CustomTextfield(
                      hintText: 'Email',
                      controller: controller.emailController,
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16.sp,
                      ),
                      textStyle: GoogleFonts.poppins(
                        fontSize: 16.sp,
                      ),
                      validator: Validations.validateEmail,
                      prefixIcon: const SvgIcon(
                        imagePath: ImagePath.emailSvg,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // CustomDecorationForTextfield(
                  //   borderRadius: Dimens.pixel_5,
                  //   child: CustomTextfield(
                  //     controller: controller.phoneController,
                  //     hintText: Strings.hint_phone_number,
                  //     hintStyle: textstyle16.copyWith(
                  //       color: AppColors.brightGrey,
                  //     ),
                  //     textStyle: textstyle16.copyWith(
                  //       color: AppColors.brightGrey,
                  //     ),
                  //     validator: Validations.validatePhoneNumber,
                  //     border: InputBorder.none,
                  //     prefixIcon: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         SizedBox(
                  //           width: Dimens.pixel_15,
                  //         ),
                  //         LoadSvg(
                  //           imagePath: ImagePath.callSvg,
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.symmetric(
                  //             horizontal: Dimens.pixel_15,
                  //           ),
                  //           child: LoadSvg(
                  //             imagePath: ImagePath.indiaFlagSvg,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: Dimens.pixel_20,
                  // ),
                  // GestureDetector(
                  //   onTap: () async {
                  //     debugPrint('pressed');
                  //     // TODO: open calander for select date
                  //     // date picker
                  //     final DateTime? pickedDate = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now(),
                  //       firstDate: DateTime(1900),
                  //       lastDate: DateTime.now(),
                  //     );
                  //     if (pickedDate != null &&
                  //         pickedDate != controller.selectedDate!.value) {
                  //       String formatedDate =
                  //           DateFormat('yyyy-MM-dd').format(pickedDate);
                  //       controller.selectedDate?.value = formatedDate;
                  //     }
                  //   },
                  //   child: CustomDecorationForTextfield(
                  //     borderRadius: Dimens.pixel_5,
                  //     child: IgnorePointer(
                  //       child: Obx(
                  //         () => CustomTextfield(
                  //           readOnly: true,
                  //           hintText: controller.selectedDate?.value != '' &&
                  //                   controller.selectedDate?.value != null
                  //               ? controller.selectedDate!.value
                  //               : Strings.hint_birthdate,
                  //           border: InputBorder.none,
                  //           hintStyle: textstyle16.copyWith(
                  //             color: AppColors.brightGrey,
                  //           ),
                  //           textStyle: textstyle16.copyWith(
                  //             color: AppColors.brightGrey,
                  //           ),
                  //           errorText: controller.isVisibleDateError.value
                  //               ? 'Please select birth date'
                  //               : null,
                  //           prefixIcon: LoadSvg(
                  //             imagePath: ImagePath.dateSvg,
                  //           ),
                  //           suffixIcon: LoadSvg(
                  //             imagePath: ImagePath.dropdownSvg,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: Dimens.pixel_20,
                  // ),
                  customDecorationForTextfield(
                    borderRadius: 5.r,
                    child: Obx(
                      () => CustomTextfield(
                        obscureText: controller.isShowPassword.value,
                        controller: controller.passwordController,
                        hintText: 'Password',
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 16.sp,
                        ),
                        textStyle: GoogleFonts.poppins(
                          fontSize: 16.sp,
                        ),
                        validator: Validations.validatePassword,
                        prefixIcon: const SvgIcon(
                          imagePath: ImagePath.passwordSvg,
                        ),
                        onTapSuffix: controller.togglePasswordVisibility,
                        suffixIcon: SvgIcon(
                          imagePath: controller.isShowPassword.value
                              ? ImagePath.showPasswordSvg
                              : ImagePath.hidePasswordSvg,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  customDecorationForTextfield(
                    borderRadius: 5.r,
                    child: Obx(
                      () => CustomTextfield(
                        obscureText: controller.isShowConfirmPassword.value,
                        controller: controller.confirmPasswordController,
                        hintText: 'Confirm Password',
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 16.sp,
                        ),
                        textStyle: GoogleFonts.poppins(
                          fontSize: 16.sp,
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please enter your confirm password';
                          } else if (val !=
                              controller.passwordController.text) {
                            return 'Passwords does not match';
                          } else {
                            return null;
                          }
                        },
                        prefixIcon: const SvgIcon(
                          imagePath: ImagePath.passwordSvg,
                        ),
                        onTapSuffix: controller.toggleConfirmPasswordVisibility,
                        suffixIcon: SvgIcon(
                          imagePath: controller.isShowConfirmPassword.value
                              ? ImagePath.showPasswordSvg
                              : ImagePath.hidePasswordSvg,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  GetBuilder<AuthController>(builder: (authController) {
                    return CustomButton(
                      loading: false,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          // Register woo api call
                          controller.registerWoo(authController);
                        }
                      },
                      btnText: 'Next',
                    );
                  }),

                  SizedBox(
                    height: 30.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: GoogleFonts.poppins(
                                color: AppColors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.15,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign In Now',
                              style: GoogleFonts.poppins(
                                color: AppColors.lightGreen,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
