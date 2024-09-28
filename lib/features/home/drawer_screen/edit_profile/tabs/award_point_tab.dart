import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';

class AwardPointTab extends StatelessWidget {
  const AwardPointTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: Get.width,
            padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
            decoration: BoxDecoration(
                color: Get.theme.colorScheme.textFieldColor,
                borderRadius: BorderRadius.circular(Dimensions.r12)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSvgAssetImage(
                  image: ImageAsset.icCaringReact,
                  height: Dimensions.w50,
                  width: Dimensions.w50,
                  // color: Get.theme.colorScheme.textColor,
                ),
                SizedBox(
                  width: Dimensions.w10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.happy,
                      style: fontStyleSemiBold17.apply(
                          color: Get.theme.colorScheme.textColor),
                    ),
                    Text(
                      "${AppString.position} 3",
                      style: fontStyleSemiBold11.apply(
                          color: Get.theme.colorScheme.hintTextColor),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "3",
                      style: fontStyleSemiBold30.apply(
                          color: ColorConst.primaryColor),
                    ),
                    Text(
                      "Points",
                      style: fontStyleSemiBold15.apply(
                          color: Get.theme.colorScheme.textColor),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
