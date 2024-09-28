import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';
import 'package:rstsocial/core/widgets/text_field/text_field/my_text_field.dart';
import 'package:rstsocial/features/authentication/controllers/cognito_sign_in_controller.dart';
import 'package:rstsocial/features/authentication/sign_up_screen.dart';

import '../home/home_screen.dart';
import '../onboarding/onboarding_screens.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final  SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        AppUtils.showExitPopScopePopup(context);
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: // Sign Up Route
              Padding(
            padding: EdgeInsets.only(bottom: Dimensions.h30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppString.doNotHaveAnAccount,
                  style: fontStyleSemiBold13.apply(
                      color: Theme.of(context).colorScheme.textColor),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(Dimensions.r5),
                  onTap: () {
                    Get.to(() => SignUpScreen(),
                        transition: Transition.cupertino);
                  },
                  child: Text(
                    AppString.signUp,
                    style: fontStyleSemiBold13.apply(
                        color: Theme.of(context).colorScheme.taglineText),
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
              child: Column(
                children: [
                  SizedBox(
                    height: Dimensions.h10,
                  ),

                  // Top Logo
                  CustomSvgAssetImage(
                    image: ImageAsset.icAppIconWithTagline,
                    height: Dimensions.h70,
                  ),
                  SizedBox(
                    height: Dimensions.h13,
                  ),

                  // Sign In Text
                  Text(
                    AppString.signIn,
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
                  AppUtils.isAndroid
                      ? Row(
                          children: [
                            SignInModeButton(
                                onPressed: () {}, svgIcon: ImageAsset.icGoogle),
                            SizedBox(
                              width: Dimensions.w7,
                            ),
                            SignInModeButton(
                                onPressed: () {},
                                svgIcon: ImageAsset.icFacebook),
                            SizedBox(
                              width: Dimensions.w7,
                            ),
                            SignInModeButton(
                                onPressed: () {}, svgIcon: ImageAsset.icApple),
                          ],
                        )
                      : Row(
                          children: [
                            SignInModeButton(
                                onPressed: () {}, svgIcon: ImageAsset.icApple),
                            SizedBox(
                              width: Dimensions.w7,
                            ),
                            SignInModeButton(
                                onPressed: () {},
                                svgIcon: ImageAsset.icFacebook),
                            SizedBox(
                              width: Dimensions.w7,
                            ),
                            SignInModeButton(
                                onPressed: () {}, svgIcon: ImageAsset.icGoogle),
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

                  // Email Text
                  Container(
                    padding: EdgeInsets.only(left: Dimensions.h10),
                    alignment: Alignment.centerLeft,
                    child: Text(AppString.email,
                        textAlign: TextAlign.center,
                        style: fontStyleSemiBold15.apply(
                            color: Theme.of(context).colorScheme.textColor)),
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
                        color: Theme.of(context).colorScheme.textColor,
                      ),
                      textStyle: fontStyleRegular14.apply(
                          color: Theme.of(context).colorScheme.textColor),
                      height: Dimensions.h40,
                      textInputType: TextInputType.emailAddress,
                      hintTextColor: ColorConst.hintColor,
                      textController: signInController.emailController,
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
                          color: Theme.of(context).colorScheme.textColor,
                        ),
                        suffixIcon: CustomSvgAssetImage(
                          height: Dimensions.h23,
                          color: Theme.of(context).colorScheme.textColor,
                          onTap: () {
                            signInController.isPasswordVisible.value = !signInController.isPasswordVisible.value;
                          },
                          image: signInController.isPasswordVisible.value
                              ? ImageAsset.icHidePassword
                              : ImageAsset.icViewPassword,
                        ),
                        textStyle: fontStyleRegular14.apply(
                            color: Theme.of(context).colorScheme.textColor),
                        height: Dimensions.h40,
                        obscureText: signInController.isPasswordVisible.value,
                        hintTextColor: ColorConst.hintColor,
                        textController: signInController.passwordController,
                        textInputAction: TextInputAction.done,
                        textFieldBorderColor: Colors.transparent,
                        hintText: AppString.enterYourNewPasswordHere),
                  ),
                  SizedBox(
                    height: Dimensions.h20,
                  ),

                  // Sign In Button
                  Hero(
                    tag: "signInToIntro",
                    transitionOnUserGestures: true,
                    child: MyButton(
                      title: AppString.signIn,
                      // onPressed:  signInController.checkValidation,
                      onPressed: () => Get.to(() => OnBoardingScreen()),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.h13,
                  ),

                  // As Guest || Forgot Pass
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // As Guest
                      TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.r15))),
                        onPressed: () => Get.offAll(() => const HomeScreen()),
                        child: Text(
                          AppString.continueAsGuest,
                          style: fontStyleSemiBold13.apply(
                              color: Theme.of(context).colorScheme.taglineText),
                        ),
                      ),
                      // Forgot Password
                      TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.r15))),
                        onPressed: forgotPassword,
                        child: Text(
                          AppString.forgotPassword,
                          style: fontStyleSemiBold13.apply(
                              color: Theme.of(context).colorScheme.taglineText),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void forgotPassword() {
    AppUtils.showCustomDialog(
        myWidget: Builder(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Email Text
                Container(
                  padding: EdgeInsets.only(bottom: Dimensions.h3),
                  alignment: Alignment.centerLeft,
                  child: Text(AppString.email,
                      textAlign: TextAlign.center,
                      style: fontStyleSemiBold15.apply(
                          color: Theme.of(context).colorScheme.textColor)),
                ),

                // Email Text field
                MyTextField(
                    autoFocus: true,
                    borderRadius: Dimensions.r10,
                    prefixIcon: CustomSvgAssetImage(
                      image: ImageAsset.icEmail,
                      width: Dimensions.w25,
                      color: Theme.of(context).colorScheme.textColor,
                    ),
                    textStyle: fontStyleRegular14.apply(
                        color: Theme.of(context).colorScheme.textColor),
                    height: Dimensions.h40,
                    textInputType: TextInputType.emailAddress,
                    hintTextColor: ColorConst.hintColor,
                    textInputAction: TextInputAction.done,
                    textController: signInController.emailController,
                    textFieldBorderColor: Colors.transparent,
                    hintText: AppString.enterYourEmailHere),
                SizedBox(
                  height: Dimensions.h15,
                ),

                // Forgot Password Button
                MyButton(
                  height: Dimensions.h32,
                  title: AppString.sendLink,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();

                    if (signInController.emailController.text.trim().isEmpty) {
                      AppUtils.showSnackBar(message: AppString.emailCantBeEmpty);
                    } else if (!signInController.emailController.text.trim().isEmail) {
                      AppUtils.showSnackBar(
                          message: AppString.pleaseEnterAValidEmailAddress);
                    } else {
                      EasyLoading.show();
                      Future.delayed(const Duration(milliseconds: 2000), () {
                        EasyLoading.dismiss();
                        Get.back();

                        // Email Sent Dialog
                        AppUtils.showCustomDialog(
                            onDialogCloseFunction: () =>
                                Get.to(() => ForgotPasswordScreen()),
                            icon: ImageAsset.icDialogueChecked,
                            title: AppString.linkSent,
                            contentText: AppString.linkSentBody);
                      });
                    }
                  },
                ),
                SizedBox(
                  height: Dimensions.h13,
                ),
              ],
            );
          },
        ),
        title: AppString.linkSent,
        contentText: AppString.linkSentBody);
  }
}
