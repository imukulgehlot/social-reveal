import 'dart:math' as math;

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../core/model/ui_model/category_model.dart';
import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/text_field/text_field/search_bar_text_field.dart';
import '../bottom_navigation/tabs/home_tab/create_post/create_post_main_screen.dart';
import 'navigation_drawer.dart';

class ReferenceGuideScreen extends StatefulWidget {
  const ReferenceGuideScreen({super.key});

  @override
  State<ReferenceGuideScreen> createState() => _ReferenceGuideScreenState();
}

class _ReferenceGuideScreenState extends State<ReferenceGuideScreen> {
  late final ValueChanged<String> onClickedItem;
  List<ContactList> items = [];

  List<String> contactNames = [
    // Friends
    'Rachel Green',
    'Monica Geller',
    'Phoebe Buffy',
    'Joey Tribbiani',
    'Chandler Bing',
    'Ross Geller',
    'Janice Eisenstein',
    'Gunther Central Perk',
    'Ursula Buffy',
    'Jack Geller',
    'Judy Geller',
    'Ben Geller',
    'Emma Geller-Greene',

    // Stranger Things
    'Eleven',
    'Mike Wheeler',
    'Dustin Henderson',
    'Lucas Sinclair',
    'Will Byers',
    'Max Mayfield',
    'Jim Hopper',
    'Joyce Byers',
    'Jonathan Byers',
    'Steve Harrington',
    'Nancy Wheeler',
    'Dr. Martin Brenner',
    'Chief David O\'Donnell',
    'The Demo gorgon',
    'The Mind Flayer',

    // Marvel Movies
    'Iron Man (Tony Stark)',
    'Captain America (Steve Rogers)',
    'Thor (Odin-son)',
    'Hulk (Bruce Banner)',
    'Black Widow (Natasha Romano)',
    'Spider-Man (Peter Parker)',
    'Doctor Strange (Stephen Strange)',
    'Ant-Man (Scott Lang)',
    'Wasp (Hope Pym)',
    'Falcon (Sam Wilson)',
    'Winter Soldier (Bucky Barnes)',
    'Scarlet Witch (Wanda Maximoff)',
    'Quicksilver (Pietro Maximoff)',
    'Vision',
    'Black Panther (T\'Challah)',
    'Star-Lord (Peter Quill)',
    'Zamora',
    'Drag the Destroyer',
    'Rocket Raccoon',
    'Groot',
    'Thanos',
    'Captain Marvel (Carol Dancers)',
    'Loki',
    'Hawker (Clint Barton)',
    'Nick Fury',
    'Maria Hill',
    'Phil Colson',
  ];

  late final RxList<CommonUIModel> listCategoriesAndTopics = [
    CommonUIModel(title: "Exercise", isSelected: false),
    CommonUIModel(title: "Bodywork Therapies", isSelected: false),
    CommonUIModel(title: "Cardiovascular aerobic exercise", isSelected: false),
    CommonUIModel(title: "Chiropractic or Massage", isSelected: false),
    CommonUIModel(title: "Strength or Resistance Training", isSelected: false),
    CommonUIModel(title: "Acupuncture or Shiatsu  ", isSelected: false),
    CommonUIModel(title: "Stretching", isSelected: false),
    CommonUIModel(title: "General", isSelected: false),
    CommonUIModel(title: "Meow", isSelected: false),
    CommonUIModel(title: "Bodywork Therapies", isSelected: false),
    CommonUIModel(title: "Cardiovascular aerobic exercise", isSelected: false),
    CommonUIModel(title: "Chiropractic or Massage", isSelected: false),
    CommonUIModel(title: "Strength or Resistance Training", isSelected: false),
    CommonUIModel(title: "Acupuncture or Shiatsu  ", isSelected: false),
    CommonUIModel(title: "Stretching", isSelected: false),
    CommonUIModel(title: "General", isSelected: false),
  ].obs;

