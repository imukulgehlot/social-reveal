import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/features/home/bottom_navigation/tabs/home_tab/create_post/tag_people_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/model/ui_model/category_model.dart';
import '../../../../../../core/widgets/custom_image.dart';
import '../../../../../../core/widgets/text_field/text_field/my_text_field_without_border.dart';
import '../../../../../../custom/custom_text_field_with_head.dart';

class CreateEventsTab extends StatefulWidget {
  const CreateEventsTab({super.key});

  @override
  State<CreateEventsTab> createState() => _CreateEventsTabState();
}

class _CreateEventsTabState extends State<CreateEventsTab> {
  // Text Editing Controllers
  late final Rx<TextEditingController> eventTitleTextController =
      Get.put(TextEditingController().obs, tag: "eventTitleTextController");

  late final Rx<TextEditingController> locationTextController =
      Get.put(TextEditingController().obs, tag: "locationTextController");

  late final Rx<TextEditingController> yourPersonalizedMessageTextController =
      Get.put(TextEditingController().obs,
          tag: "yourPersonalizedTextController");

  late final Rx<TextEditingController> eventDescriptionTextController = Get.put(
      TextEditingController().obs,
      tag: "eventDescriptionTextController");

  final RxString selectedStartDateAndEndDate = ''.obs;

  final RxString selectedMediaFile = ''.obs;

  final RxBool showMediaLoadingIndicator = false.obs;

  late final RxList<CommonUIModel> listHealthCategories = [
    CommonUIModel(
      title: AppString.friends,
      image: ImageAsset.icPhysical,
      isSelected: true,
    ),
    CommonUIModel(
      title: AppString.groups,
      image: ImageAsset.icLifestyle,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.messages,
      image: ImageAsset.icDietary,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.trending,
      image: ImageAsset.icNutritional,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.eventsCategory,
      image: ImageAsset.icExperiences,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.viral,
      image: ImageAsset.icAlternateMedicine,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.socialBuzz,
      image: ImageAsset.icSpiritual,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.love,
      image: ImageAsset.icSocial,
      isSelected: false,
    ),
  ].obs;

  late final RxList<CommonUIModel> listHealthTopics = [
    CommonUIModel(
      title: "Exercise",
      isSelected: true,
    ),
    CommonUIModel(
      title: "Bodywork Therapy",
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.messages,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.trending,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.eventsCategory,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.viral,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.socialBuzz,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.love,
      isSelected: false,
    ),
  ].obs;

