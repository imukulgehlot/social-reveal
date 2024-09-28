import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../../../core/model/ui_model/category_model.dart';
import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/widgets/tab_indicator.dart';
import 'event_details_screen.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({super.key});

  @override
  State<AllEventsScreen> createState() => _AllEventScreenState();
}

class _AllEventScreenState extends State<AllEventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> tabList = [
    AppString.allEvents,
    AppString.requestedEvents,
    AppString.eventRequests,
  ];
  late List<Widget> tabChildList;

  RxInt tabIndex = 0.obs;

  late final RxList<CommonUIModel> listEvents = [
    CommonUIModel(
      title: "Need a host for a food event that is...",
      body:
          "Seasoned connoisseur of all things delicious, is set to guide you through an unforgettable food event filled with delectable experiences and gastronomic delights.",
      thirdLine: "20th May 2023, 08:00PM",
      image:
          "https://static1.srcdn.com/wordpress/wp-content/uploads/2020/07/Avengers-Endgame-Tony-Funeral-Rhodes-Happy.jpg?q=50&fit=contain&w=1140&h=&dpr=1.5",
    ),
    CommonUIModel(
      title: "Okay so basically no need to come to my event",
      thirdLine: "19th May 2023, 10:00PM",
      body:
          "Join us as we embark on a delightful exploration of flavors, where every dish tells a unique story.",
      image:
          "https://media.gettyimages.com/id/99161157/photo/disneys-mickey-mouse-clubhouse-season-two.jpg?s=2048x2048&w=gi&k=20&c=e34BqiI7NWi9C5D7_xVTikfImc7V9KHiUEloOGmscOc=",
    ),
  ].obs;

  @override
  void initState() {
    super.initState();
    tabChildList = [
      // Event List
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Get.to(() => EventDetailsScreen()),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Event Image
            MyNetworkImage(
              fitType: BoxFit.cover,
              height: Dimensions.h130,
              image: listEvents[index].image!,
            ),

            // Event Title
            Padding(
              padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listEvents[index].title,
                    style: fontStyleSemiBold15.copyWith(
                        color: Get.theme.colorScheme.textColor),
                  ),

                  // Event Body
                  Text(
                    listEvents[index].body!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: fontStyleMedium12.copyWith(
                        color: Get.theme.colorScheme.hintTextColor),
                  ),
                  SizedBox(
                    height: Dimensions.h10,
                  ),

                  // Valid Up to
                  Text(
                    AppString.validUpTo,
                    style: fontStyleSemiBold13.copyWith(
                        color: Get.theme.colorScheme.textColor),
                  ),
                  Text(
                    listEvents[index].thirdLine!,
                    style: fontStyleMedium12.copyWith(
                        color: Get.theme.colorScheme.hintTextColor),
                  ),
                ],
              ),
            ),
          ]),
        ),
        itemCount: listEvents.length,
      ),
      // Event List
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Get.to(() => EventDetailsScreen()),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Event Image
            MyNetworkImage(
              fitType: BoxFit.cover,
              height: Dimensions.h130,
              image: listEvents[index].image!,
            ),

            // Event Title
            Padding(
              padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listEvents[index].title,
                    style: fontStyleSemiBold15.copyWith(
                        color: Get.theme.colorScheme.textColor),
                  ),

                  // Event Body
                  Text(
                    listEvents[index].body!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: fontStyleMedium12.copyWith(
                        color: Get.theme.colorScheme.hintTextColor),
                  ),
                  SizedBox(
                    height: Dimensions.h10,
                  ),

                  // Valid Up to
                  Text(
                    AppString.validUpTo,
                    style: fontStyleSemiBold13.copyWith(
                        color: Get.theme.colorScheme.textColor),
                  ),
                  Text(
                    listEvents[index].thirdLine!,
                    style: fontStyleMedium12.copyWith(
                        color: Get.theme.colorScheme.hintTextColor),
                  ),
                ],
              ),
            ),
          ]),
        ),
        itemCount: listEvents.length,
      ),
      // Event List
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Get.to(() => EventDetailsScreen()),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Event Image
            MyNetworkImage(
              fitType: BoxFit.cover,
              height: Dimensions.h130,
              image: listEvents[index].image!,
            ),

            // Event Title
            Padding(
              padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listEvents[index].title,
                    style: fontStyleSemiBold15.copyWith(
                        color: Get.theme.colorScheme.textColor),
                  ),

                  // Event Body
                  Text(
                    listEvents[index].body!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: fontStyleMedium12.copyWith(
                        color: Get.theme.colorScheme.hintTextColor),
                  ),
                  SizedBox(
                    height: Dimensions.h10,
                  ),

                  // Valid Up to
                  Text(
                    AppString.validUpTo,
                    style: fontStyleSemiBold13.copyWith(
                        color: Get.theme.colorScheme.textColor),
                  ),
                  Text(
                    listEvents[index].thirdLine!,
                    style: fontStyleMedium12.copyWith(
                        color: Get.theme.colorScheme.hintTextColor),
                  ),
                ],
              ),
            ),
          ]),
        ),
        itemCount: listEvents.length,
      ),
    ];
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animation!.addListener(() {
      tabIndex.value = _tabController.animation!.value.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.events,
            style: fontStyleSemiBold17.apply(
              color: Theme.of(context).colorScheme.textColor,
            )),
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.h28),
          child: Theme(
            data: ThemeData(useMaterial3: false),
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  physics: const ClampingScrollPhysics(),
                  controller: _tabController,
                  indicator: MD2Indicator(
                    indicatorColor: ColorConst.primaryColor,
                    indicatorHeight: Dimensions.h2,
                    indicatorSize: MD2IndicatorSize.tiny,
                  ),
                  // indicatorSize: TabBarIndicatorSize.label,
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    for (int i = 0; i < tabList.length; i++)
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: Dimensions.w20),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: ColorConst.primaryColor, width: 2))),
                        child: Obx(
                          () => Padding(
                            padding: EdgeInsets.only(bottom: Dimensions.h3),
                            child: Text(
                              tabList[i],
                              style: tabIndex.value == i
                                  ? fontStyleBold16.copyWith(
                                      color: Get.theme.colorScheme.textColor)
                                  : fontStyleSemiBold16.copyWith(
                                      color: Get.theme.colorScheme.textColor),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.h4,
                )
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabChildList,
      ),
    );
  }
}
