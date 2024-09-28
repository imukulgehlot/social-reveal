import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rstsocial/custom/custom_text_field_with_head.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/basic_features.dart';
import '../../../core/widgets/custom_image.dart';
import '../health_category_and_topics_screen.dart';

class ProfessionalProfile extends StatelessWidget {
  ProfessionalProfile({super.key});

  final RxInt currentStep = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox.square(
                  dimension: kToolbarHeight,
                  child: IconButton(
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Dimensions.h25, right: Get.width * 0.15),
                    child: // Top Logo
                        CustomSvgAssetImage(
                      image: Get.theme.brightness == Brightness.dark
                          ? ImageAsset.icAppLogoLight
                          : ImageAsset.icAppLogoDark,
                      color: ColorConst.primaryColor,
                      width: Dimensions.w105,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.h10,
            ),
            // Tagline
            Text(
              AppString.socialNetworkUiShowcase,
              style: fontStyleSemiBold13.apply(color: ColorConst.primaryColor),
            ),
            SizedBox(
              height: Dimensions.h30,
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen),
              child: Column(
                children: [
                  Text(
                    AppString.completeYourProfessionalProfile,
                    style:
                        fontStyleBold17.apply(color: Theme.of(context).colorScheme.taglineText),
                  ),
                  Text(
                    AppString.buildYourOnlinePresence,
                    style: fontStyleMedium14.apply(
                        color: Theme.of(context).colorScheme.taglineText),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            Expanded(
              child: Obx(
                () => Stepper(
                    elevation: 0,
                    stepIconBuilder: (stepIndex, stepState) {
                      return Text(
                        (stepIndex + 1).toString(),
                        style: fontStyleSemiBold12.apply(
                            color: ColorConst.whiteColor),
                      );
                    },
                    connectorColor: MaterialStateColor.resolveWith((states) {
                      return states.isNotEmpty
                          ? states.elementAt(0) == MaterialState.selected
                              ? ColorConst.primaryColor
                              : ColorConst.greyColor
                          : ColorConst.greyColor;
                    }),
                    controlsBuilder: (context, details) => MyButton(
                          onPressed: () => currentStep.value < 2
                              ? currentStep.value++
                              : Get.to(
                                  () => const HealthCategoryAndTopicsScreen()),
                          title: AppString.next,
                        ),
                    margin: EdgeInsets.zero,
                    currentStep: currentStep.value,
                    type: StepperType.horizontal,
                    onStepTapped: (value) {
                      currentStep.value = value;
                    },
                    steps: [
                      Step(
                          title: const SizedBox(),
                          content: ProfessionalProfileContentOne(),
                          isActive: currentStep.value >= 0 ? true : false),
                      Step(
                          title: const SizedBox(),
                          content: ProfessionalProfileContentTwo(),
                          isActive: currentStep.value >= 1 ? true : false),
                      Step(
                          title: const SizedBox(),
                          content: ProfessionalProfileContentThree(),
                          isActive: currentStep.value >= 2 ? true : false)
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfessionalProfileContentOne extends StatelessWidget {
  ProfessionalProfileContentOne({super.key});

  final RxString selectedMediaFile = ''.obs;
  final RxBool showMediaLoadingIndicator = false.obs;

  final TextEditingController businessNameController =
      Get.put(TextEditingController(), tag: 'businessNameController');
  final TextEditingController contactNumberController =
      Get.put(TextEditingController(), tag: 'contactNumberController');
  final TextEditingController addressController =
      Get.put(TextEditingController(), tag: 'addressController');
  final TextEditingController businessDescriptionController =
      Get.put(TextEditingController(), tag: 'businessDescriptionController');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldWithHead(
            title: AppString.yourNameDBAOrBusinessName,
            hintText: AppString.enterYourBusinessAddressHere,
            controller: businessDescriptionController,
            prefixIcon: ImageAsset.icBusinessName),
        SizedBox(
          height: Dimensions.h20,
        ),
        CustomTextFieldWithHead(
            title: AppString.contactNumber,
            hintText: AppString.enterYourContactNumberHere,
            controller: contactNumberController,
            prefixIcon: ImageAsset.icContactNumber),
        SizedBox(
          height: Dimensions.h20,
        ),
        CustomTextFieldWithHead(
            title: AppString.address,
            hintText: AppString.enterYourBusinessAddressHere,
            controller: addressController,
            prefixIcon: ImageAsset.icAddress),
        SizedBox(
          height: Dimensions.h20,
        ),
        CustomTextFieldWithHead(
          title: AppString.enterYourBusinessDescriptionHere,
          hintText: AppString.enterYourContactNumberHere,
          controller: businessDescriptionController,
          prefixIcon: ImageAsset.icAboutYourself,
          maxLine: 4,
          padding: EdgeInsets.only(top: Dimensions.h10),
          iconBottomPadding: Dimensions.h50,
        ),
        SizedBox(
          height: Dimensions.h20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h20),
          child: Obx(
            () => Material(
              borderRadius: BorderRadius.circular(Dimensions.r8),
              color: Get.theme.colorScheme.textFieldColor,
              child: InkWell(
                onTap: selectMediaFromDevice,
                splashColor: ColorConst.primaryLightColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(Dimensions.r8),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: showMediaLoadingIndicator.value
                      ? SizedBox(
                          width: Get.width,
                          height: Dimensions.w150,
                          child: const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        )
                      : selectedMediaFile.value.isEmpty
                          ? Container(
                              key: UniqueKey(),
                              height: Dimensions.w150,
                              color: Colors.transparent,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.photo_library_outlined,
                                        size: Dimensions.w45),
                                    SizedBox(height: Dimensions.h10),
                                    Text(
                                      AppString.addImageOrVideo,
                                      style: fontStyleSemiBold17.apply(
                                        color: Get.theme.colorScheme.textColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : ClipRRect(
                              key: UniqueKey(),
                              borderRadius:
                                  BorderRadius.circular(Dimensions.r8),
                              child: AppUtils.isVideoFile(selectedMediaFile.value)
                                  ? SizedBox(
                                      height: Dimensions.w150,
                                      child: FutureBuilder(
                                          future: AppUtils.genThumbnailFile(
                                              selectedMediaFile.value),
                                          builder: (context, snap) {
                                            if (snap.hasData) {
                                              return Image.file(
                                                width: Get.width,
                                                height: Dimensions.w150,
                                                File(snap.data.toString()),
                                                fit: BoxFit.cover,
                                              );
                                            }
                                            return const Center(
                                              child: CupertinoActivityIndicator(
                                                  color:
                                                      ColorConst.primaryColor),
                                            );
                                          })
                                      /*VideoPlayer(
                                                videoPlayerController!,
                                              )*/
                                      )
                                  : Image.file(
                                      height: Dimensions.w150,
                                      width: Get.width,
                                      File(selectedMediaFile.value),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> selectMediaFromDevice() async {
    if (await AppUtils.isMediaPermissionGranted()) {
      final chosenMedia = await ImagePicker().pickMedia();
      showMediaLoadingIndicator.value = true;

      if (chosenMedia != null) {
        deleteLastCacheImage();

        // if (Const.isVideoFile(chosenMedia.path)) {
        // videoPlayerController?.dispose();
        // videoPlayerController =
        //     VideoPlayerController.file(File(chosenMedia.path));

        // Initialize the controller and extract thumbnail
        // await videoPlayerController?.initialize();
        // await videoPlayerController?.play();

        // Future.delayed(const Duration(milliseconds: 100), () {
        //   videoPlayerController?.pause();
        // });

        // }

        selectedMediaFile.value = chosenMedia.path;
      }
      showMediaLoadingIndicator.value = false;
    }
  }

  Future<void> deleteLastCacheImage() async {
    if (selectedMediaFile.isNotEmpty) {
      File(selectedMediaFile.value).delete(recursive: true);
    }
  }
}

class ProfessionalProfileContentTwo extends StatelessWidget {
  ProfessionalProfileContentTwo({super.key});

  final TextEditingController yourUrlController =
      Get.put(TextEditingController(), tag: 'yourUrlController');
  final TextEditingController yourFacebookController =
      Get.put(TextEditingController(), tag: 'yourFacebookController');
  final TextEditingController yourLinkedInController =
      Get.put(TextEditingController(), tag: 'yourLinkedInController');
  final TextEditingController yourInstagramController =
      Get.put(TextEditingController(), tag: 'yourInstagramController');
  final TextEditingController yourYoutubeController =
      Get.put(TextEditingController(), tag: 'yourYoutubeController');
  final TextEditingController yourTwitterController =
      Get.put(TextEditingController(), tag: 'yourTwitterController');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldWithHead(
          title: AppString.yourUrl,
          hintText: AppString.enterYourBusinessUrlHere,
          controller: yourUrlController,
          prefixIcon: ImageAsset.icYourUrl,
        ),
        SizedBox(
          height: Dimensions.h20,
        ),
        CustomTextFieldWithHead(
          title: AppString.yourFacebook,
          hintText: "${AppString.enterYourFacebookUrlHere}(${AppString.ifAny})",
          controller: yourFacebookController,
          prefixIcon: ImageAsset.icYourFacebook,
        ),
        SizedBox(
          height: Dimensions.h20,
        ),
        CustomTextFieldWithHead(
          title: AppString.yourLinkedIn,
          hintText: "${AppString.enterYourLinkedInUrlHere}(${AppString.ifAny})",
          controller: yourLinkedInController,
          prefixIcon: ImageAsset.icYourLinkedIn,
        ),
        SizedBox(
          height: Dimensions.h20,
        ),
        CustomTextFieldWithHead(
          title: AppString.yourInstagram,
          hintText:
              "${AppString.enterYourInstagramUrlHere}(${AppString.ifAny})",
          controller: yourInstagramController,
          prefixIcon: ImageAsset.icYourInstagram,
        ),
        SizedBox(
          height: Dimensions.h20,
        ),
        CustomTextFieldWithHead(
          title: AppString.yourYoutube,
          hintText: "${AppString.enterYourYoutubeUrlHere}(${AppString.ifAny})",
          controller: yourYoutubeController,
          prefixIcon: ImageAsset.icYourYoutube,
        ),
        SizedBox(
          height: Dimensions.h20,
        ),
        CustomTextFieldWithHead(
          title: AppString.yourTwitter,
          hintText: "${AppString.enterYourTwitterUrlHere}(${AppString.ifAny})",
          controller: yourTwitterController,
          prefixIcon: ImageAsset.icYourTwitter,
        ),
        SizedBox(
          height: Dimensions.h20,
        ),
      ],
    );
  }
}

class ProfessionalProfileContentThree extends StatelessWidget {
  ProfessionalProfileContentThree({super.key});

  final TextEditingController serviceTitleController =
      Get.put(TextEditingController(), tag: 'serviceTitleController');

  final TextEditingController aboutYourServiceController =
      Get.put(TextEditingController(), tag: 'aboutYourServiceController');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFieldWithHead(
          title: AppString.serviceTitle,
          hintText: AppString.aboutYourService,
          controller: serviceTitleController,
          prefixIcon: ImageAsset.icPrefixTitle,
        ),
        SizedBox(
          height: Dimensions.h20,
        ),
        CustomTextFieldWithHead(
          title: AppString.aboutYourService,
          hintText: AppString.enterYourContactNumberHere,
          controller: aboutYourServiceController,
          prefixIcon: ImageAsset.icAboutYourself,
          maxLine: 4,
          padding: EdgeInsets.only(top: Dimensions.h10),
          iconBottomPadding: Dimensions.h50,
        ),
        SizedBox(
          height: Dimensions.h20,
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.h15, horizontal: Dimensions.w5),
            child: InkWell(
              splashColor: ColorConst.primaryColor.withOpacity(0.2),
              highlightColor: ColorConst.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(Dimensions.r8),
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.w5),
                child: Text(
                  AppString.addMoreServices,
                  style:
                      fontStyleSemiBold18.apply(color: ColorConst.primaryColor),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
