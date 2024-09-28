import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/features/home/bottom_navigation/tabs/home_tab/create_post/create_post_main_screen.dart';

import '../../../../../core/model/ui_model/category_model.dart';
import '../../../../../core/model/ui_model/sample_data.dart';
import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/widgets/text_field/text_field/search_bar_text_field.dart';
import '../../../../../custom/custom_offers_posts.dart';
import '../../../../../custom/custom_tab_bar_sliver_delegate.dart';
import '../../../drawer_screen/navigation_drawer.dart';

class YoloTabScreen extends StatefulWidget {
  const YoloTabScreen({super.key});

  @override
  State<YoloTabScreen> createState() => _YoloTabScreenState();
}

class _YoloTabScreenState extends State<YoloTabScreen> {
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

  late final RxList<CommonUIModel> listCategoriesAndTopics = [
    CommonUIModel(
      title: AppString.friends,
      image: ImageAsset.icPhysical,
      isSelected: true,
    ),
    CommonUIModel(
      title: AppString.groups,
      image: ImageAsset.icLifestyle,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.messages,
      image: ImageAsset.icDietary,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.trending,
      image: ImageAsset.icNutritional,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.eventsCategory,
      image: ImageAsset.icExperiences,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.viral,
      image: ImageAsset.icAlternateMedicine,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.socialBuzz,
      image: ImageAsset.icSpiritual,
      isSelected: false,
    ),
    CommonUIModel(
      title: AppString.love,
      image: ImageAsset.icSocial,
      isSelected: false,
    ),
  ].obs;

