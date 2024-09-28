import 'dart:math';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emoji;
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/model/ui_model/category_model.dart';
import 'package:rstsocial/custom/chat_date_container.dart';
import 'package:intl/intl.dart';

import '../../../../../core/widgets/custom_image.dart';

class ChattingScreen extends StatefulWidget {
  final String name;
  final String profileImage;
  final bool isActive;
  final bool isPremium;

  const ChattingScreen({
    super.key,
    required this.isPremium,
    required this.name,
    required this.profileImage,
    required this.isActive,
  });

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen>
    with SingleTickerProviderStateMixin {
  final messageController = TextEditingController();
  final chattingScrollController = ScrollController();
  final textScrollBar = ScrollController();
  final messageFocusNode = FocusNode();
  final canScrollToBottom = true.obs;
  final showEmojiBar = false.obs;

  late final messageList = [
    CommonUIModel(
      title:
          "When life gives you lemons, make a smoothie. Then take a nap. Because, health.",
      isSelected: true,
      dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    ),
    CommonUIModel(
      title:
          "I don't always exercise, but when I do, it's usually because the remote is too far.",
      isSelected: false,
      dateTime: DateTime.now().subtract(const Duration(minutes: 24)),
    ),
    CommonUIModel(
      title:
          "My favorite exercise is a cross between a lunge and a crunch. I call it lunch.",
      isSelected: true,
      dateTime: DateTime.now().subtract(const Duration(minutes: 23)),
    ),
    CommonUIModel(
      title:
          "Fitness tip: You're not lifting weights. You're lifting pizza slices into your mouth.",
      isSelected: false,
      dateTime: DateTime.now().subtract(const Duration(days: 4, minutes: 22)),
    ),
    CommonUIModel(
      title:
          "They say laughter is the best medicine. They lied. It's actually a good dose of chocolate.",
      isSelected: true,
      dateTime: DateTime.now().subtract(const Duration(minutes: 21)),
    ),
    CommonUIModel(
      title: "I'm on a seafood diet. I see food and I eat it.",
      isSelected: false,
      dateTime: DateTime.now().subtract(const Duration(minutes: 20)),
    ),
    CommonUIModel(
      title:
          "I thought I wanted a six-pack, but it turns out I just want six donuts.",
      isSelected: true,
      dateTime: DateTime.now().subtract(const Duration(minutes: 19)),
    ),
    CommonUIModel(
      title: "My favorite cardio is running late.",
      isSelected: false,
      dateTime: DateTime.now().subtract(const Duration(minutes: 18)),
    ),
    CommonUIModel(
      title:
          "I do yoga to relieve stress. Just kidding, I drink wine in yoga pants.",
      isSelected: true,
      dateTime: DateTime.now().subtract(const Duration(minutes: 17)),
    ),
    CommonUIModel(
      title: "I'm not lazy; I'm in energy-saving mode.",
      isSelected: false,
      dateTime: DateTime.now().subtract(const Duration(minutes: 16)),
    ),
    CommonUIModel(
      title: "I walk because punching people is frowned upon.",
      isSelected: false,
      dateTime: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    CommonUIModel(
      title: "I'm not a gym rat; I'm a gym unicorn.",
      isSelected: true,
      dateTime: DateTime.now().subtract(const Duration(minutes: 14)),
    ),
    CommonUIModel(
      title:
          "They say don't go to the grocery store hungry. That's why I work out on an empty stomach.",
      isSelected: false,
      dateTime: DateTime.now().subtract(const Duration(minutes: 13)),
    ),
    CommonUIModel(
      title: "I only exercise on days that end in 'Y'.",
      isSelected: true,
      dateTime: DateTime.now().subtract(const Duration(minutes: 12)),
    ),
    CommonUIModel(
      title: "I'm on a whiskey diet. I've lost three days already.",
      isSelected: true,
      dateTime: DateTime.now().subtract(const Duration(minutes: 11)),
    ),
    CommonUIModel(
      title: "I'm not fat; I'm just easier to see.",
      isSelected: false,
      dateTime: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    CommonUIModel(
      title:
          "My doctor told me to watch my drinking, so I'm off to find a bar with a mirror.",
      isSelected: true,
      dateTime: DateTime.now().subtract(const Duration(minutes: 9)),
    ),
    CommonUIModel(
      title:
          "I do squats because I want a booty. Also, I heard it's a great way to avoid conversations.",
      isSelected: true,
      dateTime: DateTime.now().subtract(const Duration(minutes: 8)),
    ),
    CommonUIModel(
      title: "I'm not running late; I'm on my own time zone.",
      isSelected: false,
      dateTime: DateTime.now().subtract(const Duration(minutes: 7)),
    ),
    CommonUIModel(
      title: "My idea of a balanced diet is a cookie in each hand.",
      isSelected: true,
      dateTime: DateTime.now().subtract(const Duration(minutes: 6)),
    ),
    CommonUIModel(
      title: "I'm not a jogger; I'm a dessert hunter.",
      isSelected: false,
      dateTime: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    CommonUIModel(
      title: "I would exercise, but it makes me spill my wine.",
      isSelected: true,
      dateTime: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    CommonUIModel(
      title: "I lift... forks to my mouth.",
      isSelected: false,
      dateTime: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
    CommonUIModel(
      title: "I'm not a gym person. My body is more of a museum for good food.",
      isSelected: false,
      dateTime: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    CommonUIModel(
      title: "Exercise? Oh, I thought you said extra fries.",
      isSelected: true,
      dateTime: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
  ].obs
    ..sort((a, b) => a.dateTime!.compareTo(b.dateTime!));

  late AnimationController emojiBarAnimationController;

  String formatMessageDate(DateTime date) {
    if (AppUtils.isSameDay(date, DateTime.now())) {
      return "Today";
    } else if (AppUtils.isSameDay(
        date, DateTime.now().subtract(const Duration(days: 1)))) {
      return "Yesterday";
    } else {
      return DateFormat("dd-MM-yyyy").format(date);
    }
  }

  @override
  void initState() {
    chattingScrollController.addListener(() {
      canScrollToBottom.value =
          chattingScrollController.position.maxScrollExtent -
                      chattingScrollController.position.pixels >
                  50
              ? true
              : false;
    });

    emojiBarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    super.initState();
  }

  @override
  void dispose() {
    chattingScrollController.dispose();
    messageController.dispose();
    textScrollBar.dispose();
    emojiBarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        if (!didPop) {
          if (showEmojiBar.value) {
            emojiBarAnimationController.reverse();
            showEmojiBar.value = false;
          } else {
            Get.back();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Row(
            children: [
              // Profile Picture
              Hero(
                tag: "ProfilePicChat${widget.profileImage}",
                child: CustomRoundCornerNetworkImage(
                  image: widget.profileImage,
                  radius: Dimensions.r30,
                  width: Dimensions.w40,
                  height: Dimensions.w40,
                ),
              ),
              SizedBox(
                width: Dimensions.w8,
              ),

              // Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name & Badge
                  Row(
                    children: [
                      // Name
                      Text(
                        widget.name,
                        style: fontStyleSemiBold16.apply(
                          color: Theme.of(context).colorScheme.textColor,
                        ),
                      ),

                      // Premium
                      if (widget.isPremium)
                        Padding(
                          padding: EdgeInsets.only(left: Dimensions.w5),
                          child: CustomSvgAssetImage(
                            image: ImageAsset.icAddBadge,
                            width: Dimensions.w18,
                            height: Dimensions.w18,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.h1,
                  ),
                  Text(
                    widget.isActive ? AppString.active : "9m ago",
                    style: fontStyleSemiBold17.copyWith(
                      fontSize: Dimensions.sp10,
                      color: widget.isActive
                          ? ColorConst.themeGreen
                          : Theme.of(context).colorScheme.hintTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          leading: IconButton(
            icon: CustomSvgAssetImage(
              image: ImageAsset.icBackArrowNav,
              width: Dimensions.w28,
              height: Dimensions.h28,
              color: Theme.of(context).colorScheme.textColor,
            ),
            onPressed: () => Get.back(),
          ),
          actions: [
            IconButton(
              icon: RotatedBox(
                quarterTurns: 1,
                child: CustomSvgAssetImage(
                  image: ImageAsset.icMore,
                  width: Dimensions.w22,
                  height: Dimensions.w22,
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
        body: Obx(
          () => Column(
            children: [
              // Message List
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    right: Dimensions.w17,
                    left: Dimensions.w17,
                    top: Dimensions.w17,
                    bottom: Dimensions.w17,
                  ),
                  // reverse: true,
                  controller: chattingScrollController,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    final presentMessage = messageList[index];

                    final DateTime? lastIndexDate =
                        index != 0 ? messageList[index - 1].dateTime : null;

                    final areLastTwoNodesSame = index == 0
                        ? false
                        : messageList[index].isSelected ==
                                messageList[index - 1].isSelected
                            ? false
                            : true;

                    return Column(
                      children: [
                        /// Date Thingy

                        // For Initial/ First Message
                        if (lastIndexDate == null)
                          ChatDateContainer(
                            dateString: formatMessageDate(
                              presentMessage.dateTime!,
                            ),
                            hideTopPadding: true,
                          ),

                        // In-between date changes
                        if (lastIndexDate != null &&
                            AppUtils.isSameDay(
                                    lastIndexDate, presentMessage.dateTime!) ==
                                false)
                          ChatDateContainer(
                              dateString: formatMessageDate(
                            presentMessage.dateTime!,
                          )),

                        // Message Container
                        Container(
                          margin: EdgeInsets.only(
                              top: areLastTwoNodesSame
                                  ? Dimensions.h4
                                  : Dimensions.h10),
                          child: Row(
                            mainAxisAlignment: presentMessage.isSelected
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              presentMessage.isSelected
                                  ?
                                  // Sent By Me
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // Message Time
                                        Row(
                                          children: [
                                            Text(
                                              DateFormat.jm().format(
                                                  presentMessage.dateTime!),
                                              style: fontStyleMedium10.copyWith(
                                                  fontSize: Dimensions.sp10,
                                                  color: Get.theme.colorScheme
                                                      .hintTextColor),
                                            ),
                                            SizedBox(
                                              width: Dimensions.w5,
                                            ),
                                          ],
                                        ),

                                        // Message Container
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: Dimensions.h5,
                                            horizontal: Dimensions
                                                    .commonPaddingForScreen -
                                                Dimensions.w5,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                  Dimensions.r15,
                                                ),
                                                bottomRight: Radius.circular(
                                                  Dimensions.r15,
                                                ),
                                                topLeft: Radius.circular(
                                                  Dimensions.r15,
                                                ),
                                                topRight: Radius.circular(
                                                  Dimensions.r5,
                                                ),
                                              ),
                                              color: presentMessage.isSelected
                                                  ? ColorConst.primaryColor
                                                  : ColorConst.textFieldColor),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              // Message
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: Get.width * 0.50,
                                                  minWidth: Dimensions.w10,
                                                ),
                                                child: Text(
                                                  presentMessage.title,
                                                  style: fontStyleMedium12
                                                      .copyWith(
                                                          color: ColorConst
                                                              .whiteColor,
                                                          fontSize: /*isSingleEmoji(
                                                                  presentMessage
                                                                      .title
                                                                      .trim())
                                                              ? Dimensions.sp15
                                                              : */
                                                              Dimensions.sp12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  :
                                  // Received By Me lol
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Message Time
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: Dimensions.w5,
                                            ),
                                            Text(
                                              DateFormat.jm().format(
                                                  presentMessage.dateTime!),
                                              style: fontStyleMedium10.copyWith(
                                                  fontSize: Dimensions.sp10,
                                                  color: Get.theme.colorScheme
                                                      .hintTextColor),
                                            ),
                                          ],
                                        ),

                                        // Message Container
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: Dimensions.h5,
                                            horizontal: Dimensions
                                                    .commonPaddingForScreen -
                                                Dimensions.w5,
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                  Dimensions.r15,
                                                ),
                                                bottomRight: Radius.circular(
                                                  Dimensions.r15,
                                                ),
                                                topLeft: Radius.circular(
                                                  Dimensions.r5,
                                                ),
                                                topRight: Radius.circular(
                                                  Dimensions.r15,
                                                ),
                                              ),
                                              color: Get.theme.colorScheme
                                                  .textFieldColor),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              // Message
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: Get.width * 0.50,
                                                  minWidth: Dimensions.w10,
                                                ),
                                                child: Text(
                                                  textAlign:
                                                      presentMessage.isSelected
                                                          ? TextAlign.right
                                                          : TextAlign.left,
                                                  presentMessage.title,
                                                  style: fontStyleMedium12
                                                      .copyWith(
                                                          color: Get
                                                              .theme
                                                              .colorScheme
                                                              .textColor,
                                                          fontSize: /*isSingleEmoji(
                                                                  presentMessage
                                                                      .title)
                                                              ? Dimensions.sp15
                                                              :*/
                                                              Dimensions.sp12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Send Bar
              SafeArea(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Send Message Bar
                    Container(
                      color: Get.theme.colorScheme.textFieldColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.w13, vertical: Dimensions.h2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Emoticons Button 🙉
                          IconButton(
                            onPressed: () {
                              AppUtils.closeKeyboard();

                              Future.delayed(const Duration(milliseconds: 150),
                                  () {
                                if (showEmojiBar.value) {
                                  emojiBarAnimationController.reverse();
                                  showEmojiBar.value = false;

                                  // Open Keyboard on Message Text Field
                                  FocusScope.of(context)
                                      .requestFocus(messageFocusNode);
                                } else {
                                  emojiBarAnimationController.forward();
                                  showEmojiBar.value = true;
                                }
                              });
                            },
                            highlightColor: Colors.amberAccent.withOpacity(0.1),
                            icon: IgnorePointer(
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: showEmojiBar.value
                                    ? CustomSvgAssetImage(
                                        image: ImageAsset.icKeyboard,
                                        width: Dimensions.w30,
                                        color: Get.theme.colorScheme.textColor,
                                        onTap: () {},
                                      )
                                    : CustomSvgAssetImage(
                                        image: ImageAsset.icEmoji,
                                        width: Dimensions.w33,
                                        color: Get.theme.colorScheme.textColor,
                                        height: Dimensions.w33,
                                        onTap: () {},
                                      ),
                              ),
                            ),
                          ),

                          // Message Field
                          Flexible(
                            child: RawScrollbar(
                              thumbColor: Get.theme.colorScheme.hintTextColor,
                              mainAxisMargin: Dimensions.w7,
                              crossAxisMargin: Dimensions.w5,
                              thickness: Dimensions.w3,
                              thumbVisibility: true,
                              radius: Radius.circular(Dimensions.r100),
                              controller: textScrollBar,
                              child: TextFormField(
                                onTap: () {
                                  if (showEmojiBar.value) {
                                    showEmojiBar.value = false;
                                    emojiBarAnimationController.reverse();
                                  }
                                },
                                focusNode: messageFocusNode,
                                scrollController: textScrollBar,
                                minLines: 1,
                                maxLines: 3,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                keyboardType: TextInputType.multiline,
                                controller: messageController,
                                onChanged: (value) {},
                                textInputAction: TextInputAction.newline,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.commonPaddingForScreen -
                                            Dimensions.w6,
                                    vertical:
                                        Dimensions.commonPaddingForScreen -
                                            Dimensions.w6,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.circular(Dimensions.r20),
                                  ),
                                  fillColor:
                                      Get.theme.colorScheme.textFieldColor,
                                  filled: true,
                                  hintStyle: fontStyleMedium12.copyWith(
                                      color:
                                          Get.theme.colorScheme.hintTextColor),
                                  hintText: AppString.typeSomethingHere,
                                ),
                                style: fontStyleMedium12.copyWith(
                                    color: Get.theme.colorScheme.textColor),
                              ),
                            ),
                          ),

                          // Send Button
                          IconButton(
                            onPressed: sendMessage,
                            icon: IgnorePointer(
                              child: CustomSvgAssetImage(
                                image: ImageAsset.icSend,
                                width: Dimensions.w33,
                                color: Get.theme.colorScheme.textColor,
                                height: Dimensions.w33,
                                onTap: () {},
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // Emoji
                    Obx(
                      () => showEmojiBar.value
                          ? SlideTransition(
                              position: Tween<Offset>(
                                      begin: const Offset(0, 2),
                                      end: const Offset(0, 0))
                                  .animate(CurvedAnimation(
                                      parent: emojiBarAnimationController,
                                      curve: Curves.easeIn)),
                              child: SizedBox(
                                height: Get.height * 0.35,
                                child: emoji.EmojiPicker(
                                  onEmojiSelected: (category, emoji) {},
                                  onBackspacePressed: () {
                                    // Do something when the user taps the backspace button (optional)
                                    // Set it to null to hide the Backspace-Button
                                  },
                                  textEditingController: messageController,
                                  config: emoji.Config(
                                    columns: 7,
                                    emojiSizeMax: 32 *
                                        (foundation.defaultTargetPlatform ==
                                                TargetPlatform.iOS
                                            ? 1.30
                                            : 1.0),
                                    verticalSpacing: 0,
                                    horizontalSpacing: 0,
                                    gridPadding: EdgeInsets.zero,
                                    initCategory: emoji.Category.RECENT,
                                    bgColor:
                                        Get.theme.colorScheme.textFieldColor,
                                    indicatorColor: ColorConst.primaryColor,
                                    iconColor: Colors.grey,
                                    iconColorSelected: ColorConst.primaryColor,
                                    backspaceColor: ColorConst.primaryColor,
                                    skinToneDialogBgColor:
                                        Get.theme.colorScheme.textFieldColor,
                                    skinToneIndicatorColor: Colors.grey,
                                    enableSkinTones: true,
                                    recentTabBehavior:
                                        emoji.RecentTabBehavior.RECENT,
                                    recentsLimit: 28,
                                    noRecents: const Text(
                                      'No Recents',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black26),
                                      textAlign: TextAlign.center,
                                    ),
                                    // Needs to be const Widget
                                    loadingIndicator: const SizedBox.shrink(),
                                    // Needs to be const Widget
                                    tabIndicatorAnimDuration:
                                        kTabScrollDuration,
                                    categoryIcons: const emoji.CategoryIcons(),
                                    buttonMode: emoji.ButtonMode.MATERIAL,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Obx(
          () => canScrollToBottom.value
              ? Padding(
                  padding: EdgeInsets.only(
                      right: Dimensions.w10,
                      bottom: Dimensions.h45 +
                          (showEmojiBar.value ? Get.height * 0.33 : 0)),
                  child: GestureDetector(
                    onTap: scrollToBottom,
                    child: Icon(Icons.arrow_drop_down_circle_rounded,
                            color: Get.theme.colorScheme.inversePrimary,
                            fill: 0,
                            size: Dimensions.w40)
                        .animate(effects: [
                      const FadeEffect(),
                    ]),
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  // bool isSingleEmoji(String input) {
  //   if (input.isEmpty || input.length > 2) {
  //     return false;
  //   }
  //
  //   final codeUnit = input.codeUnitAt(0);
  //
  //   logger.wtf(
  //       "Is $input Emozy: ${(codeUnit >= 0x1F300 && codeUnit <= 0x1F6FF) || (codeUnit >= 0x1F900 && codeUnit <= 0x1F9FF) || (codeUnit >= 0x2600 && codeUnit <= 0x26FF) || (codeUnit >= 0x2700 && codeUnit <= 0x27BF)}");
  //
  //   // Check if the character is in the emoji range
  //   return (codeUnit >= 0x1F300 && codeUnit <= 0x1F6FF) ||
  //       (codeUnit >= 0x1F900 && codeUnit <= 0x1F9FF) ||
  //       (codeUnit >= 0x2600 && codeUnit <= 0x26FF) ||
  //       (codeUnit >= 0x2700 && codeUnit <= 0x27BF);
  // }

  sendMessage() async {
    if (messageController.text.trim().isNotEmpty) {
      AppUtils.closeKeyboard();
      emojiBarAnimationController.reverse();
      showEmojiBar.value = false;
      scrollToBottom();

      messageList.add(CommonUIModel(
          title: messageController.text,
          dateTime: DateTime.now(),
          isSelected: true));
      messageController.clear();
      messageList.refresh();

      // Receiving Demo Message
      Future.delayed(const Duration(milliseconds: 2200), () {
        messageList.add(CommonUIModel(
            title: getRandomHealthHumorMessage(),
            dateTime: DateTime.now(),
            isSelected: false));
        messageList.refresh();
      }).then((value) => Future.delayed(
          const Duration(milliseconds: 800), () => scrollToBottom()));
    }
  }

  scrollToBottom() {
    chattingScrollController.animateTo(
        chattingScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn);
  }

  String getRandomHealthHumorMessage() {
    final random = Random();
    final healthMessages = [
      "I joined a health club last year. Haven't lost a pound. Apparently, I have to show up. 🏋️‍♂️",
      "My favorite exercise is a cross between a lunge and a crunch. I call it lunch. 🍔",
      "I'm on a whiskey diet. I've lost three days already. 🥃",
      "They say laughter is the best medicine, so I guess my abs are getting a great workout. 😄",
      "I tried to do yoga at home, but I kept getting interrupted by downward-facing dog demanding to go outside. 🐶",
      "I'm not lazy. I'm in energy-saving mode. ⚡",
      "I have a condition that prevents me from going to the gym. It's called being lazy. 😴",
      "I walk because punching people is frowned upon. 👟",
      "I have a love-hate relationship with the gym. I love to hate it. ❤️💔",
      "I started a new diet. It's called the 'I put my fork down and pushed my plate away' diet. 🍽️"
    ];

    return healthMessages[random.nextInt(healthMessages.length)];
  }
}
