import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../../../core/model/ui_model/category_model.dart';
import '../../../../../core/widgets/custom_image.dart';

class ServicesTab extends StatelessWidget {
  ServicesTab({super.key});

  late final RxList<CommonUIModel> listCategoriesAndTopics = [
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

  late final RxList<CommonUIModel> listServices = [
    CommonUIModel(
        title: "Yoga Sessions",
        body:
            'I can offer you personalized yoga sessions by the comfort of your home'),
    CommonUIModel(
      title: 'Yoga Trainer',
      body:
          'I can train you personally in the comfort of your home to increase your muscle flexibility',
    ),
  ].obs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Top Padding
        Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.h10),
          child: SizedBox(
            height: Get.height * 0.045,
            child: Obx(
              () => ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: listCategoriesAndTopics.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    listCategoriesAndTopics
                        .firstWhere((element) => element.isSelected == true)
                        .isSelected = false;

                    listCategoriesAndTopics[index].isSelected = true;
                    listCategoriesAndTopics.refresh();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.h2, horizontal: Dimensions.w18),
                    margin: EdgeInsets.only(
                        left: Dimensions.w16,
                        right: index == listCategoriesAndTopics.length - 1
                            ? Dimensions.w13
                            : 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.r25),
                      color: listCategoriesAndTopics[index].isSelected
                          ? ColorConst.primaryColor
                          : Get.theme.colorScheme.textFieldColor,
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Icon
                          CustomSvgAssetImage(
                            image: listCategoriesAndTopics[index].image ?? '',
                            width: Dimensions.w30,
                            height: Dimensions.w30,
                            color: listCategoriesAndTopics[index].isSelected
                                ? ColorConst.whiteColor
                                : Get.theme.colorScheme.textColor,
                          ),
                          SizedBox(
                            width: Dimensions.w5,
                          ),

                          // Category Name
                          Text(
                            listCategoriesAndTopics[index].title,
                            style: fontStyleBold13.apply(
                                color: listCategoriesAndTopics[index].isSelected
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

        // All Services
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.commonPaddingForScreen),
          child: Text(
            AppString.allServices,
            style: fontStyleSemiBold16.copyWith(
                color: Get.theme.colorScheme.textColor),
          ),
        ),

        // Service List
        Padding(
          padding: EdgeInsets.only(bottom: Dimensions.h10),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: listServices.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.h10),
                padding: EdgeInsets.all(Dimensions.w15)
                    .copyWith(top: Dimensions.h20, bottom: Dimensions.h20),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.textFieldColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listServices[index].title,
                      style: fontStyleSemiBold16.apply(
                          color: Get.theme.colorScheme.textColor),
                    ),
                    SizedBox(
                      height: Dimensions.h5,
                    ),
                    Text(
                      listServices[index].body!,
                      style: fontStyleMedium12.copyWith(
                          fontSize: Dimensions.sp11,
                          height: 1.2,
                          color: Get.theme.colorScheme.textColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
