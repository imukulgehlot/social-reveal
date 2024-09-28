import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';

import 'navigation_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
          titleSpacing: Dimensions.w5,
          title: Text(
            AppString.about,
            style: fontStyleSemiBold15.copyWith(
                color: Get.theme.colorScheme.textColor),
          ),
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
          actions: const [
            // IconButton(
            //     iconSize: Dimensions.h30,
            //     onPressed: () {},
            //     icon: CustomSvgAssetImage(
            //       image: ImageAsset.icAddNew,
            //       height: Dimensions.h30,
            //       color: Theme.of(context).colorScheme.textColor,
            //     )),
            // IconButton(
            //     iconSize: Dimensions.h30,
            //     onPressed: () {},
            //     icon: CustomSvgAssetImage(
            //       image: ImageAsset.icRightMenuNav,
            //       height: Dimensions.h30,
            //       color: Theme.of(context).colorScheme.textColor,
            //     )),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CustomSvgAssetImage(
                    image: ImageAsset.icAppIconWithTagline,
                    color: ColorConst.primaryColor,
                    height: Dimensions.h70,
                  ),
                ),
                SizedBox(
                  height: Dimensions.h15,
                ),
                Text(
                  "Welcome to Just Social, the app that connects you with like-minded people who share your interests and passions! Our app is designed to help you find friends with whom you can exchange ideas, thoughts, and experiences on a wide range of topics. \n\nOur platform allows you to participate in various conversations and events, and to connect with others who share your interests. Whether you're into gaming, fashion, travel, or any other hobby, RST Social is the perfect place for you to connect with others who share your enthusiasm. \n\nOur app also features a direct chat feature, so you can communicate one-on-one with other users, sharing your experiences and knowledge about your favorite topics. We believe that connecting with others in this way can be a powerful tool in helping you to expand your social circle and explore new interests. \n\n"
                      "At Just Social, we value engagement and community. That's why we've developed a rewards system that recognizes users who actively participate in the app. Users receive award points based on the engagement their posts receive, and can redeem those points for special rewards and perks within the app. We believe that RST Social is more than just an app. It's a vibrant community of people who share a common goal: to connect, engage, and have fun together. We hope that you'll join us on this journey and become a valued member of our community.",
                  style: fontStyleRegular14.copyWith(
                      color: Get.theme.colorScheme.textColor
                  ),
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
