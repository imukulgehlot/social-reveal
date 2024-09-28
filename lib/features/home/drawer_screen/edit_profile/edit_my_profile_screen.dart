import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/basic_features.dart';
import '../../../../core/widgets/custom_image.dart';
import '../../../../custom/custom_text_field_with_head.dart';
import '../../../../custom/settings_list_tile.dart';
import 'change_password_screen.dart';

class EditMyProfileScreen extends StatelessWidget {
  EditMyProfileScreen({super.key});

  final phoneTextEditingController = Get.put(
      TextEditingController(text: "+91-9999999998"),
      tag: "phoneTextEditingController");

  final cityTextEditingController = Get.put(
      TextEditingController(text: "Sokovia, Eastern Europe"),
      tag: "cityTextEditingController");

  final stateTextEditingController = Get.put(
      TextEditingController(text: "DarkWorld"),
      tag: "stateTextEditingController");

  final pinCodeTextEditingController = Get.put(
      TextEditingController(text: "722173"),
      tag: "pinCodeTextEditingController");

  final RxString selectedMediaFile =
      'https://www.themarysue.com/wp-content/uploads/2021/02/wanda-trauma.jpg?resize=1200%2C675'
          .obs;

  final RxBool showMediaLoadingIndicator = false.obs;

  Future<void> deleteLastCacheImage() async {
    if (selectedMediaFile.isNotEmpty) {
      File(selectedMediaFile.value).delete(recursive: true);
    }
  }

  Future<void> selectMediaFromDevice() async {
    if (await AppUtils.isMediaPermissionGranted()) {
      final chosenMedia =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      showMediaLoadingIndicator.value = true;

      if (chosenMedia != null) {
        deleteLastCacheImage();
        selectedMediaFile.value = chosenMedia.path;
      }
      showMediaLoadingIndicator.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.editProfile,
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
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.commonPaddingForScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              SizedBox(
                height: Dimensions.h10,
              ),
              Align(
                alignment: Alignment.center,
                child: Obx(
                  () => Material(
                    borderRadius: BorderRadius.circular(Dimensions.r50),
                    color: Get.theme.colorScheme.textFieldColor,
                    child: InkWell(
                      onTap: selectMediaFromDevice,
                      borderRadius: BorderRadius.circular(Dimensions.r50),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: showMediaLoadingIndicator.value
                            ? SizedBox(
                                width: Dimensions.w90,
                                height: Dimensions.w90,
                                child: const Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                              )
                            : selectedMediaFile.value.isEmpty
                                ? Container(
                                    key: UniqueKey(),
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle),
                                    height: Dimensions.w90,
                                    width: Dimensions.w90,
                                    child: Center(
                                      child: Icon(Icons.photo_library_outlined,
                                          size: Dimensions.w38),
                                    ),
                                  )
                                : ClipRRect(
                                    key: UniqueKey(),
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.r50),
                                    child: selectedMediaFile.value
                                            .startsWith("http")
                                        ? Hero(
                                            tag: "wayToEditProfile",
                                            child: MyCircleNetworkImage(
                                              image: selectedMediaFile.value,
                                              radius: Dimensions.r50,
                                            )
                                            // MyNetworkImage(
                                            //         height: Dimensions.w90,
                                            //         width: Dimensions.w90,
                                            //         image: selectedMediaFile.value,
                                            //         fitType: BoxFit.cover,
                                            //       ),
                                            )
                                        : Image.file(
                                            height: Dimensions.w90,
                                            width: Dimensions.w90,
                                            File(selectedMediaFile.value),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.h23,
              ),

              // Your Name
              CustomTextFieldWithHead(
                  isEnabled: false,
                  title: AppString.yourName,
                  hintText: "",
                  controller: TextEditingController(text: 'Wanda Maximoff'),
                  prefixIcon: ImageAsset.icUser),
              SizedBox(
                height: Dimensions.h13,
              ),

              // Your Email
              CustomTextFieldWithHead(
                  title: AppString.yourEmail,
                  isEnabled: false,
                  hintText: "",
                  controller:
                      TextEditingController(text: 'witchwanda@darkness.com'),
                  prefixIcon: ImageAsset.icEmail),
              SizedBox(
                height: Dimensions.h13,
              ),

              // Your User ID
              CustomTextFieldWithHead(
                  title: AppString.yourUserID,
                  isEnabled: false,
                  hintText: "",
                  controller: TextEditingController(text: 'theredwitch'),
                  prefixIcon: ImageAsset.icUser),
              SizedBox(
                height: Dimensions.h13,
              ),

              // Your Phone
              CustomTextFieldWithHead(
                  title: AppString.yourPhone,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.phone,
                  hintText: AppString.enterYourPhoneHere,
                  controller: phoneTextEditingController,
                  prefixIcon: ImageAsset.icPhone),
              SizedBox(
                height: Dimensions.h13,
              ),

              // Your City
              CustomTextFieldWithHead(
                  title: AppString.yourCity,
                  textInputAction: TextInputAction.next,
                  hintText: "Select your city",
                  controller: cityTextEditingController,
                  prefixIcon: ImageAsset.icCity),
              SizedBox(
                height: Dimensions.h13,
              ),

              // Your State
              CustomTextFieldWithHead(
                  title: AppString.yourState,
                  textInputAction: TextInputAction.next,
                  hintText: "Select your state",
                  controller: stateTextEditingController,
                  prefixIcon: ImageAsset.icCity),
              SizedBox(
                height: Dimensions.h13,
              ),

              // Pin Code
              CustomTextFieldWithHead(
                  title: AppString.yourPinCode,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.phone,
                  hintText: AppString.enterYourPhoneHere,
                  controller: pinCodeTextEditingController,
                  prefixIcon: ImageAsset.icLocation),
              SizedBox(
                height: Dimensions.h13,
              ),

              // Change Password
              SettingsListTile(
                  title: AppString.changePassword,
                  onTap: () => Get.to(() => ChangePasswordScreen()),
                  subTitle: AppString.changeYourCurrentPassword),
              SizedBox(
                height: Dimensions.h13,
              ),

              // Save Button
              MyButton(
                title: AppString.save,
                onPressed: () => Get.back(),
              ),
              SafeArea(
                child: SizedBox(
                  height: Dimensions.h13,
                ),
              ),
            ],
          )),
    );
  }
}
