import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../../../../core/model/ui_model/category_model.dart';
import '../../../../../../core/widgets/custom_image.dart';
import '../../../../../../core/widgets/text_field/text_field/my_text_field_without_border.dart';
import '../../../../../../custom/custom_text_field_with_head.dart';

class CreateServicesTab extends StatelessWidget {
  CreateServicesTab({super.key});

  // Text Editing Controllers
  late final Rx<TextEditingController> postTitleTextController =
      Get.put(TextEditingController().obs, tag: "postTitleTextController");

  late final Rx<TextEditingController> aboutYourServiceTextController = Get.put(
      TextEditingController().obs,
      tag: "aboutYourServiceTextController");

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Services Title
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h8, top: Dimensions.h10),
          child: Text(
            AppString.serviceTitle,
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
            textController: postTitleTextController.value,
            textInputAction: TextInputAction.next,
            backgroundColor: Theme.of(context).colorScheme.textFieldColor,
            hintText: AppString.enterYourServiceTitleHere,
          ),
        ),

        // Service Description
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h8),
          child: Text(
            AppString.aboutYourService,
            style: fontStyleSemiBold15.copyWith(
                color: Get.theme.colorScheme.textColor),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(bottom: Dimensions.h15),
          child: CustomTextFieldWithHead(
            hintText: AppString.enterYourServiceDescriptionHere,
            textInputType: TextInputType.multiline,
            controller: aboutYourServiceTextController.value,
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

        // Post Button
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
}