  List<String> getSortedFirstCharacters(List<CommonUIModel> categories) {
    // Extracting unique first characters and sorting alphabetically
    List<String> sortedFirstCharacters = categories
        .map((element) => element.title[0])
        .toSet() // Removing duplicates
        .toList()
      ..sort(); // Sorting the list in-place

    return sortedFirstCharacters;
  }

  double calculateIndexBarItemHeight(int totalItems) {
    // Set a base height and adjust it based on the total number of items
    double baseHeight = Get.height / Dimensions.h31;
    double adjustedHeight = baseHeight / totalItems;

    // Ensure a minimum height to avoid being too small
    double minHeight = Get.height / Dimensions.h50;
    return adjustedHeight > minHeight ? adjustedHeight : minHeight;
  }

  @override
  void initState() {
    super.initState();

    initList(contactNames);
  }

  // late ItemPositionsListener haha;

  void initList(List<String> contactNames) {
    items = contactNames.map((e) {
      return ContactList(e, e[0]);
    }).toList();
    SuspensionUtil.sortListBySuspensionTag(items);
    SuspensionUtil.setShowSuspensionStatus(items);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          goToDrawerHomeTab();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppString.referenceGuide,
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
              onPressed: goToDrawerHomeTab,
            ),
            actions: [
              IconButton(
                iconSize: Dimensions.h30,
                onPressed: () => Get.to(() => const CreatePostMainScreen()),
                icon: CustomSvgAssetImage(
                  image: ImageAsset.icAddNew,
                  height: Dimensions.h30,
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
                    horizontal: Dimensions.commonPaddingForScreen),
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
                  hintText: AppString.searchKeyword,
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
          body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.h10, horizontal: Dimensions.w5),
            child: Column(
              children: [
                // Top Selection Panel
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.h10,
                      horizontal: Dimensions.commonPaddingForScreen),
                  clipBehavior: Clip.none,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      InkWell(
                        onTap: () => AppUtils.openCustomBottomSheet(
                            hideTopHook: true,
                            isInnerHorizontalPadding: false,
                            contentWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Heading & Clear All
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.commonPaddingForScreen),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Title
                                      Text(
                                        AppString.selectCategoryAndTopics,
                                        style: fontStyleSemiBold15.apply(
                                            color: Get
                                                .theme.colorScheme.textColor),
                                      ),

                                      // Clear All Button
                                      TextButton(
                                        onPressed: () {
                                          for (var element
                                              in listCategoriesAndTopics) {
                                            element.isSelected = false;
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

                                // Topics
                                Obx(
                                  () => ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight: Get.height * 0.60),
                                    child: Column(
                                      children: [
                                        // Actual Content List
                                        Flexible(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            itemCount:
                                                listCategoriesAndTopics.length,
                                            itemBuilder: (context, index) {
                                              // Extracting Inner List
                                              final categoryItem =
                                                  listCategoriesAndTopics[
                                                      index];

                                              return Material(
                                                child: ListTile(
                                                  splashColor: ColorConst
                                                      .primaryLightColor
                                                      .withOpacity(0.2),
                                                  onTap: () {
                                                    categoryItem.isSelected =
                                                        !categoryItem
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
                                                    image: categoryItem
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
                                                    categoryItem.title,
                                                    style: fontStyleSemiBold11
                                                        .apply(
                                                            color: Get
                                                                .theme
                                                                .colorScheme
                                                                .textColor),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            fixedBottomWidget: // Apply Button
                                MyButton(
                                    onPressed: () => Get.back(),
                                    cornerRadius: Dimensions.r10,
                                    height: Dimensions.h32,
                                    textStyle: fontStyleSemiBold14.copyWith(
                                        color: Colors.white,
                                        fontSize: Dimensions.sp13),
                                    title: AppString.apply)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.w15,
                              vertical: Dimensions.h5),
                          decoration: BoxDecoration(
                              color:
                                  Get.theme.colorScheme.likeButtonBorderColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.r40)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nutrition",
                                style: fontStyleSemiBold11.apply(
                                    color: Get.theme.colorScheme.textColor),
                              ),
                              SizedBox(
                                width: Dimensions.w8,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: Dimensions.w20,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Expanded(
                  child: AzListView(
                      physics: const BouncingScrollPhysics(),
                      data: items,
                      indexBarOptions: IndexBarOptions(
                        needRebuild: true,
                        ignoreDragCancel: true,
                        downDecoration: BoxDecoration(
                          color: Get.theme.colorScheme.likeButtonBorderColor,
                          borderRadius: BorderRadius.circular(Dimensions.r40),
                        ),

                        indexHintAlignment: Alignment.centerRight,

                        selectTextStyle: fontStyleBold10.copyWith(
                            color: ColorConst.primaryColor),

                        // INDEX BAR BACKGROUND
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.likeButtonBorderColor,
                          borderRadius: BorderRadius.circular(Dimensions.r40),
                        ),
                        selectItemDecoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.transparent),
                        textStyle: fontStyleBold10.apply(
                            color: Get.theme.colorScheme.hintTextColor),
                      ),
                      indexBarItemHeight: Get.height / Dimensions.h40,
                      indexBarHeight:
                          MediaQuery.of(context).viewInsets.bottom == 0
                              ? Dimensions.h400
                              : 0,
                      // indexBarData: getSortedFirstCharacters(listCategoriesAndTopics),
                      indexBarData: const [
                        "A",
                        "B",
                        "C",
                        "D",
                        "E",
                        "F",
                        "G",
                        "H",
                        "I",
                        "J",
                        "K",
                        "L",
                        "M",
                        "N",
                        "O",
                        "P",
                        "Q",
                        "R",
                        "S",
                        "T",
                        "U",
                        "V",
                        "W",
                        "X",
                        "Y",
                        "Z"
                      ],
                      indexBarMargin: EdgeInsets.only(
                          right: Dimensions.w10, bottom: Dimensions.h20),
                      indexBarWidth: Dimensions.w20,
                      // INDEX HINT BOX
                      indexHintBuilder: (context, tag) => Container(
                            height: Dimensions.w50,
                            width: Dimensions.w50,
                            transform: Matrix4.rotationZ(45 * (math.pi / 180)),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                color: ColorConst.primaryColor,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(Dimensions.r25),
                                  topLeft: Radius.circular(Dimensions.r25),
                                  bottomLeft: Radius.circular(Dimensions.r25),
                                )),
                            child: Center(
                              child: Transform.rotate(
                                angle: -(45 * (math.pi / 180)),
                                child: Text(
                                  tag,
                                  style: fontStyleRegular14.apply(
                                      color: Get.theme.scaffoldBackgroundColor),
                                ),
                              ),
                            ),
                          ),
                      indexBarAlignment: Alignment.topRight,
                      itemCount: items.length,
                      itemBuilder: (context, index) => _buildItemList(index)),
                ),
              ],
            ),
          )),
    );
  }

  // Item
  Widget _buildItemList(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Offstage(
            offstage: !items[index].isShowSuspension,
            child: Text(
              items[index].getSuspensionTag(),
              style: fontStyleBold18.apply(color: ColorConst.primaryColor),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(Dimensions.r10),
            splashColor: ColorConst.primaryColor.withOpacity(0.2),
            onTap: () {},
            child: Container(
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
              child: Text(
                items[index].title,
                style: fontStyleMedium17.apply(
                    color: Get.theme.colorScheme.textColor),
              ),
            ),
          ),

          // JOHN CENA
          const Divider(
            color: ColorConst.signInModeButtonColor,
            height: 0.0,
            thickness: 0.3,
          )
        ],
      ),
    );
  }
}

class ContactList extends ISuspensionBean {
  final String title;
  final String tag;

  ContactList(this.title, this.tag);

  @override
  String getSuspensionTag() => tag;
}
