import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';
import 'package:rstsocial/features/home/bottom_navigation/tabs/ai_search_tab/ai_search_tab.dart';
import 'package:rstsocial/features/home/bottom_navigation/tabs/chat_tab/chat_tab_screen.dart';
import 'package:rstsocial/features/home/bottom_navigation/tabs/explore_tab/explore_tab_screen.dart';
import 'package:rstsocial/features/home/bottom_navigation/tabs/home_tab/home_tab_screen.dart';
import 'package:rstsocial/features/home/bottom_navigation/tabs/yolo_tab/yolo_tab_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final RxInt selectedIndex = 0.obs;

  int lastIndex = 0;

  final List<Widget> screens = [
    HomeTabScreen(),
    ChatTabScreen(),
    const YoloTabScreen(),
    ExploreTabScreen(),
    const AiSearchTabScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        } else if (selectedIndex.value != 0) {
          selectedIndex.value = 0;
        } else {
          AppUtils.showExitPopScopePopup(context);
        }
      },
      child: Obx(
        () => Scaffold(
          bottomNavigationBar: NavigationBar(
            indicatorColor: ColorConst.primaryLightColor.withOpacity(0.4),
            selectedIndex: selectedIndex.value,
            onDestinationSelected: (int index) {
              if (index == 4) {
                Get.to(() => const AiSearchTabScreen())
                    ?.then((_) => selectedIndex.value = lastIndex);
              }

              lastIndex = selectedIndex.value;
              selectedIndex.value = index;
            },
            destinations: [
              NavigationDestination(
                  icon: selectedIndex.value == 0
                      ? CustomSvgAssetImage(
                          image: ImageAsset.icHomeFilled,
                          height: Dimensions.w30,
                          width: Dimensions.w30,
                          color: ColorConst.primaryColor,
                        )
                      : CustomSvgAssetImage(
                          image: ImageAsset.icHome,
                          height: Dimensions.w30,
                          width: Dimensions.w30,
                          color: Get.theme.colorScheme.textColor,
                        ),
                  label: AppString.home),
              NavigationDestination(
                  icon: selectedIndex.value == 1
                      ? CustomSvgAssetImage(
                          image: ImageAsset.icChatsFilled,
                          height: Dimensions.w30,
                          width: Dimensions.w30,
                    color: ColorConst.primaryColor,

                        )
                      : CustomSvgAssetImage(
                          image: ImageAsset.icChats,
                          height: Dimensions.w30,
                          width: Dimensions.w30,
                          color: Theme.of(context).colorScheme.textColor,
                        ),
                  label: AppString.chats),
              NavigationDestination(
                  icon: selectedIndex.value == 2
                      ? CustomSvgAssetImage(
                          image: ImageAsset.icYoloFilled,
                          height: Dimensions.w30,
                          width: Dimensions.w30,
                    color: ColorConst.primaryColor,

                        )
                      : CustomSvgAssetImage(
                          image: ImageAsset.icYolo,
                          height: Dimensions.w30,
                          width: Dimensions.w30,
                          color: Get.theme.colorScheme.textColor,
                        ),
                  label: AppString.newsScoop.toUpperCase().split(" ").first),
              NavigationDestination(
                  icon: selectedIndex.value == 3
                      ? CustomSvgAssetImage(
                          image: ImageAsset.icExploreFilled,
                          height: Dimensions.w30,
                          width: Dimensions.w30,
                    color: ColorConst.primaryColor,

                        )
                      : CustomSvgAssetImage(
                          image: ImageAsset.icExplore,
                          height: Dimensions.w30,
                          width: Dimensions.w30,
                          color: Get.theme.colorScheme.textColor,
                        ),
                  label: AppString.explore),
              NavigationDestination(
                  icon: selectedIndex.value == 4
                      ? CustomSvgAssetImage(
                          image: ImageAsset.icAiSearchFilled,
                          height: Dimensions.w30,
                          width: Dimensions.w30,
                    color: ColorConst.primaryColor,

                        )
                      : CustomSvgAssetImage(
                          image: ImageAsset.icAiSearch,
                          height: Dimensions.w30,
                          width: Dimensions.w30,
                          color: Get.theme.colorScheme.textColor,
                        ),
                  label: AppString.aiSearch),
            ],
          ),
          body: screens[selectedIndex.value],
        ),
      ),
    );
  }
}
