import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';
import 'package:rstsocial/core/widgets/text_field/text_field/my_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController enterPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RxBool isEnterPasswordVisible = true.obs;
  final RxBool isConfirmPasswordVisible = true.obs;

  void checkValidation() {
    if (enterPasswordController.text.trim().isEmpty) {
      AppUtils.showSnackBar(message: AppString.passwordCantBeEmpty);
    } else if (enterPasswordController.text.trim().length < 8) {
      AppUtils.showSnackBar(message: AppString.passwordShouldBeAtLeast);
    } else if (confirmPasswordController.text.trim() !=
        enterPasswordController.text.trim()) {
      AppUtils.showSnackBar(message: AppString.yourPasswordNotMatch);
    } else {
      isEnterPasswordVisible.value = true;
      isConfirmPasswordVisible.value = true;
      AppUtils.closeKeyboard();

      AppUtils.showSnackBar(
          message: "Password Changed Successfully!", isSuccess: true);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  color: ColorConst.primaryColor,
                  height: Dimensions.h70,
                ),
                SizedBox(
                  height: Dimensions.h13,
                ),

                // Set Password Text
                Text(
                  AppString.setPassword,
                  style:
                      fontStyleBold32.copyWith(color: Theme.of(context).colorScheme.taglineText),
                ),

                // Set Password Tagline
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
                  child: Text(
                    AppString.enterYourNewPasswordAndConfirm,
                    textAlign: TextAlign.center,
                    style: fontStyleMedium15.copyWith(
                        color: Theme.of(context).colorScheme.taglineText),
                  ),
                ),
                SizedBox(
                  height: Dimensions.h13,
                ),

                // New Pass Text
                Container(
                  padding: EdgeInsets.only(left: Dimensions.h10),
                  alignment: Alignment.centerLeft,
                  child: Text(AppString.enterNewPassword,
                      textAlign: TextAlign.center,
                      style: fontStyleSemiBold15.apply(
                          color: Theme.of(context).colorScheme.textColor)),
                ),
                SizedBox(
                  height: Dimensions.h3,
                ),

                // New Password Text field
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
                          isEnterPasswordVisible.value =
                              !isEnterPasswordVisible.value;
                        },
                        image: isEnterPasswordVisible.value
                            ? ImageAsset.icHidePassword
                            : ImageAsset.icViewPassword,
                      ),
                      textStyle: fontStyleRegular14.apply(
                          color: Theme.of(context).colorScheme.textColor),
                      height: Dimensions.h40,
                      obscureText: isEnterPasswordVisible.value,
                      hintTextColor: ColorConst.hintColor,
                      textController: enterPasswordController,
                      textInputAction: TextInputAction.done,
                      textFieldBorderColor: Colors.transparent,
                      hintText: AppString.enterYourNewPasswordHere),
                ),

                SizedBox(
                  height: Dimensions.h13,
                ),

                // Confirm Password Text
                Container(
                  padding: EdgeInsets.only(left: Dimensions.h10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppString.confirmNewPassword,
                    textAlign: TextAlign.center,
                    style: fontStyleSemiBold15.apply(
                        color: Theme.of(context).colorScheme.textColor),
                  ),
                ),
                SizedBox(
                  height: Dimensions.h3,
                ),

                // Confirm Password Text Field
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
                          isConfirmPasswordVisible.value =
                              !isConfirmPasswordVisible.value;
                        },
                        image: isConfirmPasswordVisible.value
                            ? ImageAsset.icHidePassword
                            : ImageAsset.icViewPassword,
                      ),
                      textStyle: fontStyleRegular14.apply(
                          color: Theme.of(context).colorScheme.textColor),
                      height: Dimensions.h40,
                      obscureText: isConfirmPasswordVisible.value,
                      hintTextColor: ColorConst.hintColor,
                      textController: confirmPasswordController,
                      textInputAction: TextInputAction.done,
                      textFieldBorderColor: Colors.transparent,
                      hintText: AppString.enterYourNewPasswordHere),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),

                //  Set Password Button
                Hero(
                  tag: "signInToIntro",
                  transitionOnUserGestures: true,
                  child: MyButton(
                    title: AppString.setPassword,
                    // onPressed: () => Get.to(() => OnBoardingScreen()),
                    onPressed: checkValidation,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
