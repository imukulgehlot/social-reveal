import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../core/widgets/custom_image.dart';
import 'navigation_drawer.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

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
              AppString.notifications,
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
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
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
                          borderRadius: BorderRadius.circular(Dimensions.r10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(Dimensions.r10),
                            onTap: () => (),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.w15),
                              height: Dimensions.h140,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomNetworkImage(
                                      height: Dimensions.w100,
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
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Participated in Event",
                                            style: fontStyleSemiBold16.copyWith(
                                                color: Get.theme.colorScheme
                                                    .textColor),
                                            maxLines: 1,
                                          ),
                                          Text(
                                            "Need a host for an food event that is food event that...",
                                            style: fontStyleMedium12.copyWith(
                                                color: Get.theme.colorScheme
                                                    .textColor),
                                            maxLines: 2,
                                          ),
                                          SizedBox(
                                            height: Dimensions.h5,
                                          ),
                                          Text(
                                            "2 Hours Ago",
                                            style: fontStyleRegular10.copyWith(
                                                color: Get
                                                    .theme.colorScheme.textColor
                                                    .withOpacity(0.8)),
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
          )),
    );
  }
}
