import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';

import '../../../core/model/ui_model/edit_into_user_story_model.dart';
import '../../../custom/animated_dot_indicator.dart';
import 'add_your_journey_screen.dart';

class UserStoriesIntroScreen extends StatelessWidget {
  UserStoriesIntroScreen({super.key});

  final PageController pageController = Get.put(PageController());
  final RxInt currentPage = RxInt(0);

  late final List<EnterIntoUserStoryModel> listEditIntoUserStory = [
    EnterIntoUserStoryModel(
      storyTitle: 'Discovering New Connections',
      storyBody: 'Today, I made a new friend on social media, and it feels like we’ve known each other for years. It’s amazing how technology can bring people together!',
    ),
    EnterIntoUserStoryModel(
      storyTitle: 'Exploring Exciting Trends',
      storyBody: 'I stumbled upon a fascinating trend on social media today and decided to join in. It’s so much fun being part of a larger community!',
    ),
    EnterIntoUserStoryModel(
      storyTitle: 'Sharing My Creative Journey',
      storyBody: 'I shared my latest artwork on social media, and the response has been incredible. It feels great to share my passion with others!',
    ),
    EnterIntoUserStoryModel(
      storyTitle: 'Finding Inspiration Everywhere',
      storyBody: 'I love how social media exposes me to new ideas and perspectives. It’s like having a window to the world right in my pocket!',
    ),
    EnterIntoUserStoryModel(
      storyTitle: 'Embracing Diversity',
      storyBody: 'Social media has introduced me to people from all walks of life, and I’m grateful for the opportunity to learn from their experiences and cultures.',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
              style: fontStyleSemiBold13.apply(color: ColorConst.primaryColor),
            ),
            SizedBox(
              height: Dimensions.h13,
            ),

            // Pick One Category
            Text(
              AppString.userStories,
              style: fontStyleSemiBold21.apply(color: ColorConst.primaryColor),
            ),
            SizedBox(
              height: Dimensions.h13,
            ),

            // Story Template
            Container(
              width: Get.width,
              height: Get.height * 0.45,
              margin: EdgeInsets.all(Dimensions.w20),
              padding: EdgeInsets.only(
                top: Dimensions.w20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.r8),
                // color: ColorConst.primaryLightColor,
                color: Get.theme.colorScheme.textFieldColor,
              ),
              child: Column(
                children: [
                  Flexible(
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: listEditIntoUserStory.length,
                      itemBuilder: (context, index) => EditIntoStory(
                          storyBody: listEditIntoUserStory[index].storyBody,
                          storyTitle: listEditIntoUserStory[index].storyTitle),
                      onPageChanged: (int page) {
                        currentPage.value = page;
                      },
                      controller: pageController,
                    ),
                  ),

                  // Edit into my story
                  TextButton(
                    onPressed: () => Get.to(() => AddYourJourneyScreen(
                          title: listEditIntoUserStory[currentPage.value]
                              .storyTitle,
                          storyText: listEditIntoUserStory[currentPage.value]
                              .storyBody,
                        )),
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Dimensions.r15))),
                    child: Text(
                      AppString.editIntoMyStory,
                      textAlign: TextAlign.center,
                      style: fontStyleSemiBold16.copyWith(
                          color: ColorConst.primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.h30,
                  ),
                ],
              ),
            ),

            // Animated Selection Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => AnimatedDotIndicator(
                    smallWidth: Dimensions.w8,
                    maxWidth: Dimensions.w30,
                    currentIndex: currentPage.value,
                    length: listEditIntoUserStory.length,
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen,
                  vertical: Get.height * 0.10),
              child: MyButton(
                onPressed: () => Get.to(() => AddYourJourneyScreen()),
                title: AppString.startMyOwnStory,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class EditIntoStory extends StatelessWidget {
  final String storyTitle;
  final String storyBody;

  const EditIntoStory(
      {super.key, required this.storyTitle, required this.storyBody});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.h20),
      child: Column(
        children: [
          // Sample Title
          Padding(
            padding:
                EdgeInsets.only(top: Dimensions.h10, bottom: Dimensions.h10),
            child: Text(
              storyTitle,
              style: fontStyleSemiBold14.apply(
                  color: Get.theme.colorScheme.textColor),
            ),
          ),

          // Sample Story
          Text(
            storyBody,
            textAlign: TextAlign.center,
            maxLines: 7,
            overflow: TextOverflow.ellipsis,
            style: fontStyleRegular12.copyWith(
                color: Get.theme.colorScheme.textColor),
          ),
          SizedBox(
            width: Dimensions.w10,
            height: Dimensions.h10,
          ),
        ],
      ),
    );
  }
}
