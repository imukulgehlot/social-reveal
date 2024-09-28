import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../core/widgets/custom_image.dart';
import 'navigation_drawer.dart';

class BecomeASponsorScreen extends StatelessWidget {
  final bool isNavigatedFromDrawer;

  BecomeASponsorScreen({super.key, this.isNavigatedFromDrawer = false});

  final listNonEligibilityReason = [
    AppString.sponsorEligibiltyRuleOne,
    AppString.sponsorEligibiltyRuleTwo,
    AppString.sponsorEligibiltyRuleThree,
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
            AppString.getVerified,
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
            onPressed: () =>
                isNavigatedFromDrawer ? goToDrawerHomeTab() : Get.back(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
            child: Column(
              children: [
                // Content Image
                CustomSvgAssetImage(
                  image: ImageAsset.icBecomeASponsor,
                  height: Dimensions.h300,
                ),
                // Rich Text
                Text(
                  AppString.getVerified,
                  style: fontStyleBold20.apply(color: ColorConst.primaryColor),
                ),
                Text(
                  AppString.verifiedUser,
                  style: fontStyleRegular12.apply(
                      color: Theme.of(context).colorScheme.textColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Dimensions.h40,
                ),
                MyButton(
                  onPressed: () => AppUtils.showCustomDialog(
                      icon: ImageAsset.icDialogueQuestion,
                      title: AppString.notEligibleYet,
                      mergeDefaultWithContent: true,
                      myWidget: Padding(
                        padding: EdgeInsets.only(top: Dimensions.h5),
                        child: Column(
                            children: listNonEligibilityReason
                                .map((e) => ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      visualDensity: const VisualDensity(
                                          vertical:
                                              VisualDensity.minimumDensity),
                                      horizontalTitleGap: Dimensions.w8,
                                      leading: CustomSvgAssetImage(
                                        image: ImageAsset.icDialogueChecked,
                                        width: Dimensions.w30,
                                        height: Dimensions.w30,
                                      ),
                                      title: Text(
                                        e,
                                        style: fontStyleRegular12.copyWith(
                                          height: 1.30,
                                          color:
                                              Get.theme.colorScheme.textColor,
                                        ),
                                      ),
                                    ))
                                .toList()),
                      ),
                      contentText: AppString.notEligibleBody),
                  title: AppString.continueToGetVerifiedAccount,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
