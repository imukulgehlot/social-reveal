import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/text_field/text_field/my_text_field_without_border.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/model/ui_model/category_model.dart';
import '../../../core/widgets/custom_image.dart';
import '../health_category_and_topics_screen.dart';

class AddYourJourneyScreen extends StatelessWidget {
  final String title;
  final String storyText;

  AddYourJourneyScreen({super.key, this.title = '', this.storyText = ''});

  final RxString selectedMediaFile = ''.obs;
  final RxBool showMediaLoadingIndicator = false.obs;

  // Text Editing Controllers
  late final Rx<TextEditingController> tagsTextController =
      Get.put(TextEditingController().obs, tag: "tagsTextController");
  late final Rx<TextEditingController> titleTextController = Get.put(
      TextEditingController(text: title).obs,
      tag: "titleTextController");
  late final Rx<TextEditingController> storyTextController = Get.put(
      TextEditingController(text: storyText).obs,
      tag: "storyTextController");

  late final RxList<CommonUIModel> listHealthCategories = [
    CommonUIModel(
      title: 'Friends',
      image: ImageAsset.icPhysical,
      isSelected: true,
    ),
    CommonUIModel(
      title: 'Groups',
      image: ImageAsset.icLifestyle,
      isSelected: false,
    ),
    CommonUIModel(
      title: 'Messages',
      image: ImageAsset.icDietary,
      isSelected: false,
    ),
    CommonUIModel(
      title: 'Trending',
      image: ImageAsset.icNutritional,
      isSelected: false,
    ),
    CommonUIModel(
      title: 'Viral',
      image: ImageAsset.icExperiences,
      isSelected: false,
    ),
    CommonUIModel(
      title: 'Events',
      image: ImageAsset.icAlternateMedicine,
      isSelected: false,
    ),
    CommonUIModel(
      title: 'Social Buzz',
      image: ImageAsset.icSpiritual,
      isSelected: false,
    ),
    CommonUIModel(
      title: 'Stories',
      image: ImageAsset.icSocial,
      isSelected: false,
    ),
  ].obs;


  // VideoPlayerController? videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.addYourJourney,
            style: fontStyleSemiBold17.apply(
              color: Theme.of(context).colorScheme.textColor,
            )),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Select A Category
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.commonPaddingForScreen)
                  .copyWith(bottom: Dimensions.h10),
              child: Text(
                AppString.selectACategory,
                style: fontStyleSemiBold15.copyWith(
                    color: Get.theme.colorScheme.textColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Dimensions.h17),
              child: SizedBox(
                height: Get.height * 0.045,
                child: Obx(
                  () => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: listHealthCategories.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        listHealthCategories
                            .firstWhere((element) => element.isSelected == true)
                            .isSelected = false;

                        listHealthCategories[index].isSelected = true;
                        listHealthCategories.refresh();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.h3,
                            horizontal: Dimensions.w18),
                        margin: EdgeInsets.only(
                            left: Dimensions.w16,
                            right: index == listHealthCategories.length - 1
                                ? Dimensions.w13
                                : 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.r25),
                          color: listHealthCategories[index].isSelected
                              ? ColorConst.primaryColor
                              : Get.theme.colorScheme.textFieldColor,
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Icon
                              CustomSvgAssetImage(
                                image: listHealthCategories[index].image ?? '',
                                width: Dimensions.w20,
                                height: Dimensions.w20,
                                color: listHealthCategories[index].isSelected
                                    ? ColorConst.whiteColor
                                    : Get.theme.colorScheme.textColor,
                              ),
                              SizedBox(
                                width: Dimensions.w5,
                              ),

                              // Category Name
                              Text(
                                listHealthCategories[index].title,
                                style: fontStyleBold13.apply(
                                    color:
                                        listHealthCategories[index].isSelected
                                            ? ColorConst.whiteColor
                                            : Get.theme.colorScheme.textColor),
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Tags field
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.commonPaddingForScreen)
                  .copyWith(bottom: Dimensions.h17),
              child: MyTextFieldWithOutBorder(
                prefixIcon: Padding(
                  padding: EdgeInsets.only(
                      right: Dimensions.w1, left: Dimensions.w10),
                  child: CustomSvgAssetImage(
                    image: ImageAsset.icPrefixHash,
                    width: Dimensions.w30,
                    height: Dimensions.w30,
                    color: Get.theme.colorScheme.hintTextColor,
                  ),
                ),
                textController: tagsTextController.value,
                textInputAction: TextInputAction.done,
                backgroundColor: Get.theme.colorScheme.textFieldColor,
                hintText: AppString.addTags,
              ),
            ),

            // My health story
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.commonPaddingForScreen)
                  .copyWith(bottom: Dimensions.h10),
              child: Text(
                AppString.myHealthStory,
                style: fontStyleSemiBold15.copyWith(
                    color: Get.theme.colorScheme.textColor),
              ),
            ),

            // My health Text Field
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.commonPaddingForScreen)
                  .copyWith(bottom: Dimensions.h15),
              child: MyTextFieldWithOutBorder(
                prefixIcon: Padding(
                  padding: EdgeInsets.only(
                      right: Dimensions.w5, left: Dimensions.w10),
                  child: CustomSvgAssetImage(
                    image: ImageAsset.icPrefixTitle,
                    width: Dimensions.w25,
                    height: Dimensions.w25,
                    color: Get.theme.colorScheme.hintTextColor,
                  ),
                ),
                textController: titleTextController.value,
                textInputAction: TextInputAction.next,
                backgroundColor: Get.theme.colorScheme.textFieldColor,
                hintText: AppString.meAndMyHealth,
              ),
            ),

            // Add Image or Video
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.commonPaddingForScreen)
                  .copyWith(bottom: Dimensions.h15),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.photo_library_outlined,
                                            size: Dimensions.w45),
                                        SizedBox(height: Dimensions.h10),
                                        Text(
                                          AppString.addImageOrVideo,
                                          style: fontStyleSemiBold17.apply(
                                            color:
                                                Get.theme.colorScheme.textColor,
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
                                  child: AppUtils.isVideoFile(
                                          selectedMediaFile.value)
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
                                                  child:
                                                      CupertinoActivityIndicator(
                                                          color: ColorConst
                                                              .primaryColor),
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

            // Story Text Field
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.r8),
                  color: ColorConst.textFieldColor,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w10, vertical: Dimensions.h10),
                child: MyTextFieldWithOutBorder(
                  maxLine: 5,
                  hintText: AppString.enterYourStoryHere,
                  textController: storyTextController.value,
                ),
              ),
            ),

            //  Next Button
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen,
                  vertical: Dimensions.h20),
              child: MyButton(
                onPressed: () =>
                    Get.to(() => const HealthCategoryAndTopicsScreen()),
                title: AppString.next,
              ),
            ),
          ],
        ),
      ),
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

// Future<bool> isPermissionGranted(ImageSource? imageSource) async {
//   final permission = imageSource == ImageSource.gallery
//       ? Platform.isAndroid && Const.androidInfo!.version.sdkInt <= 32
//       ? Permission.storage
//       : Permission.photos
//       : Permission.camera;
//
//   final status = await permission.status;
//
//   if (status.isDenied) {
//     final newStatus = await permission.request();
//     return newStatus.isGranted || newStatus.isLimited;
//   } else if (status.isPermanentlyDenied) {
//     openAppSettings();
//     return false;
//   } else {
//     return true;
//   }
// }
