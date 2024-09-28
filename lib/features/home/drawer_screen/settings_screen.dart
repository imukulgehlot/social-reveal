import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';
import 'package:rstsocial/custom/settings_list_tile.dart';
import 'package:rstsocial/features/home/drawer_screen/settings/help_center_screen.dart';

import '../../authentication/sign_in_screen.dart';
import '../../user_preferences/user_preferences_main_screen.dart';
import 'navigation_drawer.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final List<Map<String, dynamic>> settingsList = [
    {
      "title": AppString.helpCenter,
      "icon": ImageAsset.icHelpCenter,
      "onTap": () => Get.to(() => const HelpCenterScreen()),
    },
    {"title": 'Privacy Policy', "icon": ImageAsset.icEditPen, "onTap": () {}},
    {
      "title": 'Delete Account',
      "icon": ImageAsset.icDelete,
      "onTap": () => AppUtils.showCustomDialog(
          icon: ImageAsset.icDialogueQuestion,
          title: AppString.areYouSure,
          contentText: AppString.areYouSureDeleteAccount,
          firstButtonText: AppString.noDoNotDelete,
          secondButtonFunction: () => AppUtils.showCustomDialog(
              icon: ImageAsset.icDialogueChecked,
              title: AppString.sorryToSeeYouGo,
              contentText: AppString.accountDeleteSuccessNote,
              onDialogCloseFunction: () {
                selectedDrawerScreen.value = 1;
                Get.offAll(() => SignInScreen());
              }),
          secondButtonText: AppString.yesDeleteAccount)
    },
    {
      "title": 'Logout',
      "icon": ImageAsset.icLogout,
      "onTap": () => AppUtils.showCustomDialog(
          icon: ImageAsset.icDialogueQuestion,
          title: AppString.areYouSure,
          contentText: AppString.areYouSureLogout,
          firstButtonFunction: () {
            selectedDrawerScreen.value = 1;
            Get.off(() => SignInScreen());
          },
          firstButtonText: AppString.yesLogout,
          secondButtonText: AppString.cancel)
    }
  ];

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
            AppString.settings,
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
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.h15),
          child: Column(
            children: [
              SettingsListTile(
                  title: "Feed Preference",
                  onTap: () => Get.to(() => UserPreferencesMainScreen()),
                  subTitle: "Customize your feed preference."),
              SettingsListTile(
                title: "Notification",
                subTitle: "Set enable or disable notification",
                currentValue: false.obs,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
                    child: GestureDetector(
                      // borderRadius: BorderRadius.circular(Dimensions.r15),
                      onTap: () => settingsList[index]["onTap"].call(),
                      child: Row(
                        children: [
                          CustomSvgAssetImage(
                            image: settingsList[index]['icon'],
                            width: Dimensions.w30,
                            height: Dimensions.w30,
                            color: Get.theme.colorScheme.textColor,
                          ),
                          SizedBox(
                            width: Dimensions.w10,
                          ),
                          Text(
                            settingsList[index]['title'],
                            style: fontStyleSemiBold16.copyWith(
                              color: Get.theme.colorScheme.textColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: settingsList.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}
