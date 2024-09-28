import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/model/ui_model/sample_data.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';
import 'package:rstsocial/custom/post_tile.dart';

import '../../../../../core/model/ui_model/category_model.dart';
import '../../../../../core/widgets/text_field/text_field/search_bar_text_field.dart';
import '../../../drawer_screen/navigation_drawer.dart';
import 'create_post/create_post_main_screen.dart';

class HomeTabScreen extends StatelessWidget {
  HomeTabScreen({super.key});

  RxString selectedCategory = ''.obs;

  final healthCategories = [
    AppString.friends,
    AppString.groups,
    AppString.messages,
    AppString.trending,
    AppString.viral,
    AppString.eventsCategory,
    AppString.socialBuzz,
    AppString.love
  ].obs;

  final List<String> healthCategoriesIcons = [
    ImageAsset.icPhysical,
    ImageAsset.icLifestyle,
    ImageAsset.icDietary,
    ImageAsset.icNutritional,
    ImageAsset.icAlternateMedicine,
    ImageAsset.icExperiences,
    ImageAsset.icSpiritual,
    ImageAsset.icSocial,
  ];

  late final RxList<CommonUIModel> listCategoriesAndTopics = [
    CommonUIModel(
      title: "Friends",
      image: "ic_physical",
      isSelected: true,
      innerList: [
        CommonUIModel(title: "Friends' Posts", isSelected: false),
        CommonUIModel(title: "Travel Stories", isSelected: false),
        CommonUIModel(title: "Fitness Updates", isSelected: false),
        CommonUIModel(title: "Food Adventures", isSelected: false),
        CommonUIModel(title: "Gaming Highlights", isSelected: false),
        CommonUIModel(title: "Movie Recommends", isSelected: false),
        // Add more social-centric categories here!
      ],
    ),
    CommonUIModel(
      title: "Groups",
      image: "ic_lifestyle",
      isSelected: false,
      innerList: [
        CommonUIModel(title: "Tech Talks", isSelected: false),
        CommonUIModel(title: "Book Discussions", isSelected: false),
        CommonUIModel(title: "DIY Projects", isSelected: false),
        CommonUIModel(title: "Music Jams", isSelected: false),
        CommonUIModel(title: "Pet Stories", isSelected: false),
        // Add more group-based interests!
      ],
    ),
    CommonUIModel(
      title: "Messages",
      image: "ic_dietary",
      isSelected: false,
      innerList: [
        CommonUIModel(title: "Funny Memes", isSelected: false),
        CommonUIModel(title: "Deep Conversations", isSelected: false),
        CommonUIModel(title: "Work Updates", isSelected: false),
        CommonUIModel(title: "Travel Plans", isSelected: false),
        CommonUIModel(title: "Fitness Motivation", isSelected: false),
        // Add more messaging themes!
      ],
    ),
    CommonUIModel(
      title: "Trending",
      image: "ic_nutritional",
      isSelected: false,
      innerList: [
        CommonUIModel(title: "Health Tips", isSelected: false),
        CommonUIModel(title: "Recipe Ideas", isSelected: false),
        CommonUIModel(title: "Fashion Trends", isSelected: false),
        CommonUIModel(title: "Tech Innovations", isSelected: false),
        CommonUIModel(title: "Entertainment News", isSelected: false),
        // Add more trending topics!
      ],
    ),
    CommonUIModel(
      title: "Events",
      image: "ic_experiences",
      isSelected: false,
      innerList: [
        CommonUIModel(title: "Concerts", isSelected: false),
        CommonUIModel(title: "Workshops", isSelected: false),
        CommonUIModel(title: "Exhibitions", isSelected: false),
        CommonUIModel(title: "Meetups", isSelected: false),
        CommonUIModel(title: "Sports Events", isSelected: false),
        // Add more event categories!
      ],
    ),
    CommonUIModel(
      title: "Viral",
      image: "ic_alternate_medicine",
      isSelected: false,
      innerList: [
        CommonUIModel(title: "Viral Videos", isSelected: false),
        CommonUIModel(title: "Internet Challenges", isSelected: false),
        CommonUIModel(title: "Trending Memes", isSelected: false),
        CommonUIModel(title: "Social Experiments", isSelected: false),
        CommonUIModel(title: "Urban Legends", isSelected: false),
        // Add more viral content categories!
      ],
    ),
    CommonUIModel(
      title: "Social Buzz",
      image: "ic_spiritual",
      isSelected: false,
      innerList: [
        CommonUIModel(title: "Positive Quotes", isSelected: false),
        CommonUIModel(title: "Spiritual Insights", isSelected: false),
        CommonUIModel(title: "Motivational Stories", isSelected: false),
        CommonUIModel(title: "Daily Affirmations", isSelected: false),
        CommonUIModel(title: "Gratitude Journals", isSelected: false),
        // Add more social buzz topics!
      ],
    ),
    CommonUIModel(
      title: "Social",
      image: "ic_social",
      isSelected: false,
      innerList: [
        CommonUIModel(title: "Social Updates", isSelected: false),
        CommonUIModel(title: "Community News", isSelected: false),
        CommonUIModel(title: "Local Events", isSelected: false),
        CommonUIModel(title: "Volunteering Opportunities", isSelected: false),
        CommonUIModel(title: "Charity Initiatives", isSelected: false),
        // Add more social-related categories!
      ],
    ),
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: Dimensions.w5,
          title: Padding(
            padding: EdgeInsets.only(top: Dimensions.h5),
            child: CustomSvgAssetImage(
              image: Get.theme.brightness == Brightness.dark
                  ? ImageAsset.icAppLogoLight
                  : ImageAsset.icAppLogoDark,
              height: Dimensions.h40,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: Dimensions.w10),
            child: IconButton(
              onPressed: openAppDrawer,
              icon: CustomSvgAssetImage(
                image: ImageAsset.icDrawerIcon,
                color: Theme.of(context).colorScheme.textColor,
                width: Dimensions.w28,
              ),
            ),
          ),
          actions: [
            IconButton(
                iconSize: Dimensions.h30,
                onPressed: () => Get.to(() => const CreatePostMainScreen()),
                icon: CustomSvgAssetImage(
                  image: ImageAsset.icAddNew,
                  height: Dimensions.h30,
                  color: Theme.of(context).colorScheme.textColor,
                )),
            IconButton(
                iconSize: Dimensions.h30,
                onPressed: () => AppUtils.openCustomBottomSheet(
                    hideTopHook: true,
                    isInnerHorizontalPadding: false,
                    contentWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Color Tile
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.commonPaddingForScreen),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Title
                              Text(
                                AppString.selectCategoryAndTopics,
                                style: fontStyleSemiBold15.apply(
                                    color: Get.theme.colorScheme.textColor),
                              ),

                              // Clear All Button
                              TextButton(
                                onPressed: () {
                                  for (var element in listCategoriesAndTopics) {
                                    element.innerList?.forEach(
                                      (innerElement) =>
                                          innerElement.isSelected = false,
                                    );
                                  }

                                  for (var element in listCategoriesAndTopics) {
                                    element.innerList?.forEach((innerElement) {
                                      innerElement.isSelected = false;
                                    });
                                  }

                                  listCategoriesAndTopics.refresh();
                                },
                                child: Text(
                                  AppString.clearAll,
                                  style: fontStyleMedium14.apply(
                                      color: ColorConst.dialogRedColor),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Reason
                        Obx(
                          () => ConstrainedBox(
                            constraints:
                                BoxConstraints(maxHeight: Get.height * 0.45),
                            child: Column(
                              children: [
                                // Top List Color
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Get.theme.colorScheme
                                            .likeButtonBorderColor,
                                        height: Dimensions.h10,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: Dimensions.h10,
                                      ),
                                    ),
                                  ],
                                ),

                                // Actual Content List
                                Expanded(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          itemCount:
                                              listCategoriesAndTopics.length,
                                          itemBuilder: (context, index) =>
                                              Material(
                                            child: ListTile(
                                              dense: true,
                                              visualDensity:
                                                  const VisualDensity(
                                                      vertical: 0),
                                              selectedColor:
                                                  ColorConst.primaryColor,
                                              tileColor: Get.theme.colorScheme
                                                  .likeButtonBorderColor,
                                              splashColor: ColorConst
                                                  .primaryLightColor
                                                  .withOpacity(0.2),
                                              onTap: () {
                                                for (var element
                                                    in listCategoriesAndTopics) {
                                                  element.isSelected = false;
                                                }

                                                listCategoriesAndTopics[index]
                                                        .isSelected =
                                                    !listCategoriesAndTopics[
                                                            index]
                                                        .isSelected;
                                                listCategoriesAndTopics
                                                    .refresh();
                                              },
                                              selected:
                                                  listCategoriesAndTopics[index]
                                                      .isSelected,
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: Dimensions
                                                      .commonPaddingForScreen),
                                              leading: CustomSvgAssetImage(
                                                image: listCategoriesAndTopics[
                                                        index]
                                                    .image!,
                                                width: Dimensions.w28,
                                                height: Dimensions.w28,
                                                color: Get.theme.colorScheme
                                                    .textColor,
                                              ),
                                              horizontalTitleGap: Dimensions.w8,
                                              title: Text(
                                                listCategoriesAndTopics[index]
                                                    .title,
                                                style:
                                                    fontStyleSemiBold11.apply(
                                                        color: Get
                                                            .theme
                                                            .colorScheme
                                                            .textColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          itemCount: listCategoriesAndTopics
                                              .firstWhere((element) =>
                                                  element.isSelected == true)
                                              .innerList
                                              ?.length,
                                          itemBuilder: (context, index) {
                                            // Extracting Inner List
                                            final subCategory =
                                                listCategoriesAndTopics
                                                    .firstWhere((element) =>
                                                        element.isSelected ==
                                                        true)
                                                    .innerList!;

                                            return Material(
                                              child: ListTile(
                                                splashColor: ColorConst
                                                    .primaryLightColor
                                                    .withOpacity(0.2),
                                                onTap: () {
                                                  subCategory[index]
                                                          .isSelected =
                                                      !subCategory[index]
                                                          .isSelected;

                                                  // Refreshing Parent List
                                                  listCategoriesAndTopics
                                                      .refresh();
                                                },
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: Dimensions
                                                            .commonPaddingForScreen),
                                                leading: CustomSvgAssetImage(
                                                  image: subCategory[index]
                                                          .isSelected
                                                      ? ImageAsset
                                                          .icCircleFilled
                                                      : ImageAsset
                                                          .icCircleUnfilled,
                                                  width: Dimensions.w22,
                                                  height: Dimensions.w22,
                                                  color:
                                                      ColorConst.primaryColor,
                                                ),
                                                horizontalTitleGap:
                                                    Dimensions.w8,
                                                title: Text(
                                                  subCategory[index].title,
                                                  style:
                                                      fontStyleSemiBold11.apply(
                                                          color: Get
                                                              .theme
                                                              .colorScheme
                                                              .textColor),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                // Bottom List Color
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Get.theme.colorScheme
                                            .likeButtonBorderColor,
                                        height: Dimensions.h10,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: Dimensions.h10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Bottom Color Tile
                        SizedBox(
                          height: Dimensions.h20,
                        )
                      ],
                    ),
                    fixedBottomWidget: // Apply Button
                        MyButton(
                            onPressed: () => Get.back(),
                            cornerRadius: Dimensions.r10,
                            height: Dimensions.h32,
                            textStyle: fontStyleSemiBold14.copyWith(
                                color: Colors.white, fontSize: Dimensions.sp13),
                            title: AppString.apply)),
                icon: CustomSvgAssetImage(
                  image: ImageAsset.icRightMenuNav,
                  height: Dimensions.h30,
                  color: Theme.of(context).colorScheme.textColor,
                )),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
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

            // Categories
            SizedBox(
              height: Dimensions.h95,
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: Dimensions.h2),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: healthCategories.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? Dimensions.w10 : index.toDouble(),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        selectedCategory.value = healthCategories[index];
                        healthCategories.refresh();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w10,
                        ).copyWith(top: Dimensions.h10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: selectedCategory.value ==
                                      healthCategories[index]
                                  ? ColorConst.primaryColor
                                  : Get.theme.colorScheme.textFieldColor,
                              radius: Dimensions.w23,
                              child: CustomSvgAssetImage(
                                image: healthCategoriesIcons[index],
                                height: [0, 4, 2, 7, 6].contains(index)
                                    ? Dimensions.w25
                                    : [1].contains(index)
                                        ? Dimensions.w27
                                        : Dimensions.w32,
                                width: [0, 4, 2, 7, 6].contains(index)
                                    ? Dimensions.w25
                                    : [1].contains(index)
                                        ? Dimensions.w24
                                        : Dimensions.w32,
                                color: selectedCategory.value ==
                                        healthCategories[index]
                                    ? Get.theme.scaffoldBackgroundColor
                                    : ColorConst.primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.h10,
                            ),
                            Flexible(
                              child: Text(
                                healthCategories[index].replaceFirst(" ", "\n"),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: fontStyleRegular12.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .textColor),
                              ),
                            )
                          ],
                        ),
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
