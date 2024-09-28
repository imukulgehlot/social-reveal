import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';
import 'package:rstsocial/core/widgets/text_field/text_field/my_text_field.dart';
import 'package:rstsocial/features/authentication/otp_screen.dart';

import 'controllers/cognito_sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController signUpController =
      Get.put(SignUpController(), tag: "signUpController");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.h10,
                    ),

                    // Top Logo
                    CustomSvgAssetImage(
                      image: ImageAsset.icAppIconWithTagline,
                      color: ColorConst.primaryColor,
                      height: Dimensions.h70,
                    ),

                    SizedBox(
                      height: Dimensions.h13,
                    ),

                    // Sign In Text
                    Text(
                      AppString.signUp,
                      style: fontStyleBold32.copyWith(
                          color: Theme.of(context).colorScheme.taglineText),
                    ),

                    // Sign In Tagline
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
                      child: Text(
                        AppString.experienceTheFuture,
                        textAlign: TextAlign.center,
                        style: fontStyleMedium15.copyWith(
                            color: Theme.of(context).colorScheme.taglineText),
                      ),
                    ),

                    SizedBox(
                      height: Dimensions.h13,
                    ),

                    // Sign In Modes
                    Row(
                      children: [
                        SignInModeButton(
                            onPressed: () {}, svgIcon: ImageAsset.icGoogle),
                        SizedBox(
                          width: Dimensions.w7,
                        ),
                        SignInModeButton(
                            onPressed: () {}, svgIcon: ImageAsset.icFacebook),
                        SizedBox(
                          width: Dimensions.w7,
                        ),
                        SignInModeButton(
                            onPressed: () {}, svgIcon: ImageAsset.icApple),
                      ],
                    ),

                    SizedBox(
                      height: Dimensions.h13,
                    ),

                    // OR
                    Text(
                      AppString.or,
                      textAlign: TextAlign.center,
                      style: fontStyleMedium15.copyWith(
                          color: Theme.of(context).colorScheme.taglineText),
                    ),

                    SizedBox(
                      height: Dimensions.h13,
                    ),

                    // User Name Text
                    Container(
                      padding: EdgeInsets.only(left: Dimensions.h10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppString.fullName,
                        textAlign: TextAlign.center,
                        style: fontStyleSemiBold15.apply(
                            color: Theme.of(context).colorScheme.textColor),
                      ),
                    ),

                    SizedBox(
                      height: Dimensions.h3,
                    ),

                    // Full Name Text field
                    MyTextField(
                        borderRadius: Dimensions.r10,
                        prefixIcon: CustomSvgAssetImage(
                            image: ImageAsset.icUser,
                            width: Dimensions.w25,
                            color: Theme.of(context).colorScheme.textColor),
                        textStyle: fontStyleRegular14.apply(
                            color: Theme.of(context).colorScheme.textColor),
                        height: Dimensions.h40,
                        textInputType: TextInputType.emailAddress,
                        hintTextColor: ColorConst.hintColor,
                        textController: signUpController.fullNameController,
                        textFieldBorderColor: Colors.transparent,
                        hintText: AppString.enterYourFullNameHere),

                    SizedBox(
                      height: Dimensions.h13,
                    ),

                    // User Name Text field
                    Container(
                      padding: EdgeInsets.only(left: Dimensions.h10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppString.username,
                        textAlign: TextAlign.center,
                        style: fontStyleSemiBold15.apply(
                            color: Theme.of(context).colorScheme.textColor),
                      ),
                    ),

                    SizedBox(
                      height: Dimensions.h3,
                    ),

                    MyTextField(
                        borderRadius: Dimensions.r10,
                        prefixIcon: CustomSvgAssetImage(
                            image: ImageAsset.icUser,
                            width: Dimensions.w25,
                            color: Theme.of(context).colorScheme.textColor),
                        textStyle: fontStyleRegular14.apply(
                            color: Theme.of(context).colorScheme.textColor),
                        height: Dimensions.h40,
                        textInputType: TextInputType.emailAddress,
                        hintTextColor: ColorConst.hintColor,
                        textController: signUpController.userNameController,
                        textFieldBorderColor: Colors.transparent,
                        hintText: AppString.enterYourUserNameHere),

                    SizedBox(
                      height: Dimensions.h13,
                    ),

                    // Email Text
                    Container(
                      padding: EdgeInsets.only(left: Dimensions.h10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppString.email,
                        textAlign: TextAlign.center,
                        style: fontStyleSemiBold15.apply(
                            color: Theme.of(context).colorScheme.textColor),
                      ),
                    ),

                    SizedBox(
                      height: Dimensions.h3,
                    ),

                    // Email Text field
                    MyTextField(
                        borderRadius: Dimensions.r10,
                        prefixIcon: CustomSvgAssetImage(
                            image: ImageAsset.icEmail,
                            width: Dimensions.w25,
                            color: Theme.of(context).colorScheme.textColor),
                        textStyle: fontStyleRegular14.apply(
                            color: Theme.of(context).colorScheme.textColor),
                        height: Dimensions.h40,
                        textInputType: TextInputType.emailAddress,
                        hintTextColor: ColorConst.hintColor,
                        textController: signUpController.emailController,
                        textFieldBorderColor: Colors.transparent,
                        hintText: AppString.enterYourEmailHere),

                    SizedBox(
                      height: Dimensions.h13,
                    ),

                    // Password Text
                    Container(
                      padding: EdgeInsets.only(left: Dimensions.h10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppString.password,
                        textAlign: TextAlign.center,
                        style: fontStyleSemiBold15.apply(
                            color: Theme.of(context).colorScheme.textColor),
                      ),
                    ),

                    SizedBox(
                      height: Dimensions.h3,
                    ),

                    // Password Text Field
                    Obx(
                      () => MyTextField(
                          borderRadius: Dimensions.r10,
                          prefixIcon: CustomSvgAssetImage(
                              image: ImageAsset.icPassword,
                              width: Dimensions.w25,
                              color: Theme.of(context).colorScheme.textColor),
                          suffixIcon: CustomSvgAssetImage(
                            height: Dimensions.h23,
                            color: Theme.of(context).colorScheme.textColor,
                            onTap: () {
                              signUpController.isPasswordVisible.value =
                                  !signUpController.isPasswordVisible.value;
                            },
                            image: signUpController.isPasswordVisible.value
                                ? ImageAsset.icHidePassword
                                : ImageAsset.icViewPassword,
                          ),
                          textStyle: fontStyleRegular14.apply(
                              color: Theme.of(context).colorScheme.textColor),
                          height: Dimensions.h40,
                          obscureText: signUpController.isPasswordVisible.value,
                          hintTextColor: ColorConst.hintColor,
                          textController: signUpController.passwordController,
                          textInputAction: TextInputAction.done,
                          textFieldBorderColor: Colors.transparent,
                          hintText: AppString.enterYourNewPasswordHere),
                    ),

                    SizedBox(
                      height: Dimensions.h10,
                    ),

                    // Terms and conditions message
                    Text.rich(TextSpan(
                        text: 'By clicking sign up you accept the ',
                        style: fontStyleMedium12.apply(
                            color: Theme.of(context).colorScheme.textColor),
                        children: <InlineSpan>[
                          TextSpan(
                              text: 'Terms and Conditions ',
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              style: fontStyleBold12.apply(
                                  color: ColorConst.primaryColor)),
                          const TextSpan(
                            text: 'and ',
                          ),
                          TextSpan(
                              text: 'Privacy Policy ',
                              recognizer: TapGestureRecognizer()..onTap = () {},
                              style: fontStyleBold12.apply(
                                  color: ColorConst.primaryColor)),
                          const TextSpan(
                            text: 'Just Social.',
                          ),
                        ])),

                    SizedBox(
                      height: Dimensions.h20,
                    ),

                    // Sign Up Button
                    MyButton(
                      title: AppString.signUp,
                      onPressed: () => Get.to(() =>
                          const OTPScreen()), /*signUpController.checkValidation*/
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: Dimensions.h20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.alreadyHaveAnAccount,
                      style: fontStyleSemiBold13.apply(
                          color: Theme.of(context).colorScheme.textColor),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(Dimensions.r5),
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        AppString.signIn,
                        style: fontStyleSemiBold13.apply(
                            color: Theme.of(context).colorScheme.taglineText),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
