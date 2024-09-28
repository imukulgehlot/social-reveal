import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/text_field/text_field/search_bar_text_field.dart';
import 'navigation_drawer.dart';
import 'news_feed_details.dart';

class NewsFeedScreen extends StatelessWidget {
  NewsFeedScreen({super.key});

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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          goToDrawerHomeTab();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppString.newsFeed,
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
              onPressed: goToDrawerHomeTab,
            ),
          ),
          body: Column(
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.commonPaddingForScreen)
                    .copyWith(bottom: Dimensions.h2),
                child: SearchBarTextBoxField(
                  height: Dimensions.h35,
                  bgColor: Theme.of(context).colorScheme.textFieldColor,
                  textController: Get.put(TextEditingController()),
                  topLeftRadius: Dimensions.r20,
                  topRightRadius: Dimensions.r20,
                  bottomLeftRadius: Dimensions.r20,
                  bottomRightRadius: Dimensions.r20,
                  onChanged: (val) {},
                  afterClearButton: () {},
                  prefixIcon: const SizedBox(),
                  hintText: AppString.searchPeopleTopic,
                  hintTextColor: Theme.of(context).colorScheme.textColor,
                  suffixIcon: CustomSvgAssetImage(
                    image: ImageAsset.icSearch,
                    height: Dimensions.w30,
                    width: Dimensions.w30,
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.h15,
                              horizontal: Dimensions.w15),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.r15)),
                                clipBehavior: Clip.hardEdge,
                                child: CustomNetworkImage(
                                    height: Dimensions.h110,
                                    image:
                                        'https://img.freepik.com/free-photo/indian-condiments-with-copy-space-view_23-2148723492.jpg'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color:
                                        ColorConst.blackColor.withOpacity(0.5),
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.r15)),
                                height: Dimensions.h110,
                              ),
                              Padding(
                                padding: EdgeInsets.all(Dimensions.w15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Health News',
                                        style: fontStyleSemiBold20.copyWith(
                                            color: Colors.white)),
                                    Text(
                                      'Keep up with the ever-changing world of entertainment!.',
                                      textAlign: TextAlign.center,
                                      style: fontStyleRegular12.copyWith(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        // Select category text
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimensions.w15),
                          alignment: AlignmentDirectional.centerStart,
                          margin: EdgeInsets.symmetric(vertical: Dimensions.h5),
                          child: Text(
                            'Select a category',
                            style: fontStyleSemiBold20,
                          ),
                        ),

                        // Horizontal Listview
                        SizedBox(
                            height: Dimensions.h40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(
                                          vertical: Dimensions.h2,
                                          horizontal: Dimensions.w15)
                                      .copyWith(right: Dimensions.w5),
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.h5,
                                      horizontal: Dimensions.w25),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(Dimensions.r20),
                                      color: ColorConst.primaryLightColor),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomSvgAssetImage(
                                        image: healthCategories[index]['icon'],
                                        width: Dimensions.w24,
                                        color:
                                            Get.theme.scaffoldBackgroundColor,
                                        height: Dimensions.h24,
                                      ),
                                      SizedBox(
                                        width: Dimensions.w5,
                                      ),
                                      Text(
                                        healthCategories[index]['title'],
                                        style: fontStyleSemiBold15.copyWith(
                                            color: Colors.white, height: 1.4),
                                      )
                                    ],
                                  ),
                                );
                              },
                              itemCount: healthCategories.length,
                            )),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimensions.w15),
                          alignment: AlignmentDirectional.centerStart,
                          margin:
                              EdgeInsets.symmetric(vertical: Dimensions.h10),
                          child: Text(
                            'Featured Stories',
                            style: fontStyleSemiBold20,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                Text("Written by Hannah Flynn",
                                                    style: fontStyleRegular10
                                                        .copyWith(
                                                            color: Get
                                                                .theme
                                                                .colorScheme
                                                                .textColor))
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
          )),
    );
  }
}
