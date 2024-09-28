import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';

import '../../custom/animated_dot_indicator.dart';
import '../../custom/onboarding_content_page.dart';
import '../user_preferences/user_preferences_main_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final PageController pageController =
      Get.put(PageController(keepPage: false));

  final RxInt currentPage = RxInt(0);
  final RxBool showFirstPageAnimation = false.obs;

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) {
            return;
          }
          goToPrevPage();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: CustomSvgAssetImage(
                image: ImageAsset.icBackArrowNav,
                width: Dimensions.w28,
                height: Dimensions.h28,
                color: Theme.of(context).colorScheme.textColor,
              ),
              onPressed: goToPrevPage,
            ),
            actions: [
              Obx(
                () => currentPage.value <= 1
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                              onPressed: navigateToPreferenceScreen,
                              child: Text(
                                AppString.skip,
                                style: fontStyleSemiBold15.apply(
                                    color: ColorConst.primaryColor),
                              )),
                          SizedBox(
                            width: Dimensions.w5,
                          )
                        ],
                      )
                    : const SizedBox(),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Pages
                  Container(
                    padding: EdgeInsets.only(top: Dimensions.h25),
                    height: Dimensions.screenHeight() * 0.70,
                    child: Obx(
                      () => PageView(
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (int page) {
                          currentPage.value = page;
                        },
                        controller: pageController,
                        children: [
                          OnBoardingContent(
                              showAnimation: showFirstPageAnimation.value,
                              text1: AppString.onboarding1Title,
                              text2: AppString.socialMediaExclamation,
                              image: ImageAsset.icOnboarding1),
                          const OnBoardingContent(
                              text1: AppString.onboarding2Title,
                              text2: AppString.connectDeeplyExclamation,
                              image: ImageAsset.icOnboarding2),
                          const OnBoardingContent(
                              text1: AppString.onboarding3Title,
                              text2: AppString.possibilitiesExclamation,
                              image: ImageAsset.icOnboarding3)
                        ],
                      ),
                    ),
                  ),

                  // Dots & Next Button
                  Padding(
                    padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.commonPaddingForScreen)
                        .copyWith(bottom: Dimensions.h40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Indicator Dots
                        Obx(
                          () => AnimatedDotIndicator(
                            currentIndex: currentPage.value,
                            length: 3,
                          ),
                        ),



                        // Next Button
                        Hero(
                          tag: "signInToIntro",
                          child: MyButton(
                            cornerRadius: Dimensions.r10,
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.w13, vertical: 0),
                            miniWidth: Dimensions.w110,
                            height: Dimensions.h30,
                            onPressed: nextPage,
                            title: null,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppString.next,
                                    style: fontStyleSemiBold13.apply(
                                        color: Colors.white),
                                  ),
                                  CustomSvgAssetImage(
                                    image: ImageAsset.icNextArrowButton,
                                    width: Dimensions.w25,
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        ));
  }

  void changePage(int pageNum) {
    currentPage.value = pageNum;

    pageController.animateToPage(
      pageNum,
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  goToPrevPage() {
    if (currentPage.value == 0) {
      Get.back();
    } else {
      currentPage.value--;
      if (currentPage.value == 0) {
        showFirstPageAnimation.value = true;
      }
      pageController.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
  }

  void nextPage() {
    if (currentPage.value <= 1) {
      changePage(currentPage.value + 1);
    } else {
      navigateToPreferenceScreen();
    }
  }

  void navigateToPreferenceScreen() {
    Get.to(() => UserPreferencesMainScreen());
  }
}
