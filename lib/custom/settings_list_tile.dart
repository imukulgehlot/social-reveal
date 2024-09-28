import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';

class SettingsListTile extends StatelessWidget {
  final String title;
  final String subTitle;

  final RxBool? currentValue;
  final Function? onTap;

  const SettingsListTile(
      {super.key,
      this.onTap,
      required this.title,
      required this.subTitle,
      this.currentValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        color: Theme.of(context).colorScheme.textFieldColor,
        borderRadius: BorderRadius.circular(Dimensions.r10),
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimensions.r10),
          onTap: () => currentValue != null
              ? currentValue?.value = !currentValue!.value
              : onTap?.call(),
          child: Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: fontStyleSemiBold16.copyWith(
                            color: Get.theme.colorScheme.textColor),
                      ),
                      Text(
                        subTitle,
                        style: fontStyleSemiBold12.copyWith(
                            color: Get.theme.colorScheme.hintTextColor),
                      )
                    ],
                  ),
                  currentValue == null
                      ? RotatedBox(
                          quarterTurns: 2, // Rotate by 180 degrees (2 quarters)
                          child: CustomSvgAssetImage(
                            image: ImageAsset.icBackArrowNav,
                            width: Dimensions.w22,
                            height: Dimensions.w22,
                            color: Get.theme.colorScheme.textColor,
                          ),
                        )
                      : Obx(
                          () => IgnorePointer(
                            child: Switch(
                              trackOutlineColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.transparent),
                              activeTrackColor: ColorConst.primaryLightColor,
                              value: currentValue!.value,
                              onChanged: (value) {
                                currentValue?.value = !currentValue!.value;
                              },
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