  final selectedTabBarIndex = 0.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // App Bar
            SliverAppBar(
              pinned: true,
              titleSpacing: Dimensions.w5,
              title: Text(
                AppString.YOLO,
                style: fontStyleSemiBold16.apply(
                  color: Theme.of(context).colorScheme.textColor,
                ),
              ),
              // Drawer Button Here
              leading: Padding(
                padding: EdgeInsets.only(left: Dimensions.w10),
                child: IconButton(
                  onPressed: drawerScaffoldKey.currentState?.openDrawer,
                  icon: CustomSvgAssetImage(
                    image: ImageAsset.icDrawerIcon,
                    color: Theme.of(context).colorScheme.textColor,
                    width: Dimensions.w28,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  iconSize: Dimensions.h30,
                  onPressed: () => Get.to(() => const CreatePostMainScreen()),
                  icon: CustomSvgAssetImage(
                    image: ImageAsset.icAddNew,
                    height: Dimensions.h30,
                    color: Theme.of(context).colorScheme.textColor,
                  ),
                ),
                SizedBox(
                  width: Dimensions.w5,
                ),
              ],
            ),

            // Offers Pics & Location Button
            SliverToBoxAdapter(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w20),
                  child: SearchBarTextBoxField(
                    height: Dimensions.h40,
                    bgColor: Theme.of(context).colorScheme.textFieldColor,
                    textController: Get.put(TextEditingController()),
                    topLeftRadius: Dimensions.r15,
                    topRightRadius: Dimensions.r15,
                    bottomLeftRadius: Dimensions.r15,
                    bottomRightRadius: Dimensions.r15,
                    onChanged: (val) {},
                    afterClearButton: () {},
                    prefixIcon: const SizedBox(),
                    hintText: AppString.searchPeopleTopic,
                    hintTextColor: Theme.of(context).colorScheme.textColor,
                    suffixIcon: CustomSvgAssetImage(
                      image: ImageAsset.icSearch,
                      height: Dimensions.h25,
                      width: Dimensions.h25,
                      color: Theme.of(context).colorScheme.textColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.h15, horizontal: Dimensions.w15),
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
                            color: ColorConst.blackColor.withOpacity(0.5),
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
                            Text('Your offer / Local offer',
                                style: fontStyleSemiBold20.copyWith(
                                    color: Colors.white)),
                            Text(
                              'Keep up with the ever-changing world of entertainment.',
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.w15)
                      .copyWith(bottom: Dimensions.w15),
                  child: MyButton(
                    padding: EdgeInsets.zero,
                    height: Dimensions.h40,
                    onPressed: () {},
                    cornerRadius: Dimensions.r10,
                    child: Row(
                      children: [
                        SizedBox(
                          width: Dimensions.w12,
                        ),
                        CustomSvgAssetImage(
                          image: ImageAsset.icLocation,
                          width: Dimensions.w25,
                          color: ColorConst.whiteColor,
                        ),
                        SizedBox(
                          width: Dimensions.w5,
                        ),
                        Text(
                          "New York City, USA",
                          style: fontStyleSemiBold20.copyWith(
                            color: ColorConst.whiteColor,
                            fontSize: Dimensions.sp15,
                          ),
                        ),
                        const Spacer(),
                        RotatedBox(
                          quarterTurns: 2,
                          // Rotate by 180 degrees (2 quarters)
                          child: CustomSvgAssetImage(
                            image: ImageAsset.icBackArrowNav,
                            width: Dimensions.w30,
                            height: Dimensions.w30,
                            color: ColorConst.whiteColor,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.w12,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),

            // Tab Bar
            SliverPersistentHeader(
              key: UniqueKey(),
              delegate: CustomTabBarSliverDelegate(
                  maxHeight: Dimensions.h40,
                  minHeight: Dimensions.h40,
                  buildChild: (overLapsContent) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: overLapsContent
                            ? EdgeInsets.symmetric(horizontal: Dimensions.w15)
                                .copyWith(top: Dimensions.h5)
                            : EdgeInsets.symmetric(horizontal: Dimensions.w15),
                        clipBehavior: Clip.hardEdge,
                        height: Dimensions.h40,
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.tabBarBackgroundColor,
                          borderRadius:
                               BorderRadius.circular(Dimensions.r10),
                        ),
                        child: TabBar(
                            onTap: (value) => selectedTabBarIndex.value = value,
                            dividerHeight: 0,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                                borderRadius: selectedTabBarIndex.value == 0 &&
                                        overLapsContent
                                    ? BorderRadius.circular(Dimensions.r10)
                                    : BorderRadius.circular(Dimensions.r10),
                                color: ColorConst.primaryColor),
                            labelColor: ColorConst.whiteColor,
                            labelStyle: fontStyleBold13,
                            unselectedLabelStyle: fontStyleSemiBold13,
                            unselectedLabelColor:
                                Get.theme.colorScheme.textColor,
                            tabs: const [
                              Tab(
                                text: "Offers"
                              ),
                              Tab(text: "Events"),
                              Tab(text: "Practitioner"),
                            ]),
                      )),
              pinned: true,
              floating: false,
            ),
          ],
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // Offers
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: SampleData.samplePosts.length,
                itemBuilder: (context, index) =>
                    CustomOffersPost(model: SampleData.samplePosts[index]),
              ),

              // Events
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.r10)),
                    margin: EdgeInsets.symmetric(
                        vertical: Dimensions.h10, horizontal: Dimensions.w15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Event Image
                            MyNetworkImage(
                              fitType: BoxFit.cover,
                              height: Dimensions.h240,
                              image:
                                  'https://assets-chicagomarathon-com.s3.amazonaws.com/wp-content/uploads/2022/06/Apply-700x225.jpg',
                            ),

                            // Text On Top
                            Container(
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color:
                                      ColorConst.blackColor.withOpacity(0.85)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.w5,
                                    vertical: Dimensions.h10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: Dimensions.w10, right: 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Participated in Event",
                                                  style: fontStyleSemiBold16
                                                      .copyWith(
                                                          color: ColorConst
                                                              .whiteColor),
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height: Dimensions.h5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .calendar_month_rounded,
                                                      size: Dimensions.w16,
                                                      color:
                                                          ColorConst.whiteColor,
                                                    ),
                                                    SizedBox(
                                                      width: Dimensions.w5,
                                                    ),
                                                    Text(
                                                      "20 March 2023, 10:00 AM",
                                                      style: fontStyleMedium12
                                                          .copyWith(
                                                              color: ColorConst
                                                                  .whiteColor),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on,
                                                        size: Dimensions.w16,
                                                        color: ColorConst
                                                            .whiteColor),
                                                    SizedBox(
                                                      width: Dimensions.w5,
                                                    ),
                                                    Text(
                                                      "New York, United States",
                                                      style: fontStyleRegular13
                                                          .copyWith(
                                                              color: ColorConst
                                                                  .whiteColor),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.person,
                                                        size: Dimensions.w16,
                                                        color: ColorConst
                                                            .whiteColor),
                                                    SizedBox(
                                                      width: Dimensions.w5,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                          text: "2356",
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    " people interested",
                                                                style: fontStyleRegular13.apply(
                                                                    color: ColorConst
                                                                        .whiteColor))
                                                          ],
                                                          style: fontStyleBold13
                                                              .apply(
                                                            color: ColorConst
                                                                .primaryColor,
                                                          )),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: Dimensions.w5),
                                        child: Material(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(Dimensions.r20)),
                                          child: InkWell(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    Dimensions.r20)),
                                            onTap: () {},
                                            child: Container(
                                                padding: EdgeInsets.all(
                                                    Dimensions.h5),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: Dimensions.h2,
                                                      color: ColorConst
                                                          .primaryColor,
                                                    ),
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            Dimensions.r20))),
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  "Join event",
                                                  style: fontStyleMedium12
                                                      .copyWith(
                                                    color:
                                                        ColorConst.primaryColor,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                itemCount: healthCategories.length,
              ),

              // Practitioner
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.w10, vertical: Dimensions.h10),
                    child: Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(Dimensions.r10),
                        onTap: () => (),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: Dimensions.w15),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Stack(children: [
                                    CustomNetworkImage(
                                        height: Dimensions.h50,
                                        width: Dimensions.h50,
                                        borderRadius: Dimensions.r80,
                                        image:
                                            'https://img.freepik.com/free-photo/indian-condiments-with-copy-space-view_23-2148723492.jpg'),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: CustomSvgAssetImage(
                                        image: ImageAsset.icAddBadge,
                                        width: Dimensions.w18,
                                        height: Dimensions.w18,
                                      ),
                                    )
                                  ]),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Dimensions.w10, right: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Bruno Fernandes",
                                          style: fontStyleSemiBold16.copyWith(),
                                          maxLines: 1,
                                        ),
                                        Text(
                                          "Yoga Trainer",
                                          style: fontStyleMedium12.copyWith(
                                              color: ColorConst.greyText),
                                        ),
                                        Text(
                                          "New York, NYC",
                                          style: fontStyleMedium12.copyWith(
                                              color: ColorConst.greyText),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Check Offers",
                                style: fontStyleSemiBold10.copyWith(
                                    color: ColorConst.primaryColor),
                                maxLines: 1,
                              ),
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
    );
  }
}
