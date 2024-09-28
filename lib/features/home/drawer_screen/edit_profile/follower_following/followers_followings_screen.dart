import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../../../core/model/ui_model/category_model.dart';
import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/widgets/text_field/text_field/search_bar_text_field.dart';

class FollowersFollowingsScreen extends StatelessWidget {
  final bool isFollowerScreen;

  FollowersFollowingsScreen({super.key, required this.isFollowerScreen});

  late final RxList<CommonUIModel> listOfPeople = [
    CommonUIModel(
        title: "Joey Tribbiani",
        isSelected: true,
        image:
            "https://i.guim.co.uk/img/media/ae14333615408ab5d5ba6c23810be683e0d6f631/389_282_1481_889/master/1481.jpg?width=620&dpr=1&s=none"),
    CommonUIModel(
      title: "Rachel Green",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/women/1.jpg",
    ),
    CommonUIModel(
      title: "Ross Geller",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/men/2.jpg",
    ),
    CommonUIModel(
      title: "Monica Geller",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/women/3.jpg",
    ),
    CommonUIModel(
      title: "Chandler Bing",
      isSelected: true,
      isSelectedTwo: true,
      image: "https://randomuser.me/api/portraits/men/4.jpg",
    ),
    CommonUIModel(
      title: "Phoebe Buffay",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/women/5.jpg",
    ),
    CommonUIModel(
      title: "Joey Tribbiani",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/men/6.jpg",
    ),
    CommonUIModel(
      title: "Janice Hosenstein",
      isSelected: isFollowerScreen ? false : true,
      image: "https://randomuser.me/api/portraits/women/7.jpg",
    ),
    CommonUIModel(
      title: "Gunther",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/men/8.jpg",
    ),
    CommonUIModel(
      title: "Emily Waltham",
      isSelected: isFollowerScreen ? false : true,
      image: "https://randomuser.me/api/portraits/women/9.jpg",
    ),
    CommonUIModel(
      title: "Richard Burke",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/men/10.jpg",
    ),
    CommonUIModel(
      title: "Judy Geller",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/women/11.jpg",
    ),
    CommonUIModel(
      title: "Mike Hannigan",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/men/12.jpg",
    ),
    CommonUIModel(
      title: "Erica Bing",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/women/13.jpg",
    ),
    CommonUIModel(
        title: "Joey Tribbiani",
        isSelected: true,
        image:
            "https://i.guim.co.uk/img/media/ae14333615408ab5d5ba6c23810be683e0d6f631/389_282_1481_889/master/1481.jpg?width=620&dpr=1&s=none"),
    CommonUIModel(
      title: "Rachel Green",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/women/1.jpg",
    ),
    CommonUIModel(
      title: "Ross Geller",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/men/2.jpg",
    ),
    CommonUIModel(
      title: "Monica Geller",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/women/3.jpg",
    ),
    CommonUIModel(
      title: "Chandler Bing",
      isSelected: true,
      isSelectedTwo: true,
      image: "https://randomuser.me/api/portraits/men/4.jpg",
    ),
    CommonUIModel(
      title: "Phoebe Buffay",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/women/5.jpg",
    ),
    CommonUIModel(
      title: "Joey Tribbiani",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/men/6.jpg",
    ),
    CommonUIModel(
      title: "Janice Hosenstein",
      isSelected: isFollowerScreen ? false : true,
      image: "https://randomuser.me/api/portraits/women/7.jpg",
    ),
    CommonUIModel(
      title: "Gunther",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/men/8.jpg",
    ),
    CommonUIModel(
      title: "Emily Waltham",
      isSelected: isFollowerScreen ? false : true,
      image: "https://randomuser.me/api/portraits/women/9.jpg",
    ),
    CommonUIModel(
      title: "Richard Burke",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/men/10.jpg",
    ),
    CommonUIModel(
      title: "Judy Geller",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/women/11.jpg",
    ),
    CommonUIModel(
      title: "Mike Hannigan",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/men/12.jpg",
    ),
    CommonUIModel(
      title: "Erica Bing",
      isSelected: true,
      image: "https://randomuser.me/api/portraits/women/13.jpg",
    ),
  ].obs;

  late final searchTextController =
      Get.put(TextEditingController(), tag: "${isFollowerScreen}Follow");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isFollowerScreen ? AppString.followers : AppString.followings,
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.commonPaddingForScreen)
                .copyWith(bottom: Dimensions.h8),
            child: SearchBarTextBoxField(
              height: Dimensions.h35,
              bgColor: Theme.of(context).colorScheme.textFieldColor,
              textController: searchTextController,
              topLeftRadius: Dimensions.r20,
              topRightRadius: Dimensions.r20,
              bottomLeftRadius: Dimensions.r20,
              bottomRightRadius: Dimensions.r20,
              onChanged: (val) {},
              afterClearButton: () {},
              prefixIcon: const SizedBox(),
              hintText: AppString.searchPeople,
              hintTextColor: Theme.of(context).colorScheme.textColor,
              suffixIcon: CustomSvgAssetImage(
                image: ImageAsset.icSearch,
                height: Dimensions.w30,
                width: Dimensions.w30,
                color: Theme.of(context).colorScheme.textColor,
              ),
            ).animate(
              effects: [
                const FadeEffect(
                    begin: 0, end: 1, duration: Duration(milliseconds: 300)),
                const SlideEffect(
                    begin: Offset(0, -0.5),
                    end: Offset(0, 0),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn)
              ],
            ),
          ),

          // People List
          Obx(
            () => Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Dimensions.commonPaddingForScreen,
                      vertical: Dimensions.h4),
                  horizontalTitleGap: Dimensions.w8,
                  leading: MyCircleNetworkImage(
                    image: listOfPeople[index].image!,
                    radius: Dimensions.r22,
                  ),
                  title: Row(
                    children: [
                      // Name
                      Flexible(
                        child: Text(
                          listOfPeople[index].title.length > 15 &&
                                  listOfPeople[index].isSelectedTwo
                              ? listOfPeople[index].title.split(" ").first
                              : listOfPeople[index].title,
                          maxLines: 1,
                          style: fontStyleSemiBold13.apply(
                              color: Get.theme.colorScheme.textColor),
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.w5,
                      ),

                      // Premium Badge
                      if (listOfPeople[index].isSelectedTwo)
                        CustomSvgAssetImage(
                          image: ImageAsset.icAddBadge,
                          width: Dimensions.w16,
                          height: Dimensions.w16,
                        )
                    ],
                  ),
                  trailing: MyButton(
                    onPressed: () {
                      listOfPeople[index].isSelected =
                          !listOfPeople[index].isSelected;
                      listOfPeople.refresh();
                    },
                    cornerRadius: Dimensions.r25,
                    btnBgColor: listOfPeople[index].isSelected
                        ? ColorConst.primaryColor
                        : Get.theme.colorScheme.likeButtonBorderColor,
                    miniWidth: Dimensions.w110,
                    height: Dimensions.h32,
                    title: listOfPeople[index].isSelected
                        ? AppString.unfollow
                        : AppString.followBack,
                    textStyle: fontStyleSemiBold14.copyWith(
                        color: listOfPeople[index].isSelected
                            ? Colors.white
                            : Get.theme.colorScheme.textColor,
                        fontSize: Dimensions.sp11),
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) => Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: Dimensions.commonPaddingForScreen),
                  child: Container(
                    color: ColorConst.dividerColor,
                    height: Get.height * 0.0001,
                  ),
                ),
                itemCount: listOfPeople.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
