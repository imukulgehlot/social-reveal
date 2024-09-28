import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';
import 'package:rstsocial/core/widgets/custom_rich_text_widget.dart';
import 'package:rstsocial/features/user_preferences/pick_expertise/pick_expertise_screen.dart';

import 'health_category_and_topics_screen.dart';
import 'health_journey_story/user_stories_intro_screen.dart';

class UserPreferencesMainScreen extends StatelessWidget {
  UserPreferencesMainScreen({super.key});

  final List<String> names = [
    "I am new to connecting with friends, bring me in",
    "I have a story to share",
    "News Scoop",
    "I am a social media enthusiast",
    "Just Browse Conversations"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
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
                    image: ImageAsset.icAppIconWithTagline,
                    color: ColorConst.primaryColor,
                    width: Dimensions.w180,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.h20,
          ),

          // Tagline
          // Text(
          //   AppString.friendsWithHealthBenefits,
          //   style: fontStyleSemiBold13.apply(color: ColorConst.primaryColor),
          // ),
          // SizedBox(
          //   height: Dimensions.h13,
          // ),

          // User Stories
          Text(
            AppString.iAmHereBecause,
            style: fontStyleSemiBold21.apply(color: ColorConst.primaryColor),
          ),
          SizedBox(
            height: Dimensions.h13,
          ),

          // Reasons
          Flexible(
              child: ListView.separated(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: names.length,
            itemBuilder: (context, index) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(Dimensions.h10),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.h15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.h10),
                        border: Border.all(
                            color: ColorConst.primaryColor,
                            width: Dimensions.h2)),
                    width: Get.width - Dimensions.w30,
                    child: /* index == 0
                        ? CustomRichTextWidget.getDualText(
                            firstText: names[index],
                            secondText: '“myhealthysocial”',
                            firstTextStyle: fontStyleSemiBold16.copyWith(
                                color: ColorConst.primaryColor),
                            secondTextStyle: fontStyleBold16.copyWith(
                                color: ColorConst.primaryColor))
                        :*/
                        Text(names[index],
                            textAlign: TextAlign.center,
                            style: fontStyleSemiBold16.copyWith(
                                color: ColorConst.primaryColor)),
                  ),
                  onTap: () => navigateTo(index),
                )
              ],
            ),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: Dimensions.h20,
              );
            },
          )),
        ]),
      ),
    );
  }

  navigateTo(int index) {
    switch (index) {
      case 0:
        Get.to(() => const HealthCategoryAndTopicsScreen());
      case 1:
        Get.to(() => UserStoriesIntroScreen());
      case 2:
        Get.to(() => const HealthCategoryAndTopicsScreen());
      // Get.to(() => const LocationPermissionScreen());
      case 3:
        AppUtils.showSnackBar(message: AppString.underDevelopmentText, isSuccess: true , title: 'Not Now');
        // Get.to(() => PickExpertiseScreen());
      case 4:
        Get.to(() => const HealthCategoryAndTopicsScreen());
    }
  }
}
