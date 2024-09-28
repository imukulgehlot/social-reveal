import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../../../core/model/ui_model/category_model.dart';
import '../../../../../core/widgets/custom_image.dart';
import '../../../../../core/widgets/text_field/text_field/search_bar_text_field.dart';
import '../../../drawer_screen/navigation_drawer.dart';
import 'chatting_screen.dart';

class ChatTabScreen extends StatelessWidget {
  ChatTabScreen({super.key});

  late final RxList<CommonUIModel> listOfPeople = [
    CommonUIModel(
      title: "Joey Tribbiani",
      isSelected: true,
      body: "Is that why you should not drink buttermilk at night?",
      image:
          "https://i.guim.co.uk/img/media/ae14333615408ab5d5ba6c23810be683e0d6f631/389_282_1481_889/master/1481.jpg?width=620&dpr=1&s=none",
    ),
    CommonUIModel(
      title: "Rachel Green",
      isSelected: false,
      body: "Discover the benefits of morning yoga for a healthy start!",
      image: "https://randomuser.me/api/portraits/women/1.jpg",
    ),
    CommonUIModel(
      title: "Ross Geller",
      isSelected: false,
      body: "Why is hydration important for your fitness journey?",
      image: "https://randomuser.me/api/portraits/men/2.jpg",
    ),
    CommonUIModel(
      title: "Monica Geller",
      isSelected: false,
      body:
          "Explore the world of nutritious and delicious recipes for a fit lifestyle!",
      image: "https://randomuser.me/api/portraits/women/3.jpg",
    ),
    CommonUIModel(
      title: "Chandler Bing",
      isSelected: false,
      body:
          "Laugh your way to fitness - the importance of humor in your workout routine!",
      image: "https://randomuser.me/api/portraits/men/4.jpg",
    ),
    CommonUIModel(
      title: "Phoebe Buffay",
      isSelected: false,
      body:
          "Feel the positive vibes with music - an essential companion in your fitness journey!",
      image: "https://randomuser.me/api/portraits/women/5.jpg",
    ),
    CommonUIModel(
      title: "Joey Tribbiani",
      isSelected: false,
      body:
          "What's the secret to Joey's energy? Unveiling the diet and exercise routine!",
      image: "https://randomuser.me/api/portraits/men/6.jpg",
    ),
    CommonUIModel(
      title: "Janice Hosenstein",
      isSelected: false,
      body:
          "Stay motivated with Janice's fitness tips - the journey to a healthier you!",
      image: "https://randomuser.me/api/portraits/women/7.jpg",
    ),
    CommonUIModel(
      title: "Gunther",
      isSelected: false,
      body:
          "Brewing fitness: Gunther's guide to staying active in a coffee-centric world!",
      image: "https://randomuser.me/api/portraits/men/8.jpg",
    ),
    CommonUIModel(
      title: "Emily Waltham",
      isSelected: false,
      body:
          "Elegance meets fitness: Discover Emily's graceful approach to staying fit!",
      image: "https://randomuser.me/api/portraits/women/9.jpg",
    ),
    CommonUIModel(
      title: "Richard Burke",
      isSelected: false,
      body:
          "Age is just a number: Richard's wisdom on staying fit and healthy!",
      image: "https://randomuser.me/api/portraits/men/10.jpg",
    ),
    CommonUIModel(
      title: "Judy Geller",
      isSelected: false,
      body:
          "Mother knows best: Judy's insights into maintaining a healthy lifestyle!",
      image: "https://randomuser.me/api/portraits/women/11.jpg",
    ),
    CommonUIModel(
      title: "Mike Hannigan",
      isSelected: false,
      body:
          "From the streets to fitness: Mike's journey to a healthier and happier life!",
      image: "https://randomuser.me/api/portraits/men/12.jpg",
    ),
    CommonUIModel(
      title: "Erica Bing",
      isSelected: false,
      body: "Erica's fitness mantra: Balancing work, life, and well-being!",
      image: "https://randomuser.me/api/portraits/women/13.jpg",
    ),
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: Dimensions.w5,
        title: Text(
          AppString.chats,
          style: fontStyleSemiBold17.apply(
            color: Theme.of(context).colorScheme.textColor,
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: Dimensions.w10),
          child: IconButton(
            onPressed: () => openAppDrawer(),
            icon: CustomSvgAssetImage(
              image: ImageAsset.icDrawerIcon,
              color: Theme.of(context).colorScheme.textColor,
              width: Dimensions.w28,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.commonPaddingForScreen)
                  .copyWith(bottom: Dimensions.h5),
              child: SearchBarTextBoxField(
                height: Dimensions.h35,
                bgColor: Theme.of(context).colorScheme.textFieldColor,
                textController: Get.put(TextEditingController()),
                topLeftRadius: Dimensions.r15,
                topRightRadius: Dimensions.r15,
                bottomLeftRadius: Dimensions.r15,
                bottomRightRadius: Dimensions.r15,
                onChanged: (val) {},
                afterClearButton: () {},
                prefixIcon: const SizedBox(),
                hintText: AppString.searchPeople,
                hintTextColor: Theme.of(context).colorScheme.textColor,
                suffixIcon: CustomSvgAssetImage(
                  image: ImageAsset.icSearch,
                  height: Dimensions.w30,
                  width: Dimensions.w30,
                  color: Theme.of(context).colorScheme.textColor,
                ),
              ),
            ),

            // Chat List
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final chatPerson = listOfPeople[index];

                  return InkWell(
                    onTap: () => Get.to(() => ChattingScreen(
                          isActive: Random().nextBool(),
                          isPremium: index == 0 ? true : false,
                          name: chatPerson.title,
                          profileImage: chatPerson.image!,
                        )),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.commonPaddingForScreen,
                              vertical: Dimensions.h8),
                          child: Row(children: [
                            // Profile Picture
                            Hero(
                              tag: "ProfilePicChat${chatPerson.image}",
                              child: CustomRoundCornerNetworkImage(
                                image: chatPerson.image!,
                                radius: Dimensions.r30,
                                width: Dimensions.w55,
                                height: Dimensions.w55,
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.w11,
                            ),

                            Flexible(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Teacher Name & Time Ago
                                    Row(
                                      children: [
                                        // Name
                                        Text(
                                          chatPerson.title,
                                          maxLines: 1,
                                          style: fontStyleBold15.copyWith(
                                              color: Get
                                                  .theme.colorScheme.textColor),
                                        ),
                                        if (chatPerson.isSelected)
                                          SizedBox(
                                            width: Dimensions.w5,
                                          ),
                                        // Premium Badge
                                        if (chatPerson.isSelected)
                                          CustomSvgAssetImage(
                                            image: ImageAsset.icAddBadge,
                                            width: Dimensions.w15,
                                            height: Dimensions.w15,
                                          ),
                                        const Spacer(),
                                        // Time Ago
                                        Text(
                                          "2 hours ago",
                                          maxLines: 1,
                                          style: fontStyleMedium10.copyWith(
                                              color: Get
                                                  .theme.colorScheme.textColor),
                                        ),
                                      ],
                                    ),

                                    // Received Message
                                    Text(
                                      chatPerson.body!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: fontStyleBold12.copyWith(
                                          color: Get
                                              .theme.colorScheme.hintTextColor),
                                    ),
                                  ]),
                            ),
                          ]),
                        ),
                        MyDivider(
                          color: Get.theme.colorScheme.textFieldColor,
                        )
                      ],
                    ),
                  );
                },
                itemCount: listOfPeople.length),
          ],
        ),
      ),
    );
  }
}
