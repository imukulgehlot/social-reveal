import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';
import 'package:rstsocial/core/widgets/text_field/text_field/my_text_field.dart';

import '../../../../custom/custom_text_field_with_head.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final TextEditingController titleController =
      Get.put(TextEditingController(), tag: "helpCenterTitleController");
  final TextEditingController aboutNeedHelpController =
      Get.put(TextEditingController(), tag: "aboutNeedHelpController");
  final RxString selectedTypeString = "".obs;

  final helpTypes = [
    "🚀 Getting Started",
    "🛠️ Troubleshooting",
    "💳 Billing and Payments",
    "🔒 Account Security",
    "🔗 Connectivity Issues",
    "🔐 Privacy Concerns",
    "🚫 Account Deactivation",
    "📧 Contacting Support",
    "👤 Profile Management",
    "🔄 Updates and Upgrades",
    "📜 Terms and Conditions",
    "📢 Feedback and Suggestions",
    "❓ General Inquiries",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppString.helpCenter,
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
        body: SingleChildScrollView(
          padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: EdgeInsets.only(left: Dimensions.h10),
                child: Text(AppString.title,
                    textAlign: TextAlign.center,
                    style: fontStyleSemiBold15.apply(
                        color: Theme.of(context).colorScheme.textColor)),
              ),
              SizedBox(
                height: Dimensions.h3,
              ),
              MyTextField(
                  borderRadius: Dimensions.r10,
                  prefixIcon: CustomSvgAssetImage(
                    image: ImageAsset.icPrefixTitle,
                    width: Dimensions.w25,
                    color: Theme.of(context).colorScheme.textColor,
                  ),
                  textStyle: fontStyleRegular14.apply(
                      color: Theme.of(context).colorScheme.textColor),
                  height: Dimensions.h40,
                  textInputType: TextInputType.emailAddress,
                  hintTextColor: ColorConst.hintColor,
                  textController: titleController,
                  textFieldBorderColor: Colors.transparent,
                  hintText: AppString.enterYourTitleHere),
              SizedBox(
                height: Dimensions.h13,
              ),

              // Select Type
              Padding(
                padding: EdgeInsets.only(left: Dimensions.h10),
                child: Text(AppString.selectType,
                    textAlign: TextAlign.center,
                    style: fontStyleSemiBold15.copyWith(
                        color: Theme.of(context).colorScheme.textColor)),
              ),

              Material(
                borderRadius: BorderRadius.circular(Dimensions.r10),
                color: Get.theme.colorScheme.textFieldColor,
                child: InkWell(
                  onTap: () => AppUtils.openCustomBottomSheet(
                      contentWidget: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppString.selectHelpType,
                          style: fontStyleSemiBold15.copyWith(
                              fontSize: Dimensions.sp17,
                              color: Get.theme.colorScheme.textColor)),
                      SizedBox(
                        height: Dimensions.h10,
                      ),
                      Column(
                        children: helpTypes.map((e) {
                          return Material(
                            child: ListTile(
                                visualDensity: const VisualDensity(
                                    vertical: VisualDensity.minimumDensity),
                                leading: Text(
                                  e.split(" ")[0],
                                  style: fontStyleSemiBold13.copyWith(
                                      fontSize: Dimensions.sp20),
                                ),
                                horizontalTitleGap: Dimensions.w7,
                                title: Text(
                                  e.split(" ").sublist(1).join(" "),
                                  style: fontStyleSemiBold13.copyWith(
                                      fontSize: Dimensions.sp15,
                                      color: Get.theme.colorScheme.textColor),
                                ),
                                onTap: () {
                                  selectedTypeString.value = e;
                                  Get.back();
                                },
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 0)),
                          );
                        }).toList(),
                      )
                    ],
                  )),
                  borderRadius: BorderRadius.circular(Dimensions.r10),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w5, vertical: Dimensions.h9),
                    width: Get.width,
                    child: Obx(
                      () => Row(
                        children: [
                          // Icon
                          CustomSvgAssetImage(
                            image: ImageAsset.icHandShake,
                            width: Dimensions.w25,
                            height: Dimensions.w25,
                            color: Get.theme.colorScheme.hintTextColor,
                          ),
                          SizedBox(
                            width: Dimensions.w8,
                          ),

                          // Click to tag People
                          selectedTypeString.value.isEmpty
                              ? Text(AppString.selectHelpType,
                                  style: fontStyleRegular14.apply(
                                      color:
                                          Get.theme.colorScheme.hintTextColor))
                              : Text(
                                  selectedTypeString.value
                                      .split(" ")
                                      .sublist(1)
                                      .join(" "),
                                  style: fontStyleRegular14.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .textColor)),

                          const Spacer(),

                          // That Arrow
                          Icon(
                            Icons.keyboard_arrow_down_sharp,
                            size: Dimensions.w20,
                            color: Get.theme.colorScheme.hintTextColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.h13,
              ),

              // About Help Need
              Padding(
                padding: EdgeInsets.only(left: Dimensions.h10),
                child: Text(AppString.aboutNeedHelp,
                    textAlign: TextAlign.center,
                    style: fontStyleSemiBold15.apply(
                        color: Theme.of(context).colorScheme.textColor)),
              ),
              CustomTextFieldWithHead(
                hintText: AppString.enterYourDescriptionHere,
                textInputType: TextInputType.multiline,
                controller: aboutNeedHelpController,
                prefixIcon: ImageAsset.icAboutYourself,
                maxLine: 4,
                padding: EdgeInsets.only(top: Dimensions.h10),
                iconBottomPadding: Dimensions.h53,
              ),

              // Submit Button
              Padding(
                padding: EdgeInsets.only(top: Dimensions.h15),
                child: MyButton(
                  title: AppString.submit,
                  onPressed: () => Get.back(),
                  // onPressed: () => Const.showSnackBar(message: 'meow meow meow MEOW!',isSuccess: true),
                ),
              ),
              SizedBox(
                height: Dimensions.h13,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
