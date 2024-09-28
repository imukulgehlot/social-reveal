import 'package:flutter/material.dart';

import '../core/basic_features.dart';

class ChatDateContainer extends StatelessWidget {
  final String dateString;
  final bool hideTopPadding;

  const ChatDateContainer(
      {super.key, required this.dateString, this.hideTopPadding = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: hideTopPadding
            ? EdgeInsets.zero
            : EdgeInsets.only(top: Dimensions.h10),
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.w18, vertical: Dimensions.h3),
        decoration: BoxDecoration(
            color: ColorConst.dateContainer.withOpacity(
                Get.theme.brightness == Brightness.light ? 0.05 : 0.2),
            borderRadius: BorderRadius.circular(Dimensions.r15)),
        child: Text(
          dateString,
          style: fontStyleSemiBold12.copyWith(
              color: Get.theme.colorScheme.hintTextColor),
        ));
  }
}
