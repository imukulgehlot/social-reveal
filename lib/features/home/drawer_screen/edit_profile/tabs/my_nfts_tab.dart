import 'package:flutter/material.dart';

import '../../../../../core/basic_features.dart';
import '../../../../../core/model/ui_model/category_model.dart';
import '../../../../../core/widgets/custom_image.dart';

class MyNFTsTab extends StatelessWidget {
  MyNFTsTab({super.key});

  late final RxList<CommonUIModel> listReactionChips = [
    CommonUIModel(
      title: AppString.happy,
      image: ImageAsset.icCaringReact,
      thirdLine: "10",
      isSelected: true,
    ),
    CommonUIModel(
      title: AppString.laugh,
      image: ImageAsset.icInnovatorReact,
      thirdLine: "8",
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.cry,
      image: ImageAsset.icUtilityReact,
      thirdLine: "7",
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.socialBuzz,
      thirdLine: "12",
      image: ImageAsset.icSpiritual,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.stories,
      image: ImageAsset.icCaringReact,
      thirdLine: "0",
      isSelected: false,
    ),
  ].obs;

  late final RxList<CommonUIModel> listNTFs = [
    CommonUIModel(
        title: "PopCulturePixels #12",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "XLR8 #16",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Four Arms #19",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Diamond-head #10",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Upgrade #11",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Grey Matter #13",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Wild-vine #90",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Stink-fly #18",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Rip-jaws #53",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Ghost-freak #65",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Cannonball #26",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Wild mutt #78",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Upchuck #24",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Ditto #36",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Eye Guy #12",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Way Big #18",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Campfire #23",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Echo Echo #45",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Humungous #23",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
    CommonUIModel(
        title: "Betray #28",
        image:
            "https://i.etsystatic.com/19716042/r/il/68bcda/3675686769/il_794xN.3675686769_e7li.jpg"),
  ].obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Padding
            Padding(
              padding: EdgeInsets.symmetric(vertical: Dimensions.h10),
              child: SizedBox(
                height: Get.height * 0.045,
                child: Obx(
                  () => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: listReactionChips.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        listReactionChips
                            .firstWhere((element) => element.isSelected == true)
                            .isSelected = false;

                        listReactionChips[index].isSelected = true;
                        listReactionChips.refresh();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.h2,
                            horizontal: Dimensions.w18),
                        margin: EdgeInsets.only(
                            left: Dimensions.w16,
                            right: index == listReactionChips.length - 1
                                ? Dimensions.w13
                                : 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.r25),
                          color: listReactionChips[index].isSelected
                              ? ColorConst.primaryColor
                              : Get.theme.colorScheme.textFieldColor,
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Icon
                              CustomSvgAssetImage(
                                image: listReactionChips[index].image ?? '',
                                width: Dimensions.w30,
                                height: Dimensions.w30,
                                // color: listReactionChips[index].isSelected
                                //     ? ColorConst.whiteColor
                                //     : Get.theme.colorScheme.textColor,
                              ),
                              SizedBox(
                                width: Dimensions.w5,
                              ),

                              // Category Name
                              Text(
                                '${listReactionChips[index].title}(${listReactionChips[index].thirdLine})',
                                style: fontStyleBold13.apply(
                                    color: listReactionChips[index].isSelected
                                        ? ColorConst.whiteColor
                                        : Get.theme.colorScheme.textColor),
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Your NFTs Heading
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.commonPaddingForScreen)
                  .copyWith(bottom: Dimensions.h8),
              child: Text(
                AppString.yourNFTs,
                style: fontStyleSemiBold16.copyWith(
                    color: Get.theme.colorScheme.textColor),
              ),
            ),

            // NTFs
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.199,
                  crossAxisSpacing: Dimensions.w15,
                  mainAxisSpacing: Dimensions.h15,
                ),
                itemCount: listNTFs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Material(
                  color: Theme.of(context).colorScheme.textFieldColor,
                  borderRadius: BorderRadius.circular(Dimensions.r10),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(Dimensions.r10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Image
                        Padding(
                          padding: EdgeInsets.only(
                              top: Dimensions.h10, bottom: Dimensions.h8),
                          child: MyNetworkImage(
                            image: listNTFs[index].image!,
                            height: Dimensions.w130,
                            radius: Dimensions.r10,
                            width: Dimensions.w130,
                            fitType: BoxFit.cover,
                          ),
                        ),

                        // Title
                        Flexible(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Dimensions.w5),
                            child: Text(
                              listNTFs[index].title,
                              overflow: TextOverflow.ellipsis,
                              style: fontStyleSemiBold12.copyWith(
                                  color: Get.theme.colorScheme.textColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: Dimensions.h20,
            )
          ],
        ),
      ),
    );
  }
}
