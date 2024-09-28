import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/widgets/text_field/text_field/search_bar_text_field.dart';

class AiSearchTabScreen extends StatelessWidget {
  const AiSearchTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.aiSearch,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height - kBottomNavigationBarHeight - kToolbarHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.w15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  CustomSvgAssetImage(
                      image: Get.theme.brightness == Brightness.light
                          ? ImageAsset.icAiBulbLight
                          : ImageAsset.icAiBulbDark),
                  Text(
                    AppString.welcomeToAIPowered,
                    style: fontStyleBold18.apply(
                        color: Get.theme.colorScheme.textColor),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    AppString.enterYourAiSearch,
                    style: fontStyleRegular12.apply(
                        color: Get.theme.colorScheme.textColor),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w5, vertical: Dimensions.h25),
                    child: SearchBarTextBoxField(
                      height: Dimensions.h38,
                      bgColor: Theme.of(context).colorScheme.textFieldColor,
                      textController: Get.put(TextEditingController()),
                      topLeftRadius: Dimensions.r15,
                      topRightRadius: Dimensions.r15,
                      bottomLeftRadius: Dimensions.r15,
                      bottomRightRadius: Dimensions.r15,
                      onChanged: (val) {},
                      afterClearButton: () {},
                      prefixIcon: const SizedBox(),
                      hintText: AppString.enterYourQuestionHere,
                      hintTextColor: Theme.of(context).colorScheme.textColor,
                      suffixIcon: CustomSvgAssetImage(
                        image: ImageAsset.icSearch,
                        height: Dimensions.h25,
                        width: Dimensions.h25,
                        color: Theme.of(context).colorScheme.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
