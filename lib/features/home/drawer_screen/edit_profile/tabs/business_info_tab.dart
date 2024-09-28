import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rstsocial/core/widgets/network_image.dart';

import '../../../../../core/basic_features.dart';

class BusinessInfoTab extends StatefulWidget {
  const BusinessInfoTab({super.key});

  @override
  State<BusinessInfoTab> createState() => _BusinessInfoTabState();
}

class _BusinessInfoTabState extends State<BusinessInfoTab> {
  final listBusinessImages = [
    "https://www.dayoutdubai.ae/blog/wp-content/uploads/2019/10/cover.jpg",
    "https://www.mistay.in/travel-blog/content/images/size/w2000/2020/07/steep_extreme_sport_game_4k.jpg",
    "https://w0.peakpx.com/wallpaper/853/41/HD-wallpaper-marty-afro-circus-madagascar.jpg",
    "https://cdn.suruga-ya.com/database/pics_light/game/646129211.jpg",
    "https://animeanime.global/wp-content/uploads/2019/12/285578.jpg",
    "https://m.media-amazon.com/images/I/61dX7+tdTcL.SS700.jpg"
  ];
  final Rx<Color> highPriorityTextColor = Rx(AppUtils.getRandomColor());

  @override
  void initState() {
    Timer.periodic(const Duration(milliseconds: 800), (timer) {
      updateColor();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Name
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(top: Dimensions.h10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                AppString.businessName,
                style: fontStyleSemiBold16.copyWith(
                    color: Get.theme.colorScheme.textColor),
              ),
              SizedBox(
                height: Dimensions.h2,
              ),

              // Data
              Text(
                "Doofenshmirtz Evil Incorporated",
                style: fontStyleMedium13.copyWith(
                    color: Get.theme.colorScheme.textColor),
              ),
            ],
          ),
        ),

        // Contact
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(top: Dimensions.h10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                AppString.businessContact,
                style: fontStyleSemiBold16.copyWith(
                    color: Get.theme.colorScheme.textColor),
              ),
              SizedBox(
                height: Dimensions.h2,
              ),

              // Data
              Text(
                "+91-9521482654",
                style: fontStyleMedium13.copyWith(
                    color: Get.theme.colorScheme.textColor),
              ),
            ],
          ),
        ),

        // Address
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(top: Dimensions.h10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                AppString.businessAddress,
                style: fontStyleSemiBold16.copyWith(
                    color: Get.theme.colorScheme.textColor),
              ),
              SizedBox(
                height: Dimensions.h2,
              ),

              // Data
              Text(
                "Opposite City Hall, New York, USA",
                style: fontStyleMedium13.copyWith(
                    color: Get.theme.colorScheme.textColor),
              ),
            ],
          ),
        ),

        // About
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(top: Dimensions.h10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                AppString.about,
                style: fontStyleSemiBold16.copyWith(
                    color: Get.theme.colorScheme.textColor),
              ),
              SizedBox(
                height: Dimensions.h2,
              ),

              // Data
              Text(
                "Throw an epic USA-inspired summer shindig with blazing deals and a sizzling selection storewide through June. Load up on picks like Animal-Welfare Certified tomahawk steaks, New-York style cheesecake, BBQ condiments, hard selzers,and more.",
                style: fontStyleMedium13.copyWith(
                    color: Get.theme.colorScheme.textColor),
              ),
            ],
          ),
        ),

        // Images
        Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen)
              .copyWith(top: Dimensions.h10, bottom: Dimensions.h8),
          child: Text(
            AppString.businessImages,
            style: fontStyleSemiBold16.copyWith(
                color: Get.theme.colorScheme.textColor),
          ),
        ),
        SizedBox(
          height: Dimensions.w113,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? Dimensions.commonPaddingForScreen : 0,
                  right: Dimensions.w12),
              child: MyNetworkImage(
                  borderRadius: Dimensions.r10,
                  height: Dimensions.w100,
                  width: Dimensions.w100,
                  fitType: BoxFit.cover,
                  image: listBusinessImages[index]),
            ),
            itemCount: listBusinessImages.length,
          ),
        ),
        SizedBox(
          height: Dimensions.h5,
        ),

        // Social URLs
        // SizedBox(
        //   width: Get.width,
        //   child: FittedBox(
        //     fit: BoxFit.fitWidth,
        //     child: Obx(
        //       () => Text(
        //         "Gimme\nBetter\nSocial\nURL\nUI",
        //         style: fontStyleBold22.copyWith(
        //             color: highPriorityTextColor.value,
        //             // color: ColorConst.primaryLightColor,
        //             height: 1),
        //       ),
        //     ),
        //   ),
        // )
      ]),
    );
  }

  void updateColor() {
    highPriorityTextColor.value = AppUtils.getRandomColor();
  }
}
