import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/model/ui_model/category_model.dart';

import '../../../../../core/model/ui_model/sample_data.dart';
import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/widgets/text_field/text_field/search_bar_text_field.dart';
import '../../../../../custom/post_tile.dart';
import '../../../drawer_screen/navigation_drawer.dart';
import 'leaderboard_screen.dart';

class ExploreTabScreen extends StatelessWidget {
  ExploreTabScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: Dimensions.w5,
          title: Text(
            AppString.explore,
            style: fontStyleSemiBold17.apply(
              color: Theme.of(context).colorScheme.textColor,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: Dimensions.w10),
            child: IconButton(
              onPressed: () => openAppDrawer(),
              icon: CustomSvgAssetImage(
                image: ImageAsset.icDrawerIcon,
                color: Theme.of(context).colorScheme.textColor,
                width: Dimensions.w28,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen),
              child: SearchBarTextBoxField(
                height: Dimensions.h35,
                bgColor: Theme.of(context).colorScheme.textFieldColor,
                textController: Get.put(TextEditingController()),
                topLeftRadius: Dimensions.r20,
                topRightRadius: Dimensions.r20,
                bottomLeftRadius: Dimensions.r20,
                bottomRightRadius: Dimensions.r20,
                onChanged: (val) {},
                afterClearButton: () {},
                prefixIcon: const SizedBox(),
                hintText: AppString.searchPeopleTopic,
                hintTextColor: Theme.of(context).colorScheme.textColor,
                suffixIcon: CustomSvgAssetImage(
                  image: ImageAsset.icSearch,
                  height: Dimensions.w30,
                  width: Dimensions.w30,
                  color: Theme.of(context).colorScheme.textColor,
                ),
              ),
            ),

            // Leaderboard Button
            Padding(
                padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.commonPaddingForScreen)
                    .copyWith(top: Dimensions.h12, bottom: Dimensions.h5),
                child: MyButton(
                  padding: EdgeInsets.zero,
                  height: Dimensions.h40,
                  onPressed: () => Get.to(
                    () => LeaderBoardScreen(),
                  ),
                  cornerRadius: Dimensions.r10,
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimensions.w12,
                      ),
                      CustomSvgAssetImage(
                        image: ImageAsset.icLeadership,
                        width: Dimensions.w25,
                        color: ColorConst.whiteColor,
                      ),
                      SizedBox(
                        width: Dimensions.w5,
                      ),
                      Text(
                        AppString.leaderboard,
                        style: fontStyleSemiBold20.copyWith(
                          color: ColorConst.whiteColor,
                          fontSize: Dimensions.sp15,
                        ),
                      ),
                      const Spacer(),
                      RotatedBox(
                        quarterTurns: 2, // Rotate by 180 degrees (2 quarters)
                        child: CustomSvgAssetImage(
                          image: ImageAsset.icBackArrowNav,
                          width: Dimensions.w30,
                          height: Dimensions.w30,
                          color: ColorConst.whiteColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.w12,
                      ),
                    ],
                  ),
                )),

            // Top Rated Conversation
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.commonPaddingForScreen)
                  .copyWith(bottom: Dimensions.h5, top: Dimensions.h12),
              child: Text(
                AppString.topRatedConversations,
                style: fontStyleBold15.copyWith(
                    color: Get.theme.colorScheme.textColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: Dimensions.h10),
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
                            vertical: Dimensions.h2,
                            horizontal: Dimensions.w18),
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
                                image:
                                    listCategoriesAndTopics[index].image ?? '',
                                width: Dimensions.w25,
                                height: Dimensions.w25,
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
                                    color: listCategoriesAndTopics[index]
                                            .isSelected
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

            // Posts
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: SampleData.samplePosts.length,
                itemBuilder: (context, index) =>
                    PostTile(model: SampleData.samplePosts[index]))
          ]),
        ));
  }
}
