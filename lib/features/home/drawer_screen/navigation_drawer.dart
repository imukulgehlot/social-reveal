import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/network/api_log_storage.dart';
import 'package:rstsocial/core/storage/preference_storage.dart';
import 'package:rstsocial/features/authentication/sign_in_screen.dart';
import 'package:rstsocial/features/home/drawer_screen/reference_guide_screen.dart';
import 'package:rstsocial/features/home/drawer_screen/settings_screen.dart';

import '../../../core/environment_setup/Environment.dart';
import '../../../core/widgets/custom_image.dart';
import '../bottom_navigation/bottom_navbar.dart';
import 'about_screen.dart';
import 'become_a_sponsor_screen.dart';
import 'my_profile_screen.dart';
import 'news_feed_screen.dart';
import 'notification_screen.dart';

List<String> nameOfScreen = [
  AppString.navigator,
  AppString.getVerified,
  AppString.newsFeed,
  AppString.referenceGuide,
  AppString.notifications,
  AppString.settings,
  AppString.about,
  AppString.logout,
  AppString.exportApiResponse
];

List<Widget> drawerScreens = [
  const MyProfileScreen(isNavigatedFromDrawer: true, isMe: true),
  const BottomNavBar(),
  BecomeASponsorScreen(isNavigatedFromDrawer: true),
  NewsFeedScreen(),
  const ReferenceGuideScreen(),
  NotificationsScreen(),
  SettingsScreen(),
  const AboutScreen(),
];

List<String> iconsList = [
  ImageAsset.icNavigator,
  ImageAsset.icSponsor,
  ImageAsset.icNewsFeed,
  ImageAsset.icReferenceGuide,
  ImageAsset.icNotification,
  ImageAsset.icSettings,
  ImageAsset.icAbout,
  ImageAsset.icLogout,
  ImageAsset.icExplore
];

RxInt selectedDrawerScreen = 1.obs;

GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

void openAppDrawer() {
  drawerScaffoldKey.currentState?.openDrawer();
}

void goToDrawerHomeTab() => selectedDrawerScreen.value = 1;

class NavigationDrawerScreen extends StatefulWidget {
  const NavigationDrawerScreen({super.key});

  @override
  NavigationDrawerScreenState createState() => NavigationDrawerScreenState();
}

class NavigationDrawerScreenState extends State<NavigationDrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: Platform.isAndroid,
      child: Drawer(
        surfaceTintColor: Get.theme.scaffoldBackgroundColor,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        width: Get.width * 0.78,
        child: buildDrawerContent(),
      ),
    );
  }

  Widget buildDrawerContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHeader(),
        Expanded(
          child: buildScreensList(),
        ),
        buildBottomAppLogo(),
      ],
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.h35,
        left: Dimensions.w20,
        bottom: Dimensions.h15,
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => onClickEvent(context, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: "wayToEditProfile",
              child: MyCircleNetworkImage(
                image:
                    "https://www.themarysue.com/wp-content/uploads/2021/02/wanda-trauma.jpg?resize=1200%2C675",
                radius: Dimensions.r35,
              ),
            ),
            SizedBox(height: Dimensions.h8),
            Text(
              'Wanda Maxiomff',
              style: fontStyleSemiBold15.apply(
                color: Get.theme.colorScheme.textColor,
              ),
            ),
            SizedBox(height: Dimensions.h10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildStatColumn('285', AppString.awardPoints),
                buildStatColumn('156', AppString.followers),
                buildStatColumn('250', AppString.followings),
                SizedBox(width: Dimensions.w20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatColumn(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: fontStyleSemiBold14.apply(
            color: Get.theme.colorScheme.textColor,
          ),
        ),
        Text(
          label,
          style: fontStyleSemiBold12.copyWith(
            color: Get.theme.colorScheme.hintTextColor,
          ),
        ),
      ],
    );
  }

  Widget buildScreensList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: nameOfScreen.length,
      itemBuilder: (context, index) => index != 8
          ? buildDrawerItem(index)
          : PreferenceStorage.getString("CurrentBuildMode") != Environment.PROD
              ? buildDrawerItem(index)
              : const SizedBox(),
    );
  }

  Widget buildDrawerItem(int index) {
    return Material(
      color: Get.theme.scaffoldBackgroundColor,
      child: InkWell(
        onTap: () => onClickEvent(context, index + 1),
        child: Container(
          decoration: BoxDecoration(
            color: selectedDrawerScreen.value == index + 1
                ? ColorConst.primaryColor
                : null,
          ),
          padding: EdgeInsets.symmetric(vertical: Dimensions.h8)
              .copyWith(right: Dimensions.w8),
          child: Row(
            children: [
              if (selectedDrawerScreen.value == index + 1)
                Container(
                  height: Dimensions.h30,
                  width: Dimensions.w4,
                  decoration: BoxDecoration(
                    color: ColorConst.whiteColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.r15),
                      bottomRight: Radius.circular(Dimensions.r15),
                    ),
                  ),
                ),
              SizedBox(
                width: selectedDrawerScreen.value == index + 1
                    ? Dimensions.w9
                    : Dimensions.w13,
              ),
              CustomSvgAssetImage(
                image: iconsList[index],
                width: Dimensions.w28,
                color: selectedDrawerScreen.value != index + 1
                    ? Get.theme.colorScheme.textColor
                    : Get.theme.scaffoldBackgroundColor,
              ),
              SizedBox(width: Dimensions.w5),
              Expanded(
                child: Text(
                  nameOfScreen[index],
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: fontStyleSemiBold14.copyWith(
                    color: selectedDrawerScreen.value != index + 1
                        ? Get.theme.colorScheme.textColor
                        : Get.theme.scaffoldBackgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomAppLogo() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w16,
          vertical: Dimensions.h10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSvgAssetImage(
              image:  Get.theme.brightness == Brightness.dark ? ImageAsset.icAppLogoLight : ImageAsset.icAppLogoDark,
              width: Dimensions.w50,
            ),
            Text(
              AppString.appVersion,
              style: fontStyleSemiBold13.copyWith(
                color: ColorConst.textGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

onClickEvent(BuildContext context, int index) {
  Get.back();

  // On Log Out Selection
  if (index == 8) {
    Get.offAll(() => SignInScreen());
    selectedDrawerScreen.value = 1;
  } else if (index == 9) {
    APILogStorage.instance.saveAPILogsToStorage();
  }
  // On Tap of Valid Screen
  else if (index != selectedDrawerScreen.value) {
    selectedDrawerScreen.value = index;
  }
}
