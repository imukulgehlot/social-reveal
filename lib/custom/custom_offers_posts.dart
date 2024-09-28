import 'dart:math' as math;

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../core/model/ui_model/category_model.dart';
import '../core/model/ui_model/user_post_model.dart';
import '../core/widgets/custom_image.dart';
import '../core/widgets/custom_switch_tile.dart';
import '../core/widgets/text_field/text_field/my_text_field_without_border.dart';

class CustomOffersPost extends StatefulWidget {
  final UserPostModel model;
  final bool? noComments;

  const CustomOffersPost(
      {super.key, required this.model, this.noComments = false});

  @override
  State<CustomOffersPost> createState() => _CustomUserPostState();
}

class _CustomUserPostState extends State<CustomOffersPost>
    with TickerProviderStateMixin {
  final RxBool isLiked = false.obs;
  final RxBool doubleTapLikeVisible = false.obs;

  final CustomPopupMenuController popupMenuController =
      CustomPopupMenuController();
  late AnimationController likeAnimationController;
  late AnimationController doubleTapLikeAnimationController;
  late Animation likeAnimation;
  late Animation doubleTapLikeAnimation;
  late final AnimationController _popupAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  final List<String> reactions = [
    ImageAsset.icCaringReact,
    ImageAsset.icInnovatorReact,
    ImageAsset.icUtilityReact,
    ImageAsset.icSpiritual,
    ImageAsset.icSocialReact
  ];
  final List<String> reactionsValues = [
    AppString.happy,
    AppString.laugh,
    AppString.wow,
    AppString.socialBuzz,
    AppString.love
  ];

  final RxList<CommonUIModel> reportReasonList = [
    CommonUIModel(title: "Harassment", isSelected: false),
    CommonUIModel(title: "Fraud or Scam", isSelected: false),
    CommonUIModel(title: "Scam", isSelected: false),
    CommonUIModel(title: "Misinformation", isSelected: false),
    CommonUIModel(title: "Hateful Speech", isSelected: false),
    CommonUIModel(title: "Threats or violence", isSelected: false),
    CommonUIModel(title: "Fake account", isSelected: false),
    CommonUIModel(title: "Sexual Content", isSelected: false),
    CommonUIModel(title: "Illegal Services", isSelected: false),
    CommonUIModel(title: "Child Detergent", isSelected: false),
    CommonUIModel(title: "Infringement or defamation", isSelected: false)
  ].obs;

  final RxBool longPressedForReaction = false.obs;

  @override
  void initState() {
    super.initState();
    likeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    doubleTapLikeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    final curve = CurvedAnimation(
      parent: likeAnimationController,
      curve: Curves.easeInCubic,
    );
    final doubleTapCurve = CurvedAnimation(
      parent: doubleTapLikeAnimationController,
      curve: Curves.easeInOut,
    );

    likeAnimation =
        Tween<double>(begin: 0, end: -30 * math.pi / 180).animate(curve);
    doubleTapLikeAnimation =
        Tween<double>(begin: 0.0, end: .2).animate(doubleTapCurve);
  }

  void likePost() => likeAnimationController.forward().then((value) {
        isLiked.value = !isLiked.value;
        likeAnimationController.reverse();
      });

  void doubleTapLikePost() {
    doubleTapLikeVisible.value = true;
    !isLiked.value
        ? likeAnimationController.forward().then((value) {
            isLiked.value = !isLiked.value;
            likeAnimationController.reverse();
          })
        : null;
    doubleTapLikeAnimationController.forward().then((value) {
      Future.delayed(const Duration(milliseconds: 500), () {
        doubleTapLikeVisible.value = false;
        doubleTapLikeAnimationController.reset();
      });
    });
  }

  late final List<CustomMenuModel> listPopMenu = [
    // Not Interested
    CustomMenuModel(
        title: AppString.notInterested,
        svgIcon: ImageAsset.icNotInterested,
        onTap: () {
          AppUtils.showCustomDialog(
              icon: ImageAsset.icDialogueQuestion,
              title: AppString.areYouSure,
              contentText: AppString.notInterestedAskNote,
              firstButtonText: AppString.markNotInterested,
              firstButtonFunction: () {
                AppUtils.showCustomDialog(
                    icon: ImageAsset.icDialogueChecked,
                    title: AppString.postMarked,
                    contentText: AppString.postMarkedSuccessNote);
              },
              secondButtonText: AppString.cancel);
        }),

    // Follow User
    CustomMenuModel(
        title: AppString.followUser,
        svgIcon: ImageAsset.icFollowUser,
        onTap: () {}),

    // Mute User
    CustomMenuModel(
        title: AppString.muteUser,
        svgIcon: ImageAsset.icMuteUser,
        onTap: () => AppUtils.openCustomBottomSheet(
            contentWidget: Column(
              children: [
                // Top Tile
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Mute Text
                    Text(
                      AppString.mute,
                      style: fontStyleSemiBold15.apply(
                          color: Get.theme.colorScheme.textColor),
                    ),

                    // Clear All Button
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        AppString.clearAll,
                        style: fontStyleMedium14.apply(
                            color: ColorConst.dialogRedColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.h8,
                ),

                // Mute User Switch
                CustomSwitchTile(
                  title: AppString.muteUser,
                  currentValue: false.obs,
                ),
                SizedBox(
                  height: Dimensions.h5,
                ),

                // Mute Posts Switch
                CustomSwitchTile(
                  title: AppString.mutePosts,
                  currentValue: false.obs,
                ),
                SizedBox(
                  height: Dimensions.h5,
                ),

                // Mute Videos Switch
                CustomSwitchTile(
                  title: AppString.muteVideos,
                  currentValue: false.obs,
                ),
                SizedBox(
                  height: Dimensions.h5,
                ),

                // Mute Chats Switch
                CustomSwitchTile(
                  title: AppString.muteChats,
                  currentValue: false.obs,
                ),

                SizedBox(
                  height: Dimensions.h50,
                ),
              ],
            ),
            fixedBottomWidget: // Apply Button
                MyButton(
              onPressed: () => Get.back(),
              title: AppString.apply,
              height: Dimensions.h32,
            ))),

    // Block User
    CustomMenuModel(
        title: AppString.blockUser,
        svgIcon: ImageAsset.icBlockUser,
        onTap: () {
          AppUtils.showCustomDialog(
              icon: ImageAsset.icDialogueQuestion,
              title: AppString.areYouSure,
              contentText: AppString.blockUserAskNote,
              firstButtonText: AppString.yesBlockUser,
              firstButtonFunction: () => AppUtils.showCustomDialog(
                  icon: ImageAsset.icDialogueChecked,
                  title: AppString.userBlocked,
                  contentText: AppString.blockUserSuccessNote),
              secondButtonText: AppString.cancel);
        }),

    // Report User
    CustomMenuModel(
        title: AppString.reportUser,
        svgIcon: ImageAsset.icReportUser,
        onTap: () => AppUtils.openCustomBottomSheet(
            contentWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Tile
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Reason Headline
                    Text(
                      AppString.selectReasonThatApplies,
                      style: fontStyleSemiBold14.apply(
                          color: Get.theme.colorScheme.textColor),
                    ),

                    // Clear All Button
                    TextButton(
                      onPressed: () {
                        for (var element in reportReasonList) {
                          element.isSelected = false;
                        }

                        reportReasonList.refresh();
                      },
                      child: Text(
                        AppString.clearAll,
                        style: fontStyleMedium13.apply(
                            color: ColorConst.dialogRedColor),
                      ),
                    ),
                  ],
                ),

                // SizedBox(
                //   height: Dimensions.h8,
                // ),

                // Reason
                Obx(
                  () => Wrap(
                    children: reportReasonList
                        .map((e) => Padding(
                              padding: EdgeInsets.only(right: Dimensions.w6),
                              child: ChoiceChip(
                                padding: EdgeInsets.symmetric(
                                    vertical: Dimensions.h5,
                                    horizontal: Dimensions.w8),
                                selectedColor: e.isSelected
                                    ? ColorConst.primaryColor
                                    : Get.theme.scaffoldBackgroundColor,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: e.isSelected
                                            ? ColorConst.primaryColor
                                            : Get.theme.colorScheme.textColor),
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.r20)),
                                showCheckmark: false,
                                onSelected: (value) {
                                  e.isSelected = value;
                                  reportReasonList.refresh();
                                },
                                label: Text(
                                  e.title,
                                  style: fontStyleMedium12.apply(
                                      color: e.isSelected
                                          ? ColorConst.whiteColor
                                          : Get.theme.colorScheme.textColor),
                                ),
                                selected: e.isSelected,
                              ),
                            ))
                        .toList(),
                  ),
                ),

                SizedBox(
                  height: Dimensions.h10,
                ),

                // Feedback TextField
                Text(
                  AppString.lookingForSomethingElse,
                  style: fontStyleSemiBold14.apply(
                      color: Get.theme.colorScheme.textColor),
                ),

                Text(
                  AppString.reportSubTitle,
                  style: fontStyleMedium12.apply(
                      color: Get.theme.colorScheme.textColor),
                ),

                SizedBox(
                  height: Dimensions.h10,
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.r8),
                    color: Get.theme.colorScheme.textFieldColor,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.w10, vertical: Dimensions.h10),
                  child: const MyTextFieldWithOutBorder(
                    maxLine: 3,
                    hintText: AppString.tellUsHere,
                    // textController: storyTextController.value,
                  ),
                ),

                SizedBox(
                  height: Dimensions.h30,
                ),
              ],
            ),
            fixedBottomWidget: // Submit Button
                MyButton(
                    onPressed: () => Get.back(),
                    cornerRadius: Dimensions.r10,
                    height: Dimensions.h32,
                    textStyle: fontStyleSemiBold14.copyWith(
                        color: Colors.white, fontSize: Dimensions.sp13),
                    title: AppString.submit))),
  ];

  @override
  void dispose() {
    popupMenuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Username Bar
        Padding(
          padding: EdgeInsets.all(Dimensions.w10)
              .copyWith(left: Dimensions.w20, right: Dimensions.w20),
          child: Row(
            children: [
              // User Profile
              Stack(children: [
                MyCircleNetworkImage(
                    radius: Dimensions.r25, image: widget.model.profileImage),
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
              SizedBox(
                width: Dimensions.w10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Name
                      Text(
                        widget.model.userName,
                        style: fontStyleSemiBold14.apply(
                            color: Theme.of(context).colorScheme.textColor),
                      ),
                    ],
                  ),

                  // Post Time
                  Text(
                    timeago.format(widget.model.dateTime),
                    style: fontStyleMedium10.apply(
                        color: Theme.of(context).colorScheme.hintTextColor),
                  ),
                ],
              ),
              Spacer(),
              Material(
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.r20)),
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.r20)),
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.all(Dimensions.h5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: Dimensions.h2,
                            color: ColorConst.primaryColor,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.r20))),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Send request",
                        style: fontStyleMedium12.copyWith(
                          color: ColorConst.primaryColor,
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            MyNetworkImage(
              fitType: BoxFit.cover,
              height: Dimensions.h240,
              image:
                  "https://static1.srcdn.com/wordpress/wp-content/uploads/2020/07/Avengers-Endgame-Tony-Funeral-Rhodes-Happy.jpg?q=50&fit=contain&w=1140&h=&dpr=1.5",
            ),
            Container(
              width: Get.width,
              decoration:
                  BoxDecoration(color: ColorConst.blackColor.withOpacity(0.8)),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      "Need an host for a food event that is going...",
                      style: fontStyleSemiBold14.copyWith(
                          color: ColorConst.whiteColor),
                    ),
                    // Event Body
                    SizedBox(height: Dimensions.h2),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.validUpTo,
                                style: fontStyleSemiBold12.copyWith(
                                    color: ColorConst.whiteColor),
                              ),
                              Text(
                                "19th May 2023, 10:00PM",
                                style: fontStyleMedium10.copyWith(
                                    color: ColorConst.whiteColor),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.OfferType,
                                style: fontStyleSemiBold12.copyWith(
                                    color: ColorConst.whiteColor),
                              ),
                              Text(
                                "Event Promotion",
                                style: fontStyleMedium10.copyWith(
                                    color: ColorConst.whiteColor),
                              ),
                            ],
                          ),
                        ]),
                    SizedBox(height: Dimensions.h2),
                    Text(
                      AppString.benefit_to_sponsee,
                      style: fontStyleSemiBold12.copyWith(
                          color: ColorConst.whiteColor),
                    ),
                    Text(
                      "I've an offer for you. Let's connect to discuss my vision about the event I am going to host for the community.",
                      style: fontStyleMedium10.copyWith(
                          color: ColorConst.whiteColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        )

        // Event Title
      ],
    );
  }
}

class CustomMenuModel {
  final String title;
  final String svgIcon;
  final Function onTap;

  CustomMenuModel(
      {required this.title, required this.svgIcon, required this.onTap});
}
