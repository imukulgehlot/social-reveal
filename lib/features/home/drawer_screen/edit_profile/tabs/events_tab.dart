import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../../../core/model/ui_model/category_model.dart';
import '../../../../../core/widgets/custom_image.dart';
import '../events/all_events_screen.dart';
import '../events/event_details_screen.dart';

class EventsTab extends StatelessWidget {
  EventsTab({super.key});

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
      title: AppString.groups,
      thirdLine: "19th May 2023, 10:00PM",
      body:
          "Join us as we embark on a delightful exploration of flavors, where every dish tells a unique story.",
      image:
          "https://media.gettyimages.com/id/99161157/photo/disneys-mickey-mouse-clubhouse-season-two.jpg?s=2048x2048&w=gi&k=20&c=e34BqiI7NWi9C5D7_xVTikfImc7V9KHiUEloOGmscOc=",
    ),
  ].obs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
      child: Column(
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
                  itemCount: listCategoriesAndTopics.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      listCategoriesAndTopics
                          .firstWhere((element) => element.isSelected == true)
                          .isSelected = false;

                      listCategoriesAndTopics[index].isSelected = true;
                      listCategoriesAndTopics.refresh();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.h2, horizontal: Dimensions.w18),
                      margin: EdgeInsets.only(
                          left: Dimensions.w16,
                          right: index == listCategoriesAndTopics.length - 1
                              ? Dimensions.w13
                              : 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.r25),
                        color: listCategoriesAndTopics[index].isSelected
                            ? ColorConst.primaryColor
                            : Get.theme.colorScheme.textFieldColor,
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Icon
                            CustomSvgAssetImage(
                              image: listCategoriesAndTopics[index].image ?? '',
                              width: Dimensions.w30,
                              height: Dimensions.w30,
                              color: listCategoriesAndTopics[index].isSelected
                                  ? ColorConst.whiteColor
                                  : Get.theme.colorScheme.textColor,
                            ),
                            SizedBox(
                              width: Dimensions.w5,
                            ),

                            // Category Name
                            Text(
                              listCategoriesAndTopics[index].title,
                              style: fontStyleBold13.apply(
                                  color:
                                      listCategoriesAndTopics[index].isSelected
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

          // Top Row
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.commonPaddingForScreen),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // All Events
                Text(
                  AppString.allEvents,
                  style: fontStyleSemiBold16.copyWith(
                      color: Get.theme.colorScheme.textColor),
                ),

                // View All Events
                TextButton(
                  onPressed: () => Get.to(() => const AllEventsScreen()),
                  child: Text(
                    AppString.viewAllEvents,
                    style: fontStyleSemiBold14.copyWith(
                        color: ColorConst.primaryColor),
                  ),
                ),
              ],
            ),
          ),

          // Events List
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Get.to(() => EventDetailsScreen()),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event Image
                    MyNetworkImage(
                      fitType: BoxFit.cover,
                      height: Dimensions.h130,
                      image: listEvents[index].image!,
                    ),

                    // Event Title
                    Padding(
                      padding:
                          EdgeInsets.all(Dimensions.commonPaddingForScreen),
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
          )
        ],
      ),
    );
  }
}
