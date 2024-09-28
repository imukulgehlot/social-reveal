import 'dart:math' as math;

// import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/model/ui_model/user_post_model.dart';
import 'package:rstsocial/core/utils/logger_util.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';
import 'package:rstsocial/custom/custom_comment_card.dart';
import 'package:rstsocial/features/home/drawer_screen/my_profile_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../core/model/ui_model/category_model.dart';
import '../core/widgets/custom_switch_tile.dart';
import '../core/widgets/text_field/text_field/my_text_field_without_border.dart';

class PostTile extends StatefulWidget {
  final UserPostModel model;
  final bool? noComments;

  const PostTile(
      {super.key, required this.model, this.noComments = false});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile>
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

  final Map<String, String> reactionIcons = {
    AppString.happy: ImageAsset.icCaringReact,
    AppString.laugh: ImageAsset.icInnovatorReact,
    AppString.wow: ImageAsset.icUtilityReact,
    AppString.socialBuzz: ImageAsset.icSpiritual,
    AppString.love: ImageAsset.icSocialReact
  };

  RxString selectedReaction = "".obs;

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
    CommonUIModel(title: "Child Endangerment", isSelected: false),
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

    // BackButtonInterceptor.add(myInterceptor);
  }

  void likePost() => likeAnimationController.forward().then((value) {
        if (isLiked.value && selectedReaction.value != "") {
          selectedReaction.value = "";
        }
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
        onTap: () => AppUtils.showCustomDialog(
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
            secondButtonText: AppString.cancel)),

    // Follow User
    CustomMenuModel(
        title: AppString.followUser,
        svgIcon: ImageAsset.icFollowUser,
        onTap: () {}),

    // Mute User
    CustomMenuModel(
        title: AppString.muteUser,
        svgIcon: ImageAsset.icMuteUser,
        onTap: () {
          final muteUser = false.obs;
          final mutePosts = false.obs;
          final muteVideos = false.obs;
          final muteChats = false.obs;

          return AppUtils.openCustomBottomSheet(
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
                        onPressed: () {
                          muteUser.value = false;
                          mutePosts.value = false;
                          muteVideos.value = false;
                          muteChats.value = false;
                        },
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
                    currentValue: muteUser,
                  ),
                  SizedBox(
                    height: Dimensions.h5,
                  ),

                  // Mute Posts Switch
                  CustomSwitchTile(
                    title: AppString.mutePosts,
                    currentValue: mutePosts,
                  ),
                  SizedBox(
                    height: Dimensions.h5,
                  ),

                  // Mute Videos Switch
                  CustomSwitchTile(
                    title: AppString.muteVideos,
                    currentValue: muteVideos,
                  ),
                  SizedBox(
                    height: Dimensions.h5,
                  ),

                  // Mute Chats Switch
                  CustomSwitchTile(
                    title: AppString.muteChats,
                    currentValue: muteChats,
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
              ));
        }),

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

  // bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
  //   if (popupMenuController.menuIsShowing) {
  //     popupMenuController.hideMenu();
  //   }
  //
  //   return !popupMenuController.menuIsShowing;
  // }

  @override
  void dispose() {
    popupMenuController.dispose();
    // BackButtonInterceptor.remove(myInterceptor);
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Get.to(() => const MyProfileScreen(
                      isMe: false,
                    )),
                behavior: HitTestBehavior.translucent,
                child: Row(
                  children: [
                    // User Profile
                    MyCircleNetworkImage(
                        radius: Dimensions.r25,
                        image: widget.model.profileImage),
                    SizedBox(
                      width: Dimensions.w10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Name
                            Text(
                              widget.model.userName,
                              style: fontStyleSemiBold14.apply(
                                  color:
                                      Theme.of(context).colorScheme.textColor),
                            ),
                            SizedBox(
                              width: Dimensions.w5,
                            ),
                            widget.model.isPrimeMember
                                ? CustomSvgAssetImage(
                                    image: ImageAsset.icAddBadge,
                                    height: Dimensions.w16,
                                  )
                                : const SizedBox()
                          ],
                        ),

                        // Post Time
                        Text(
                          timeago.format(widget.model.dateTime),
                          style: fontStyleMedium10.apply(
                              color:
                                  Theme.of(context).colorScheme.hintTextColor),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              CustomPopupMenu(
                  showArrow: false,
                  menuOnChange: (isMenuShowing) {
                    if (!isMenuShowing) {
                      _popupAnimationController.reset();
                    }
                  },
                  controller: popupMenuController,
                  menuBuilder: () {
                    return ScaleTransition(
                      scale: Tween<double>(begin: 0.8, end: 1.0)
                          .animate(CurvedAnimation(
                        parent: _popupAnimationController,
                        curve: Curves.easeOutSine,
                      )),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: Dimensions.h8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.r15),
                            color: Get.theme.colorScheme.dialogColor),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: listPopMenu
                                .map((e) => InkWell(
                                      onTap: () {
                                        // Reverse Animation & Close Menu
                                        _popupAnimationController.reset();

                                        popupMenuController.hideMenu();

                                        e.onTap.call();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Dimensions.w5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // Icon
                                                CustomSvgAssetImage(
                                                  image: e.svgIcon,
                                                  color: Get.theme.colorScheme
                                                      .textColor,
                                                  width: Dimensions.w25,
                                                  height: Dimensions.w25,
                                                ),
                                                SizedBox(
                                                  width: Dimensions.w5,
                                                ),

                                                // Title
                                                Text(
                                                  e.title,
                                                  textAlign: TextAlign.start,
                                                  style:
                                                      fontStyleSemiBold12.apply(
                                                          color: Get
                                                              .theme
                                                              .colorScheme
                                                              .textColor),
                                                ),
                                                SizedBox(
                                                  width: Dimensions.w5,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: Dimensions.h4),
                                            if (e.svgIcon !=
                                                ImageAsset.icReportUser)
                                              // Divider
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: Dimensions.w30,
                                                  ),
                                                  Container(
                                                    height: Dimensions.h1,
                                                    width: Dimensions.w120,
                                                    decoration: BoxDecoration(
                                                        color: Get
                                                            .theme
                                                            .colorScheme
                                                            .textFieldColor),
                                                  ),
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList()),
                      ),
                    );
                  },
                  horizontalMargin: Dimensions.w48,
                  verticalMargin: -Dimensions.h70,
                  pressType: PressType.singleClick,
                  child: GestureDetector(
                    onTap: () {
                      popupMenuController.showMenu();
                      _popupAnimationController.forward();
                    },
                    child: CustomSvgAssetImage(
                      image: ImageAsset.icMore,
                      height: Dimensions.w30,
                      width: Dimensions.w30,
                      color: Theme.of(context).colorScheme.textColor,
                    ),
                  )),
            ],
          ),
        ),

        // Posted Image on feed
        GestureDetector(
          onDoubleTap: doubleTapLikePost,
          child: SizedBox(
            child: Stack(
              children: [
                widget.model.postImage != null
                    ? AspectRatio(
                        aspectRatio: 1 / 1,
                        child: CustomNetworkImage(
                          image: widget.model.postImage!,
                          fitType: BoxFit.cover,
                          // height: ,
                        ))
                    : const SizedBox(),
                Positioned(
                  top: 1,
                  bottom: 1,
                  left: 1,
                  right: 1,
                  child: AnimatedBuilder(
                    animation: doubleTapLikeAnimation,
                    builder: (context, child) => Obx(
                      () => Transform.scale(
                        scale: doubleTapLikeAnimation.value,
                        child: doubleTapLikeVisible.value
                            ? CustomSvgAssetImage(
                                image: ImageAsset.icLiked,
                                height: Dimensions.w40,
                                width: Dimensions.w40,
                                color:  ColorConst.primaryColor,
                                // color: Colors.white,
                              )
                            : const SizedBox(),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       image: DecorationImage(
                //           image: CachedNetworkImageProvider(widget.model.postImage),
                //           fit: BoxFit.cover)),
                // ),
              ],
            ),
          ),
        ),

        // POST CAPTION
        Padding(
          padding: EdgeInsets.all(Dimensions.w10).copyWith(
              left: Dimensions.commonPaddingForScreen,
              right: Dimensions.commonPaddingForScreen),
          child: Text(
            widget.model.caption,
            style: fontStyleSemiBold13.apply(
                color: Theme.of(context).colorScheme.textColor),
          ),
        ),

        !widget.noComments!
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.model.comments.length >= 2
                    ? 2
                    : widget.model.comments.length,
                itemBuilder: (context, index) => CustomCommentCard(
                  model: widget.model.comments[index],
                ),
              )
            : const SizedBox(),

        // LIKES AND REPLIES BUTTON
        Row(
          children: [
            ReactionButton(
              onReactionChanged: (Reaction<String>? reaction) {
                selectedReaction.value = reaction?.value ?? "";
                isLiked.value = true;
                debugPrint('Selected value: ${reaction?.value}');
              },
              boxColor: Get.theme.colorScheme.likeButtonBorderColor,
              reactions: <Reaction<String>>[
                for (int i = 0; i < reactions.length; i++)
                  Reaction<String>(
                    value: reactionsValues[i],
                    icon: CustomSvgAssetImage(
                      image: reactions[i],
                    ),
                  ),
              ],
              itemsSpacing: Dimensions.w10,
              boxPadding: EdgeInsets.symmetric(
                  horizontal: Dimensions.w15, vertical: Dimensions.h5),
              itemSize: Size(Dimensions.w33, Dimensions.h33),
              child: GestureDetector(
                onTap: likePost,
                child: Container(
                  height: Dimensions.h40,
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Get.theme.colorScheme.likeButtonBorderColor),
                      color: Get.theme.colorScheme.buttonGrey),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        selectedReaction.value == "" || !isLiked.value
                            ? AnimatedBuilder(
                                animation: likeAnimation,
                                builder: (context, child) => Transform.rotate(
                                  alignment: Alignment.bottomLeft,
                                  angle: likeAnimation.value,
                                  child: CustomSvgAssetImage(
                                    color: isLiked.value
                                        ? ColorConst.primaryColor
                                        : Theme.of(context)
                                            .colorScheme
                                            .textColor,
                                    image: isLiked.value
                                        ? ImageAsset.icLiked
                                        : ImageAsset.icLike,
                                    height: Dimensions.w23,
                                    width: Dimensions.w23,
                                  ),
                                ),
                              )
                            : Obx(
                                () => Padding(
                                  padding: EdgeInsets.only(right: Dimensions.w4),
                                  child: CustomSvgAssetImage(
                                    image: reactionIcons[selectedReaction.value]!,
                                    height: Dimensions.w30,
                                    width: Dimensions.w30,
                                  ),
                                ),
                              ),
                        //here
                        Obx(
                          () => Text(
                            isLiked.value
                                ? (widget.model.likes + 1).toString()
                                : widget.model.likes.toString(),
                            style: fontStyleSemiBold13.apply(
                                color: Theme.of(context).colorScheme.textColor),
                          ),
                        ),
                        //here
                        Text(
                          " Likes",
                          style: fontStyleSemiBold13.apply(
                              color: Theme.of(context).colorScheme.textColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: Dimensions.h40,
              width: Get.width / 2,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Get.theme.colorScheme.likeButtonBorderColor),
                  color: Get.theme.colorScheme.buttonGrey),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomSvgAssetImage(
                      image: ImageAsset.icReplies,
                      height: Dimensions.w23,
                      width: Dimensions.w23,
                      color: Theme.of(context).colorScheme.textColor),

                  Text(
                    widget.model.replies.toString(),
                    style: fontStyleSemiBold13.apply(
                        color: Theme.of(context).colorScheme.textColor),
                  ),
                  //here
                  Text(
                    " Replies",
                    style: fontStyleSemiBold13.apply(
                        color: Theme.of(context).colorScheme.textColor),
                  )
                ],
              ),
            )
          ],
        )
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
