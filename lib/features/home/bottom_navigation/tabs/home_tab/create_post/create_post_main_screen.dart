import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../../../../core/widgets/custom_image.dart';
import '../../../../../../core/widgets/tab_indicator.dart';
import 'create_events_tab.dart';
import 'create_offers_tab.dart';
import 'create_post_tab.dart';
import 'create_services_tab.dart';

class CreatePostMainScreen extends StatefulWidget {
  const CreatePostMainScreen({super.key});

  @override
  State<CreatePostMainScreen> createState() => _CreatePostMainScreenState();
}

class _CreatePostMainScreenState extends State<CreatePostMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> tabList = [
    AppString.post,
    AppString.offers,
    AppString.events,
    AppString.services,
  ];
  late List<Widget> tabChildList;

  RxInt tabIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    tabChildList = [
      CreatePostTab(),
      const CreateOffersTab(),
      const CreateEventsTab(),
      CreateServicesTab(),
    ];
    _tabController = TabController(length: 4, vsync: this);
    _tabController.animation!.addListener(() {
      tabIndex.value = _tabController.animation!.value.round();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(tabList[tabIndex.value],
              style: fontStyleSemiBold17.apply(
                color: Theme.of(context).colorScheme.textColor,
              )),
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.h25),
          child: Theme(
            data: ThemeData(useMaterial3: false),
            child: TabBar(
              isScrollable: true,
              physics: const ClampingScrollPhysics(),
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
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.w20),
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
