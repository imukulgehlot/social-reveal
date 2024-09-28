import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../core/widgets/custom_image.dart';
import '../../../core/widgets/tab_indicator.dart';
import '../../../custom/custom_tab_bar_sliver_delegate.dart';
import '../bottom_navigation/tabs/home_tab/create_post/create_post_main_screen.dart';
import 'become_a_sponsor_screen.dart';
import 'edit_profile/edit_my_profile_screen.dart';
import 'edit_profile/follower_following/followers_followings_screen.dart';
import 'edit_profile/tabs/activity_tab.dart';
import 'edit_profile/tabs/award_point_tab.dart';
import 'edit_profile/tabs/business_info_tab.dart';
import 'edit_profile/tabs/events_tab.dart';
import 'edit_profile/tabs/my_nfts_tab.dart';
import 'edit_profile/tabs/offers_tab.dart';
import 'edit_profile/tabs/post_tab.dart';
import 'edit_profile/tabs/services_tab.dart';
import 'navigation_drawer.dart';

class MyProfileScreen extends StatefulWidget {
  final bool isNavigatedFromDrawer;
  final bool isMe;

  const MyProfileScreen(
      {super.key, this.isNavigatedFromDrawer = false, required this.isMe});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with SingleTickerProviderStateMixin {
  RxBool isFollowing = false.obs;
  late TabController _tabController;
  List<String> tabList = [
    AppString.post,
    AppString.awardPoint,
    AppString.offers,
    AppString.events,
    AppString.myNFTs,
    AppString.services,
    AppString.businessInfo,
    AppString.activity
  ];
  late List<Widget> tabChildList;
  RxInt tabIndex = 0.obs;

  RxBool showProfileInAppBar = false.obs;

  @override
  void initState() {
    super.initState();
    tabChildList = [
      const PostTab(),
      const AwardPointTab(),
      OffersTab(),
      EventsTab(),
      MyNFTsTab(),
      ServicesTab(),
      const BusinessInfoTab(),
      const ActivityTab()
    ];

    _tabController = TabController(length: 8, vsync: this);
    _tabController.animation!.addListener(() {
      tabIndex.value = _tabController.animation!.value.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          if (widget.isNavigatedFromDrawer) {
            goToDrawerHomeTab();
          } else {
            Get.back();
          }
        }
      },
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  // Appbar
                  SliverAppBar(
                    titleSpacing:0,
                    title: Obx(
                      () => SizedBox(
                          child: showProfileInAppBar.value
                              ? Row(
                                mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Profile Picture
                                        MyCircleNetworkImage(
                                          image:
                                              "https://www.themarysue.com/wp-content/uploads/2021/02/wanda-trauma.jpg?resize=1200%2C675",
                                          radius: Dimensions.r15,
                                        ).animate(effects: [
                                          const FadeEffect(begin: 0.25,end: 1,duration: Duration(milliseconds: 100))
                                        ]),

                                        Padding(
                                          padding: EdgeInsets.only(left: Dimensions.w7),
                                          child: Text(
                                            "theredwitch",
                                            style: fontStyleSemiBold16.copyWith(
                                              color: Get.theme.colorScheme.textColor,
                                            ),
                                          ).animate(effects: [
                                            const FadeEffect(begin: 0.25,end: 1,duration: Duration(milliseconds: 100))
                                          ]),
                                        ),
                                      ],
                                    )
                              : Text(
                                  AppString.profile,
                                  style: fontStyleSemiBold16.copyWith(
                                    color: Get.theme.colorScheme.textColor,
                                  ),
                                ).animate(effects: [
                      const FadeEffect(begin: 0.25,end: 1,delay: Duration(milliseconds: 20),duration: Duration(milliseconds: 200))
                        ])),
                    ),
                    leading: IconButton(
                      iconSize: Dimensions.w28,
                      icon: CustomSvgAssetImage(
                        image: ImageAsset.icBackArrowNav,
                        width: Dimensions.w28,
                        height: Dimensions.h28,
                        color: Theme.of(context).colorScheme.textColor,
                      ),
                      onPressed: widget.isNavigatedFromDrawer
                          ? goToDrawerHomeTab
                          : () => Get.back(),
                    ),
                    actions: [
                      IconButton(
                        iconSize: Dimensions.h30,
                        onPressed: () =>
                            Get.to(() => const CreatePostMainScreen()),
                        icon: CustomSvgAssetImage(
                          image: ImageAsset.icAddNew,
                          height: Dimensions.h30,
                          color: Theme.of(context).colorScheme.textColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.w8,
                      ),
                    ],
                    pinned: true,
                  ),

                  // Profile Pic, Name, Follower-Following
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.commonPaddingForScreen),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Picture & edit button
                          Row(
                            children: [
                              // Profile Picture
                              Hero(
                                tag: "wayToEditProfile",
                                child: MyCircleNetworkImage(
                                  image:
                                      "https://www.themarysue.com/wp-content/uploads/2021/02/wanda-trauma.jpg?resize=1200%2C675",
                                  radius: Dimensions.r35,
                                ),
                              ),

                              const Spacer(),

                              // Message Button
                              if (!widget.isMe)
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Get.theme.colorScheme.textFieldColor,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.w8,
                                      vertical: Dimensions.h5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.r15,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Get.to(() => EditMyProfileScreen());
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        AppString.message,
                                        style: fontStyleSemiBold11.apply(
                                          color:
                                              Get.theme.colorScheme.textColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.w4,
                                      ),
                                      CustomSvgAssetImage(
                                        image: ImageAsset.icMessage,
                                        width: Dimensions.w20,
                                        height: Dimensions.w20,
                                        color: Get.theme.colorScheme.textColor,
                                      ),
                                    ],
                                  ),
                                ),
                              if (!widget.isMe)
                                SizedBox(
                                  width: Dimensions.w8,
                                ),
                              // Edit Profile
                              if (widget.isMe)
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Get.theme.colorScheme.textFieldColor,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.w8,
                                      vertical: Dimensions.h5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.r15,
                                      ),
                                    ),
                                  ),
                                  onPressed: () =>
                                      Get.to(() => EditMyProfileScreen()),
                                  child: Row(
                                    children: [
                                      Text(
                                        AppString.editProfile,
                                        style: fontStyleSemiBold11.apply(
                                          color:
                                              Get.theme.colorScheme.textColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.w4,
                                      ),
                                      CustomSvgAssetImage(
                                        image: ImageAsset.icEditPen,
                                        width: Dimensions.w20,
                                        height: Dimensions.w20,
                                        color: Get.theme.colorScheme.textColor,
                                      ),
                                    ],
                                  ),
                                ),

                              // Follow Button
                              if (!widget.isMe)
                                Obx(
                                  () => TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: isFollowing.value
                                          ? ColorConst.primaryColor
                                          : Get
                                              .theme.colorScheme.textFieldColor,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.w8,
                                        vertical: Dimensions.h5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          Dimensions.r15,
                                        ),
                                      ),
                                    ),
                                    onPressed: () =>
                                        isFollowing.value = !isFollowing.value,
                                    child: Row(
                                      children: [
                                        Text(
                                          isFollowing.value
                                              ? AppString.following
                                              : "${AppString.follow} ",
                                          style: fontStyleSemiBold11.apply(
                                            color: isFollowing.value
                                                ? ColorConst.whiteColor
                                                : Get.theme.colorScheme
                                                    .textColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimensions.w4,
                                        ),
                                        CustomSvgAssetImage(
                                          image: ImageAsset.icFollowUser,
                                          width: Dimensions.w20,
                                          color: isFollowing.value
                                              ? ColorConst.whiteColor
                                              : Get.theme.colorScheme.textColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.h5,
                          ),

                          // User Name & Verification Badge
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Username
                              Text(
                                'Wanda Maximoff',
                                style: fontStyleSemiBold17.copyWith(
                                  color: Get.theme.colorScheme.textColor,
                                ),
                              ),

                              // Verification Badge
                              CustomSvgAssetImage(
                                image: ImageAsset.icVerificationBadge,
                                width: Dimensions.w30,
                              ),
                            ],
                          ),

                          // Username
                          Text(
                            'theredwitch',
                            style: fontStyleSemiBold13.copyWith(
                              height: Dimensions.h1,
                              color: Get.theme.colorScheme.textColor
                                  .withOpacity(0.60),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.h13,
                          ),

                          // Award Points, Followers, Following
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Award Points
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '285',
                                    style: fontStyleSemiBold15.apply(
                                      color: Get.theme.colorScheme.textColor,
                                    ),
                                  ),
                                  Text(
                                    AppString.awardPoints,
                                    style: fontStyleSemiBold12.copyWith(
                                      color:
                                          Get.theme.colorScheme.hintTextColor,
                                    ),
                                  ),
                                ],
                              ),

                              // Followers
                              GestureDetector(
                                onTap: () =>
                                    Get.to(() => FollowersFollowingsScreen(
                                          isFollowerScreen: true,
                                        )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '156',
                                      style: fontStyleSemiBold15.apply(
                                        color: Get.theme.colorScheme.textColor,
                                      ),
                                    ),
                                    Text(
                                      AppString.followers,
                                      style: fontStyleSemiBold12.copyWith(
                                        color:
                                            Get.theme.colorScheme.hintTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Following
                              InkWell(
                                onTap: () =>
                                    Get.to(() => FollowersFollowingsScreen(
                                          isFollowerScreen: false,
                                        )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '250',
                                      style: fontStyleSemiBold15.apply(
                                        color: Get.theme.colorScheme.textColor,
                                      ),
                                    ),
                                    Text(
                                      AppString.followings,
                                      style: fontStyleSemiBold12.copyWith(
                                        color:
                                            Get.theme.colorScheme.hintTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Filling Extra Space
                              SizedBox(
                                width: Dimensions.w50,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.h15,
                          ),

                          // Become A Sponsor Button | Invite Sponsee
                          widget.isMe
                              ? MyButton(
                                  onPressed: () =>
                                      Get.to(() => BecomeASponsorScreen()),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppString.getVerified,
                                        style: fontStyleSemiBold20.copyWith(
                                          color: ColorConst.whiteColor,
                                          fontSize: Dimensions.sp17,
                                        ),
                                      ),
                                      CustomSvgAssetImage(
                                        image: ImageAsset.icSponsorArt,
                                        width: Dimensions.w65,
                                        color: ColorConst.whiteColor,
                                      ),
                                    ],
                                  ),
                                )
                              : MyButton(
                                  onPressed: () {
                                    // return Get.to(() => BecomeASponsorScreen());
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppString.inviteSponsee,
                                        style: fontStyleSemiBold20.copyWith(
                                          color: ColorConst.whiteColor,
                                          fontSize: Dimensions.sp17,
                                        ),
                                      ),
                                      CustomSvgAssetImage(
                                        image: ImageAsset.icInvite,
                                        width: Dimensions.w30,
                                        color: ColorConst.whiteColor,
                                      ),
                                    ],
                                  ),
                                ),

                          SizedBox(
                            height: Dimensions.h25,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Tab Bar
                  SliverPersistentHeader(
                    delegate: CustomTabBarSliverDelegate(
                      maxHeight: Dimensions.h30,
                      minHeight: Dimensions.h30,
                      buildChild: (overLapsContent) {

                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) => showProfileInAppBar.value = overLapsContent);


                        return Material(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: TabBar(
                            dividerHeight: 0,
                            tabAlignment: TabAlignment.start,
                            isScrollable: true,
                            physics: const BouncingScrollPhysics(),
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
                            tabs: _buildTabList(),
                          ).animate(effects: [
                            const SlideEffect(
                                begin: Offset(0.2, 0),
                                end: Offset(0, 0),
                                curve: Curves.easeIn,
                                duration: Duration(milliseconds: 400))
                          ]),
                        );
                      },
                    ),
                    pinned: true,
                    floating: false,
                  ),
                ],
            body: TabBarView(
              controller: _tabController,
              children: tabChildList,
            )),
      ),
    );
  }

  // Helper method to build the list of tabs
  List<Widget> _buildTabList() {
    return List.generate(
      tabList.length,
      (index) => Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.w20),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(color: ColorConst.primaryColor, width: 2))),
        child: Column(
          children: <Widget>[
            Obx(
              () => Text(
                tabList[index],
                style: tabIndex.value == index
                    ? fontStyleBold16.copyWith(
                        color: Get.theme.colorScheme.textColor)
                    : fontStyleSemiBold16.copyWith(
                        color: Get.theme.colorScheme.textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
