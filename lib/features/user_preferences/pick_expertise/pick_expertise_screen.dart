import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/features/user_preferences/pick_expertise/professional_profile.dart';

import '../../../core/widgets/custom_image.dart';

class PickExpertiseScreen extends StatelessWidget {
  PickExpertiseScreen({super.key});

  final List<String> expertise = [
    AppString.medicalDoctor,
    AppString.psychiatricDoctor,
    AppString.socialCounselor,
    AppString.mentalHealthCounselor,
    AppString.yogaTrainer
  ];
  final RxList selectedExpertise = [].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox.square(
                    dimension: kToolbarHeight,
                    child: IconButton(
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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.h25, right: Get.width * 0.15),
                      child: // Top Logo
                          CustomSvgAssetImage(
                        image:  Get.theme.brightness == Brightness.dark ? ImageAsset.icAppLogoLight : ImageAsset.icAppLogoDark,
                        color: ColorConst.primaryColor,
                        width: Dimensions.w105,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.h10,
              ),
              // Tagline
              Text(
                AppString.socialNetworkUiShowcase,
                style:
                    fontStyleSemiBold13.apply(color: ColorConst.primaryColor),
              ),

              SizedBox(
                height: Dimensions.h30,
              ),
              Text(
                AppString.pickYourFieldOfExpertise,
                style:
                    fontStyleSemiBold21.apply(color: ColorConst.primaryColor),
              ),
              SizedBox(
                width: Get.width * 0.9,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: expertise.length,
                    itemBuilder: (context, index) => Obx(
                          () => GestureDetector(
                            onTap: () {
                              selectedExpertise.contains(expertise[index])
                                  ? selectedExpertise.remove(expertise[index])
                                  : selectedExpertise.add(expertise[index]);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: Dimensions.h60,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.w20),
                              margin: EdgeInsets.symmetric(
                                  vertical: Dimensions.h10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.r8),
                                  color: selectedExpertise
                                          .contains(expertise[index])
                                      ? ColorConst.primaryColor
                                      : Get.theme.colorScheme.textFieldColor),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    expertise[index],
                                    style: fontStyleSemiBold15.apply(
                                        color: selectedExpertise
                                                .contains(expertise[index])
                                            ? ColorConst.whiteColor
                                            : Get.theme.colorScheme.textColor),
                                  ),
                                  Container(
                                    height: Dimensions.w30,
                                    width: Dimensions.w30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: selectedExpertise
                                                    .contains(expertise[index])
                                                ? ColorConst.whiteColor
                                                : Get.theme.colorScheme
                                                    .textColor,
                                            width: Dimensions.w2)),
                                    child: Center(
                                      child: selectedExpertise
                                              .contains(expertise[index])
                                          ? Icon(
                                              Icons.check,
                                              size: Dimensions.w23,
                                              color: ColorConst.whiteColor,
                                            )
                                          : const SizedBox(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
              ),
              SizedBox(
                height: Dimensions.h10,
              ),
              Obx(
                () => SizedBox(
                  width: Get.width * 0.9,
                  child: MyButton(
                    onPressed: selectedExpertise.isNotEmpty
                        ? () {
                            Get.to(ProfessionalProfile());
                          }
                        : null,
                    title: AppString.next,
                    textStyle: fontStyleSemiBold14.apply(
                        color: selectedExpertise.isNotEmpty
                            ? ColorConst.whiteColor
                            : Colors.grey),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
