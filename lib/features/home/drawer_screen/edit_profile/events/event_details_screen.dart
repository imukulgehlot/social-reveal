import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/widgets/tab_indicator.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> tabList = [
    AppString.allEvents,
    AppString.eventRequests,
  ];

  late List<Widget> tabChildList;

  final RxInt tabIndex = 0.obs;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animation!.addListener(() {
      tabIndex.value = _tabController.animation!.value.round();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    tabChildList = [
      // Detail Screen
      SingleChildScrollView(
        padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Heading
            Text(
              'Food Sample Sponsorship',
              style:
                  fontStyleBold17.apply(color: Get.theme.colorScheme.textColor),
            ),
            SizedBox(
              height: Dimensions.h5,
            ),

            // Category
            Chip(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.h5, horizontal: Dimensions.w10),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Get.theme.colorScheme.textColor),
                  borderRadius: BorderRadius.circular(Dimensions.r20)),
              avatar: CustomSvgAssetImage(
                image: ImageAsset.icPhysical,
                width: Dimensions.w28,
                height: Dimensions.h28,
                color: Theme.of(context).colorScheme.textColor,
              ),
              labelPadding: EdgeInsets.only(left: Dimensions.w5),
              label: Text(
                AppString.friends,
                style: fontStyleMedium12.apply(
                    color: Get.theme.colorScheme.textColor),
              ),
            ),
            SizedBox(
              height: Dimensions.h5,
            ),

            // Body
            Text(
              "I've an offer for you. Let's connect to discuss my vision about the event I am going to host for the community. I'm still in the early stages of planning, but I'm excited about the possibilities. I would love to get your input on the event, and I'm open to any suggestions you may have.",
              style: fontStyleMedium12.copyWith(
                  fontSize: Dimensions.sp11,
                  color: Get.theme.colorScheme.textColor),
            ),
            SizedBox(
              height: Dimensions.h10,
            ),

            // Location
            Text(
              AppString.location,
              style: fontStyleSemiBold14.apply(
                  color: Get.theme.colorScheme.textColor),
            ),
            Text(
              "New York, USA",
              style: fontStyleMedium12.copyWith(
                  fontSize: Dimensions.sp11,
                  color: Get.theme.colorScheme.textColor),
            ),
            SizedBox(
              height: Dimensions.h10,
            ),

            // Valid Up to
            Text(
              AppString.validUpTo,
              style: fontStyleSemiBold14.apply(
                  color: Get.theme.colorScheme.textColor),
            ),
            Text("20th May 2023, 08:00 PM",
                style: fontStyleMedium12.copyWith(
                    fontSize: Dimensions.sp11,
                    color: Get.theme.colorScheme.hintTextColor)),
            SizedBox(
              height: Dimensions.h10,
            ),

            // Description
            Text(
              AppString.location,
              style: fontStyleSemiBold14.apply(
                  color: Get.theme.colorScheme.textColor),
            ),
            Text(
              "33 Cyclist from across the country will participate in USA's Inland 1400 Km long distance cycling marathon scheduled to be flagged in New York on Friday. The Participants will ride all the way to LA and Will return to New York. the entire strech is likely to be covered in about 112 hours.",
              style: fontStyleMedium12.copyWith(
                  fontSize: Dimensions.sp11,
                  color: Get.theme.colorScheme.textColor),
            ),
            SizedBox(
              height: Dimensions.h10,
            ),
          ],
        ),
      ),

      // Detail Screen
      SingleChildScrollView(
        padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Heading
            Text(
              'Food Sample Sponsorship',
              style:
                  fontStyleBold17.apply(color: Get.theme.colorScheme.textColor),
            ),
            SizedBox(
              height: Dimensions.h5,
            ),

            // Category
            Chip(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.h5, horizontal: Dimensions.w10),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Get.theme.colorScheme.textColor),
                  borderRadius: BorderRadius.circular(Dimensions.r20)),
              avatar: CustomSvgAssetImage(
                image: ImageAsset.icPhysical,
                width: Dimensions.w28,
                height: Dimensions.h28,
                color: Theme.of(context).colorScheme.textColor,
              ),
              labelPadding: EdgeInsets.only(left: Dimensions.w5),
              label: Text(
                AppString.friends,
                style: fontStyleMedium12.apply(
                    color: Get.theme.colorScheme.textColor),
              ),
            ),
            SizedBox(
              height: Dimensions.h5,
            ),

            // Body
            Text(
              "I've an offer for you. Let's connect to discuss my vision about the event I am going to host for the community. I'm still in the early stages of planning, but I'm excited about the possibilities. I would love to get your input on the event, and I'm open to any suggestions you may have.",
              style: fontStyleMedium12.copyWith(
                  fontSize: Dimensions.sp11,
                  color: Get.theme.colorScheme.textColor),
            ),
            SizedBox(
              height: Dimensions.h10,
            ),

            // Location
            Text(
              AppString.location,
              style: fontStyleSemiBold14.apply(
                  color: Get.theme.colorScheme.textColor),
            ),
            Text(
              "New York, USA",
              style: fontStyleMedium12.copyWith(
                  fontSize: Dimensions.sp11,
                  color: Get.theme.colorScheme.textColor),
            ),
            SizedBox(
              height: Dimensions.h10,
            ),

            // Valid Up to
            Text(
              AppString.validUpTo,
              style: fontStyleSemiBold14.apply(
                  color: Get.theme.colorScheme.textColor),
            ),
            Text("20th May 2023, 08:00 PM",
                style: fontStyleMedium12.copyWith(
                    fontSize: Dimensions.sp11,
                    color: Get.theme.colorScheme.hintTextColor)),
            SizedBox(
              height: Dimensions.h10,
            ),

            // Description
            Text(
              AppString.location,
              style: fontStyleSemiBold14.apply(
                  color: Get.theme.colorScheme.textColor),
            ),
            Text(
              "33 Cyclist from across the country will participate in USA's Inland 1400 Km long distance cycling marathon scheduled to be flagged in New York on Friday. The Participants will ride all the way to LA and Will return to New York. the entire strech is likely to be covered in about 112 hours.",
              style: fontStyleMedium12.copyWith(
                  fontSize: Dimensions.sp11,
                  color: Get.theme.colorScheme.textColor),
            ),
            SizedBox(
              height: Dimensions.h10,
            ),
          ],
        ),
      )
    ];

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  titleSpacing: Dimensions.w5,
                  title: Text(
                    AppString.eventDetails,
                    style: fontStyleSemiBold17.apply(
                      color: Theme.of(context).colorScheme.textColor,
                    ),
                  ),
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
                  pinned: true,
                ),

                SliverToBoxAdapter(
                  child: // Event Image
                      MyNetworkImage(
                    fitType: BoxFit.cover,
                    height: Dimensions.h130,
                    image:
                        "https://static1.srcdn.com/wordpress/wp-content/uploads/2020/07/Avengers-Endgame-Tony-Funeral-Rhodes-Happy.jpg?q=50&fit=contain&w=1140&h=&dpr=1.5",
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: Dimensions.h10,
                  ),
                ),

                // Tab Bar
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Theme(
                        data: ThemeData(useMaterial3: false),
                        child: TabBar(
                          isScrollable: true,
                          physics: const BouncingScrollPhysics(),
                          controller: _tabController,
                          indicator: MD2Indicator(
                            indicatorColor: ColorConst.primaryColor,
                            indicatorHeight: Dimensions.h2,
                            indicatorSize: MD2IndicatorSize.tiny,
                          ),
                          padding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.zero,
                          tabs: [
                            for (int i = 0; i < tabList.length; i++)
                              Container(
                                width: Get.width / _tabController.length,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.w20),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: ColorConst.primaryColor,
                                            width: 2))),
                                child: Column(
                                  children: <Widget>[
                                    Obx(
                                      () => Text(
                                        tabList[i],
                                        style: tabIndex.value == i
                                            ? fontStyleBold16.copyWith(
                                                color: Get.theme.colorScheme
                                                    .textColor)
                                            : fontStyleSemiBold16.copyWith(
                                                color: Get.theme.colorScheme
                                                    .textColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
          body: TabBarView(
            controller: _tabController,
            children: tabChildList,
          )),
    );
  }
}
