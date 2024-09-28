import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';
import 'package:rstsocial/core/widgets/text_field/text_field/my_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final enterCurrentPasswordController =
      Get.put(TextEditingController(), tag: "enterCurrentPasswordController");

  final enterPasswordController =
      Get.put(TextEditingController(), tag: "enterPasswordController");

  final confirmPasswordController =
      Get.put(TextEditingController(), tag: "confirmPasswordController");

  final RxBool isCurrentPasswordVisible = true.obs;
  final RxBool isEnterPasswordVisible = true.obs;
  final RxBool isConfirmPasswordVisible = true.obs;

  void checkValidation() {
    if (enterCurrentPasswordController.text.trim().isEmpty) {
      AppUtils.showSnackBar(message: AppString.currentPasswordCantBeEmpty);
    } else if (enterPasswordController.text.trim().isEmpty) {
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
      Get.back();

      AppUtils.showSnackBar(
          message: "Password Changed Successfully!", isSuccess: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.changePassword,
          style: fontStyleSemiBold17.apply(
            color: Theme.of(context).colorScheme.textColor,
          ),
        ),
        titleSpacing: 0,
        leading: IconButton(
          iconSize: Dimensions.w28,
          icon: CustomSvgAssetImage(
            image: ImageAsset.icBackArrowNav,
            width: Dimensions.w28,
            height: Dimensions.h28,
            color: Theme.of(context).colorScheme.textColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
        child: Column(
          children: [
            // Current Password
            Container(
              padding: EdgeInsets.only(left: Dimensions.h10),
              alignment: Alignment.centerLeft,
              child: Text(AppString.currentPassword,
                  textAlign: TextAlign.center,
                  style: fontStyleSemiBold15.apply(
                      color: Theme.of(context).colorScheme.textColor)),
            ),
            SizedBox(
              height: Dimensions.h3,
            ),
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
                  textController: enterCurrentPasswordController,
                  textInputAction: TextInputAction.done,
                  textFieldBorderColor: Colors.transparent,
                  hintText: AppString.enterCurrentPassword),
            ),
            SizedBox(
              height: Dimensions.h13,
            ),

            // New Pass Text
            Container(
              padding: EdgeInsets.only(left: Dimensions.h10),
              alignment: Alignment.centerLeft,
              child: Text(AppString.newPassword,
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
                  hintText: AppString.enterNewPassword),
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
                  hintText: AppString.confirmNewPassword),
            ),
            SizedBox(
              height: Dimensions.h20,
            ),

            //  Set Password Button
            MyButton(
              title: AppString.save,
              // onPressed: () => Get.to(() => OnBoardingScreen()),
              onPressed: checkValidation,
            ),
          ],
        ),
      ),
    );
  }
}
