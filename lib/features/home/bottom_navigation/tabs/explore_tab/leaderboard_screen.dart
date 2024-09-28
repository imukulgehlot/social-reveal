import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../../../core/model/ui_model/category_model.dart';
import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/widgets/text_field/text_field/search_bar_text_field.dart';
import '../../../drawer_screen/my_profile_screen.dart';
import 'award_points_criteria.dart';

class LeaderBoardScreen extends StatelessWidget {
  LeaderBoardScreen({super.key});

  late final RxList<CommonUIModel> listCategoriesAndTopics = [
    CommonUIModel(
      title: AppString.happy,
      image: ImageAsset.icCaringReact,
      isSelected: true,
    ),
    CommonUIModel(
      title: AppString.laugh,
      image: ImageAsset.icInnovatorReact,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.cry,
      image: ImageAsset.icUtilityReact,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.socialBuzz,
      image: ImageAsset.icSpiritual,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.stories,
      image: ImageAsset.icCaringReact,
      isSelected: false,
    ),
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.leaderboard,
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
        actions: [
          IconButton(
            iconSize: Dimensions.h30,
            onPressed: () => Get.to(() => AwardsPointsCriteriaScreen()),
            icon: CustomSvgAssetImage(
              image: ImageAsset.icInfo,
              height: Dimensions.h20,
              color: Theme.of(context).colorScheme.textColor,
            ),
          ),
          SizedBox(
            width: Dimensions.w8,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.h45),
          child: Padding(
            padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.commonPaddingForScreen)
                .copyWith(bottom: Dimensions.h5),
            child: SearchBarTextBoxField(
              height: Dimensions.h35,
              bgColor: Theme.of(context).colorScheme.textFieldColor,
              textController: Get.put(TextEditingController()),
              topLeftRadius: Dimensions.r15,
              topRightRadius: Dimensions.r15,
              bottomLeftRadius: Dimensions.r15,
              bottomRightRadius: Dimensions.r15,
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
        ),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Location Button
          Padding(
            padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.commonPaddingForScreen)
                .copyWith(top: Dimensions.h12, bottom: Dimensions.h5),
            child: MyButton(
              padding: EdgeInsets.zero,
              height: Dimensions.h40,
              onPressed: () {},
              cornerRadius: Dimensions.r10,
              child: Row(
                children: [
                  SizedBox(
                    width: Dimensions.w12,
                  ),
                  CustomSvgAssetImage(
                    image: ImageAsset.icLocation,
                    width: Dimensions.w25,
                    color: ColorConst.whiteColor,
                  ),
                  SizedBox(
                    width: Dimensions.w5,
                  ),
                  Text(
                    "New York City, USA",
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
            ),
          ),

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
                              // color: listCategoriesAndTopics[index].isSelected
                              //     ? ColorConst.whiteColor
                              //     : Get.theme.colorScheme.textColor,
                            ),
                            SizedBox(
                              width: Dimensions.w5,
                            ),

                            // Category Name
                            Text(
                              listCategoriesAndTopics[index].title,
                              style: fontStyleBold13.apply(
                                  color:
                                      listCategoriesAndTopics[index].isSelected
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

          // Points Card
          Container(
            margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.commonPaddingForScreen)
                .copyWith(top: Dimensions.h10, bottom: Dimensions.h5),
            padding: EdgeInsets.all(Dimensions.w15),
            decoration: BoxDecoration(
                color: Get.theme.colorScheme.textFieldColor,
                borderRadius: BorderRadius.circular(Dimensions.r12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Points
                SizedBox(
                  width: Dimensions.w10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "34",
                      style: fontStyleSemiBold30.copyWith(
                          fontSize: Dimensions.sp31,
                          color: ColorConst.primaryColor),
                    ),
                    Text(
                      "Points",
                      style: fontStyleSemiBold15.apply(
                          color: Get.theme.colorScheme.textColor),
                    ),
                  ],
                ),
                const Spacer(),

                // Profile Picture, Name & Position
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Profile Picture
                    MyCircleNetworkImage(
                      image:
                          "https://www.themarysue.com/wp-content/uploads/2021/02/wanda-trauma.jpg?resize=1200%2C675",
                      radius: Dimensions.r25,
                    ),

                    SizedBox(height: Dimensions.h8),
                    Text(
                      "Wanda Witch",
                      style: fontStyleSemiBold14.apply(
                          color: Get.theme.colorScheme.textColor),
                    ),
                    Text(
                      "${AppString.position}3",
                      style: fontStyleSemiBold11.apply(
                          color: Get.theme.colorScheme.hintTextColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Caring Points Leader
          Padding(
            padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.commonPaddingForScreen)
                .copyWith(top: Dimensions.h12),
            child: Text(
              AppString.caringPointsLeader,
              style: fontStyleBold15.copyWith(
                  color: Get.theme.colorScheme.textColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: Dimensions.h10),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Get.to(() => const MyProfileScreen(isMe: false)),
                child: Container(
                  margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.commonPaddingForScreen)
                      .copyWith(top: Dimensions.h10),
                  padding: EdgeInsets.all(Dimensions.w15),
                  decoration: BoxDecoration(
                      color: Get.theme.colorScheme.textFieldColor,
                      borderRadius: BorderRadius.circular(Dimensions.r12)),
                  child: Row(children: [
                    // Points
                    Text(
                      "#0${index + 1}",
                      style: fontStyleSemiBold15.apply(
                          color: Get.theme.colorScheme.textColor),
                    ),
                    const Spacer(flex: 1),

                    // Profile Picture
                    MyCircleNetworkImage(
                      image:
                          "https://www.themarysue.com/wp-content/uploads/2021/02/wanda-trauma.jpg?resize=1200%2C675",
                      radius: Dimensions.r28,
                    ),

                    const Spacer(flex: 1),

                    // Name, Awards point
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Wanda Witch",
                          style: fontStyleSemiBold14.apply(
                              color: Get.theme.colorScheme.textColor),
                        ),
                        Text(
                          "Awards Point : 32",
                          style: fontStyleSemiBold11.apply(
                              color: Get.theme.colorScheme.hintTextColor),
                        ),
                        Text(
                          "New York, USA",
                          style: fontStyleSemiBold11.apply(
                              color: Get.theme.colorScheme.hintTextColor),
                        ),
                      ],
                    ),

                    const Spacer(flex: 3),
                    // Liked
                    Column(
                      children: [
                        CustomSvgAssetImage(
                          image: ImageAsset.icLike,
                          height: Dimensions.w30,
                          color: ColorConst.greenLikeColor,
                          width: Dimensions.w30,
                          // color: Colors.white,
                        ),
                        Text(
                          "422",
                          style: fontStyleSemiBold12.apply(
                              color: ColorConst.greenLikeColor),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
