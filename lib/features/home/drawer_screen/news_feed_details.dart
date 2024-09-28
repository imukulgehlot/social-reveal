import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/text_field/text_field/search_bar_text_field.dart';

class NewsFeedDetails extends StatelessWidget {
  NewsFeedDetails({super.key});

  final List<Map<String, dynamic>> healthCategories = [
    {
      "title": AppString.friends,
      "icon": ImageAsset.icPhysical,
    },
    {
      "title": AppString.groups,
      "icon": ImageAsset.icLifestyle,
    },
    {
      "title": AppString.messages,
      "icon": ImageAsset.icDietary,
    },
    {
      "title": AppString.viral,
      "icon": ImageAsset.icAlternateMedicine,
    },
    {
      "title": AppString.eventsCategory,
      "icon": ImageAsset.icExperiences,
    },
    {
      "title": AppString.socialBuzz,
      "icon": ImageAsset.icSpiritual,
    },
    {
      "title": AppString.love,
      "icon": ImageAsset.icSocial,
    },
    {
      "title": AppString.friends,
      "icon": ImageAsset.icPhysical,
    },
    {
      "title": AppString.groups,
      "icon": ImageAsset.icLifestyle,
    },
    {
      "title": AppString.messages,
      "icon": ImageAsset.icDietary,
    },
    {
      "title": AppString.viral,
      "icon": ImageAsset.icAlternateMedicine,
    },
    {
      "title": AppString.eventsCategory,
      "icon": ImageAsset.icExperiences,
    },
    {
      "title": AppString.socialBuzz,
      "icon": ImageAsset.icSpiritual,
    },
    {
      "title": AppString.love,
      "icon": ImageAsset.icSocial,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: Dimensions.w5,
          title: Text(AppString.newsFeed,
              style: fontStyleSemiBold15.copyWith(
                color: Theme.of(context).colorScheme.textColor,
              )),
          leading: Padding(
            padding: EdgeInsets.only(left: Dimensions.w10),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Theme.of(context).colorScheme.textColor,
                size: Dimensions.w28,
              ),
            ),
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: Dimensions.h10,
                  left: Dimensions.w15,
                  right: Dimensions.w15),
              child: SearchBarTextBoxField(
                bgColor: Theme.of(context).colorScheme.textFieldColor,
                textController: Get.put(TextEditingController()),
                topLeftRadius: Dimensions.r25,
                topRightRadius: Dimensions.r25,
                bottomLeftRadius: Dimensions.r25,
                bottomRightRadius: Dimensions.r25,
                onChanged: (val) {},
                afterClearButton: () {},
                prefixIcon: const SizedBox(),
                hintText: AppString.searchPeopleTopic,
                hintTextColor: Theme.of(context).colorScheme.textColor,
                suffixIcon: CustomSvgAssetImage(
                  image: ImageAsset.icSearch,
                  height: Dimensions.h20,
                  width: Dimensions.w20,
                  color: Theme.of(context).colorScheme.textColor,
                ),
              ),
            ),
            SizedBox(height: Dimensions.h10),
            Expanded(
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      // Top Image
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.h10,
                            horizontal: Dimensions.w15),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Dimensions.r15)),
                              clipBehavior: Clip.hardEdge,
                              child: CustomNetworkImage(
                                  height: Dimensions.h251,
                                  image:
                                      'https://img.freepik.com/free-photo/young-cute-female-posing-indoor_344912-967.jpg'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "GLP-1 agonists: Could they be more than just a treatment for diabetes?",
                              style: fontStyleBold18.copyWith(
                                color: Theme.of(context).colorScheme.textColor,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: Dimensions.h10,
                            ),
                            Text(
                              'Written by Hannah Flynn',
                              style: fontStyleRegular14.copyWith(
                                color: Theme.of(context).colorScheme.textColor,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: Dimensions.h15,
                            ),
                            Text(
                              'High-profile coverage of the off-label use of Ozempic, a GLP-1 agonist, for weight loss, has meant that the type 2 diabetes drug has received a lot of bad press. As more studies into the long-term impact of this group of drugs are published, other potential benefits of the drug are emerging. Glucagon-like peptide-1 (GLP-1) agonist drugs have been prescribed for people with type 2 diabetes and obesity for nearly 20 years, as they were first licensed by the Food and Drug AdministrationTrusted Source (FDA) in 2005. Since then, a number of long-term studies have emerged evaluating both their benefits and their risks, along with some results suggesting potential for further uses. GlucagonTrusted Source is a hormone released from the islets of LangerhansTrusted Source in the pancreas, and it plays an important role in maintaining sugar levels balanced in the body.',
                              style: fontStyleRegular14.copyWith(
                                color: Theme.of(context).colorScheme.textColor,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimensions.w15),
                        alignment: AlignmentDirectional.centerStart,
                        margin: EdgeInsets.symmetric(vertical: Dimensions.h10),
                        child: Text(
                          'Stories you might like',
                          style: fontStyleSemiBold20.copyWith(
                            color: Theme.of(context).colorScheme.textColor,
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.w15,
                                vertical: Dimensions.h10),
                            child: Material(
                              color: Get.theme.colorScheme.textFieldColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.r10),
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.r10),
                                onTap: () => Get.to(() => NewsFeedDetails()),
                                child: Container(
                                  height: Dimensions.h140,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.w15,
                                      vertical: Dimensions.h15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomNetworkImage(
                                          height: Dimensions.h100,
                                          width: Dimensions.w100,
                                          borderRadius: Dimensions.r10,
                                          image:
                                              'https://img.freepik.com/free-photo/indian-condiments-with-copy-space-view_23-2148723492.jpg'),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: Dimensions.w10, right: 0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      "GLP-1 agonists: Could they be more than just a treatment for diabetes?",
                                                      style: fontStyleSemiBold14
                                                          .copyWith(
                                                              color: Get
                                                                  .theme
                                                                  .colorScheme
                                                                  .textColor))),
                                              Text(
                                                "Written by Hannah Flynn",
                                                style:
                                                    fontStyleRegular10.copyWith(
                                                        color: Get
                                                            .theme
                                                            .colorScheme
                                                            .textColor),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: healthCategories.length,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
