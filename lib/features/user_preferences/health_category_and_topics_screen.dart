import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/core_screens/location_permission_screen.dart';

import '../../core/model/ui_model/category_list_item.dart';
import '../../core/model/ui_model/category_model.dart';
import '../../core/widgets/custom_image.dart';
import '../../core/widgets/expansion_row.dart';

class HealthCategoryAndTopicsScreen extends StatefulWidget {
  const HealthCategoryAndTopicsScreen({super.key});

  @override
  HealthCategoryAndTopicsScreenState createState() =>
      HealthCategoryAndTopicsScreenState();
}

class HealthCategoryAndTopicsScreenState
    extends State<HealthCategoryAndTopicsScreen> {
  late RxList<CategoryListItem> categoryList = RxList();

  @override
  void initState() {
    categoryList = [
      CategoryListItem(
        categoryModel: [
          CommonUIModel(title: 'Friends', isSelected: false),
          CommonUIModel(title: 'Groups', isSelected: false),
          CommonUIModel(title: 'Events', isSelected: false),
          CommonUIModel(title: 'Messages', isSelected: false),
        ],
        categoryName: 'Social',
      ),
      CategoryListItem(
        categoryModel: [
          CommonUIModel(title: 'Trending', isSelected: false),
          CommonUIModel(title: 'Viral', isSelected: false),
          CommonUIModel(title: 'Popular', isSelected: false),
          CommonUIModel(title: 'Featured', isSelected: false),
        ],
        categoryName: 'Trending',
      ),
      CategoryListItem(
        categoryModel: [
          CommonUIModel(title: 'Fashion Trends', isSelected: false),
          CommonUIModel(title: 'Style Tips', isSelected: false),
          CommonUIModel(title: 'Outfit Ideas', isSelected: false),
          CommonUIModel(title: 'Shopping Deals', isSelected: false),
        ],
        categoryName: 'Fashion',
      ),
      CategoryListItem(
        categoryModel: [
          CommonUIModel(title: 'Recipes', isSelected: false),
          CommonUIModel(title: 'Cooking Tips', isSelected: false),
          CommonUIModel(title: 'Foodie Adventures', isSelected: false),
          CommonUIModel(title: 'Restaurant Reviews', isSelected: false),
        ],
        categoryName: 'Food',
      ),
      CategoryListItem(
        categoryModel: [
          CommonUIModel(title: 'Travel Guides', isSelected: false),
          CommonUIModel(title: 'Travel Tips', isSelected: false),
          CommonUIModel(title: 'Travel Stories', isSelected: false),
          CommonUIModel(title: 'Hotel Reviews', isSelected: false),
        ],
        categoryName: 'Travel',
      ),
    ].obs;



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                        image:  Get.theme.brightness == Brightness.dark ? ImageAsset.icAppLogoLight : ImageAsset.icAppLogoDark,
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
                style:
                    fontStyleSemiBold13.apply(color: ColorConst.primaryColor),
              ),
              SizedBox(
                height: Dimensions.h13,
              ),

              // User Stories
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.commonPaddingForScreen),
                child: Text(
                  AppString.pickOneOrMore,
                  textAlign: TextAlign.center,
                  style:
                      fontStyleSemiBold18.apply(color: ColorConst.primaryColor),
                ),
              ),
              SizedBox(
                height: Dimensions.h13,
              ),

              // Category List
              Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.commonPaddingForScreen),
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) => ExpansionRow(
                    title: categoryList[index].categoryName,
                    expandedWidget: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, indexTwo) => Material(
                        child: ListTile(
                          onTap: () {
                            categoryList[index]
                                    .categoryModel[indexTwo]
                                    .isSelected =
                                !categoryList[index]
                                    .categoryModel[indexTwo]
                                    .isSelected;

                            categoryList.refresh();
                          },
                          tileColor: categoryList[index]
                                  .categoryModel[indexTwo]
                                  .isSelected
                              ? ColorConst.primaryColor
                              : Get.theme.scaffoldBackgroundColor,
                          contentPadding: EdgeInsets.only(
                              left: Dimensions.w22, right: Dimensions.w24),
                          title: Text(
                            categoryList[index].categoryModel[indexTwo].title,
                            style: fontStyleSemiBold18.copyWith(
                              color: !categoryList[index]
                                      .categoryModel[indexTwo]
                                      .isSelected
                                  ? ColorConst.primaryColor
                                  : ColorConst.whiteColor,
                            ),
                          ),
                          trailing: CustomSvgAssetImage(
                            image: categoryList[index]
                                    .categoryModel[indexTwo]
                                    .isSelected
                                ? ImageAsset.icCircleFilled
                                : ImageAsset.icCircleUnfilled,
                            width: Dimensions.w30,
                            color:  categoryList[index]
                                .categoryModel[indexTwo]
                                .isSelected
                                ? ColorConst.whiteColor
                                : ColorConst.primaryColor,
                          ),
                        ),
                      ),
                      itemCount: categoryList[index].categoryModel.length,
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: Dimensions.h15,
                  ),
                ),
              ),

              // Bottom Button
              Padding(
                padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.commonPaddingForScreen)
                    .copyWith(top: Dimensions.h20),
                child: MyButton(
                  cornerRadius: Dimensions.r10,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w13, vertical: 0),
                  onPressed: () =>
                      Get.to(() => const LocationPermissionScreen()),
                  title: AppString.next,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