  late DateTimeRange eventPeriodRange;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Select Image or Video
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h8, top: Dimensions.h10),
          child: Text(
            AppString.addImage,
            style: fontStyleSemiBold15.copyWith(
                color: Get.theme.colorScheme.textColor),
          ),
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

        // Event Title
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h8),
          child: Text(
            AppString.eventTitle,
            style: fontStyleSemiBold15.copyWith(
                color: Get.theme.colorScheme.textColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h15),
          child: MyTextFieldWithOutBorder(
            prefixIcon: Padding(
              padding:
                  EdgeInsets.only(right: Dimensions.w5, left: Dimensions.w10),
              child: CustomSvgAssetImage(
                image: ImageAsset.icPrefixTitle,
                width: Dimensions.w25,
                height: Dimensions.w25,
                color: Get.theme.colorScheme.hintTextColor,
              ),
            ),
            textController: eventTitleTextController.value,
            textInputAction: TextInputAction.next,
            backgroundColor: Theme.of(context).colorScheme.textFieldColor,
            hintText: AppString.enterYourTitleHere,
          ),
        ),

        // Your Personalized Message
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h8),
          child: Text(
            AppString.yourPersonalizedMessage,
            style: fontStyleSemiBold15.copyWith(
                color: Get.theme.colorScheme.textColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h15),
          child: CustomTextFieldWithHead(
            hintText: AppString.addMessageHere,
            textInputType: TextInputType.multiline,
            controller: yourPersonalizedMessageTextController.value,
            prefixIcon: ImageAsset.icAboutYourself,
            maxLine: 4,
            padding: EdgeInsets.only(top: Dimensions.h10),
            iconBottomPadding: Dimensions.h53,
          ),
        ),

        // Event Description
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h8),
          child: Text(
            AppString.eventDescription,
            style: fontStyleSemiBold15.copyWith(
                color: Get.theme.colorScheme.textColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h15),
          child: CustomTextFieldWithHead(
            hintText: AppString.eventDescription,
            textInputType: TextInputType.multiline,
            controller: eventDescriptionTextController.value,
            prefixIcon: ImageAsset.icAboutYourself,
            maxLine: 4,
            padding: EdgeInsets.only(top: Dimensions.h10),
            iconBottomPadding: Dimensions.h53,
          ),
        ),

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
                        vertical: Dimensions.h3, horizontal: Dimensions.w18),
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
                                color: listHealthCategories[index].isSelected
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

        // Select A Topic
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h10),
          child: Text(
            AppString.selectATopic,
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
                itemCount: listHealthTopics.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                      left: index == 0 ? Dimensions.w16 : 0,
                      right: Dimensions.w13),
                  child: ChoiceChip(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.h3, horizontal: Dimensions.w18),
                    selectedColor: listHealthTopics[index].isSelected
                        ? ColorConst.primaryColor
                        : Get.theme.scaffoldBackgroundColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: listHealthTopics[index].isSelected
                                ? ColorConst.primaryColor
                                : Get.theme.colorScheme.textColor),
                        borderRadius: BorderRadius.circular(Dimensions.r20)),
                    showCheckmark: false,
                    onSelected: (value) {
                      listHealthTopics
                          .firstWhere((element) => element.isSelected == true)
                          .isSelected = false;

                      listHealthTopics[index].isSelected = true;
                      listHealthTopics.refresh();
                    },
                    label: Text(
                      listHealthTopics[index].title,
                      style: fontStyleBold13.apply(
                          color: listHealthTopics[index].isSelected
                              ? ColorConst.whiteColor
                              : Get.theme.colorScheme.textColor),
                    ),
                    selected: listHealthTopics[index].isSelected,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Select Start & End Date
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h10),
          child: Text(
            AppString.eventPeriod,
            style: fontStyleSemiBold15.copyWith(
                color: Get.theme.colorScheme.textColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h17),
          child: Material(
            borderRadius: BorderRadius.circular(Dimensions.r10),
            color: Get.theme.colorScheme.textFieldColor,
            child: InkWell(
              onTap: () {
                showDateRangePicker(
                  context: context,
                  initialDateRange: selectedStartDateAndEndDate.isEmpty
                      ? null
                      : DateTimeRange(
                          start: eventPeriodRange.start,
                          end: eventPeriodRange.end),
                  firstDate: DateTime(DateTime.now().year, 1, 1),
                  lastDate: DateTime(2030),
                  initialEntryMode: DatePickerEntryMode.input,
                ).then((DateTimeRange? value) {
                  if (value != null) {
                    eventPeriodRange = value;

                    selectedStartDateAndEndDate.value =
                        "From ${formatDateTimeFromISO(value.start)} to ${formatDateTimeFromISO(value.end)}";
                  }
                });
              },
              borderRadius: BorderRadius.circular(Dimensions.r10),
              splashColor: ColorConst.primaryLightColor.withOpacity(0.5),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w5, vertical: Dimensions.h5),
                width: Get.width,
                child: Row(
                  children: [
                    // SVG
                    CustomSvgAssetImage(
                      image: ImageAsset.icPrefixTitle,
                      width: Dimensions.w25,
                      height: Dimensions.w25,
                      color: Get.theme.colorScheme.hintTextColor,
                    ),
                    SizedBox(
                      width: Dimensions.w8,
                    ),

                    // Enter Date
                    Obx(
                      () => Text(
                        selectedStartDateAndEndDate.value.isEmpty
                            ? AppString.selectStartDateAndEndDate
                            : selectedStartDateAndEndDate.value,
                        style: fontStyleSemiBold12.copyWith(
                            color: Get.theme.colorScheme.hintTextColor),
                      ),
                    ),
                    const Spacer(),

                    // That Arrow
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: Dimensions.w20,
                      color: Get.theme.colorScheme.hintTextColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

        // Location Info
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h8),
          child: Text(
            AppString.enterLocation,
            style: fontStyleSemiBold15.copyWith(
                color: Get.theme.colorScheme.textColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h15),
          child: MyTextFieldWithOutBorder(
            prefixIcon: Padding(
              padding:
                  EdgeInsets.only(right: Dimensions.w5, left: Dimensions.w10),
              child: CustomSvgAssetImage(
                image: ImageAsset.icPrefixTitle,
                width: Dimensions.w25,
                height: Dimensions.w25,
                color: Get.theme.colorScheme.hintTextColor,
              ),
            ),
            textController: locationTextController.value,
            textInputAction: TextInputAction.next,
            backgroundColor: Theme.of(context).colorScheme.textFieldColor,
            hintText: AppString.enterTheProjectLocation,
          ),
        ),

        // Tag Sponsor
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h10),
          child: Text(
            AppString.tagSponsor,
            style: fontStyleSemiBold15.copyWith(
                color: Get.theme.colorScheme.textColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.commonPaddingForScreen),
          child: Material(
            borderRadius: BorderRadius.circular(Dimensions.r10),
            color: Get.theme.colorScheme.textFieldColor,
            child: InkWell(
              onTap: () => Get.to(() => TagPeopleScreen()),
              borderRadius: BorderRadius.circular(Dimensions.r10),
              splashColor: ColorConst.primaryLightColor.withOpacity(0.5),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.w5, vertical: Dimensions.h5),
                width: Get.width,
                child: Row(
                  children: [
                    // SVG
                    CustomSvgAssetImage(
                      image: ImageAsset.icPrefixTitle,
                      width: Dimensions.w25,
                      height: Dimensions.w25,
                      color: Get.theme.colorScheme.hintTextColor,
                    ),
                    SizedBox(
                      width: Dimensions.w8,
                    ),

                    // Click to tag People
                    Text(
                      AppString.clickToTagSponsor,
                      style: fontStyleSemiBold12.copyWith(
                          color: Get.theme.colorScheme.hintTextColor),
                    ),
                    const Spacer(),

                    // That Arrow
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: Dimensions.w20,
                      color: Get.theme.colorScheme.hintTextColor,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

        // Post Event Button
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(top: Dimensions.h12, bottom: Dimensions.h20),
          child: SafeArea(
            child: MyButton(
              height: Dimensions.h32,
              onPressed: () {},
              title: AppString.post,
            ),
          ),
        )
      ]),
    );
  }

  Future<void> selectMediaFromDevice() async {
    if (await AppUtils.isMediaPermissionGranted()) {
      final chosenMedia = await ImagePicker().pickMedia();
      showMediaLoadingIndicator.value = true;

      if (chosenMedia != null) {
        deleteLastCacheImage();
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

  String formatDateTimeFromISO(DateTime dateTime) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }
}
