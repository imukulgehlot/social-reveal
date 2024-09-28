import 'package:flutter/material.dart';

import '../../features/home/home_screen.dart';
import '../basic_features.dart';
import '../widgets/custom_image.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: CustomSvgAssetImage(
            image: ImageAsset.icBackArrowNav,
            width: Dimensions.w28,
            height: Dimensions.h28,
            color: Theme.of(context).colorScheme.textColor,
          ),
          onPressed: Get.back,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
        child: Column(
          children: [
            // Location Text
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: AppString.locationTitle,
                  children: [
                    TextSpan(
                        text: AppString.locationSubtitle,
                        style: fontStyleBold18.apply(
                            color: ColorConst.primaryLightColor))
                  ],
                  style: fontStyleSemiBold18.apply(
                    color: ColorConst.primaryColor,
                  )),
            ),

            // Location SVG
            CustomSvgAssetImage(
              image: ImageAsset.icLocationPermission,
              height: Get.height * 0.50,
              width: Get.width,
            ),

            // Allow Button
            MyOutLineButton(
              title: AppString.allowAccess,
              onPressed: () async {
                await AppUtils.getCurrentLocation();
              },
              borderWidth: Dimensions.w2,
              cornerRadius: Dimensions.r10,
              btnBgColor: Colors.transparent,
              height: Dimensions.h35,
              miniWidth: Dimensions.w145,
              borderColor: ColorConst.primaryColor,
              textStyle:
                  fontStyleSemiBold13.copyWith(color: ColorConst.primaryColor),
            ),
            const Spacer(),

            // Next Button
            Hero(
                tag: "signInToIntro",
                transitionOnUserGestures: true,
                child: MyButton(
                    title: AppString.next,
                    onPressed: () => Get.offAll(() => const HomeScreen()))),
            SizedBox(
              height: Dimensions.h20,
            )
          ],
        ),
      ),
    );
  }
}
