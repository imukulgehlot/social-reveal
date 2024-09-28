import 'package:flutter/material.dart';

import '../core/basic_features.dart';
import '../core/widgets/custom_image.dart';
import '../core/widgets/text_field/text_field/my_text_field.dart';

class CustomTextFieldWithHead extends StatelessWidget {
  final String? title;
  final String hintText;
  final String prefixIcon;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final int? maxLine;
  final bool? isEnabled;
  final double? iconBottomPadding;
  final EdgeInsets? padding;

  const CustomTextFieldWithHead({
    super.key,
    this.title,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    this.maxLine = 1,
    this.iconBottomPadding,
    this.padding,
    this.textInputType,
    this.isEnabled,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title Text
        if (title != null)
          Container(
            padding: EdgeInsets.only(left: Dimensions.h10),
            alignment: Alignment.centerLeft,
            child: Text(title!,
                textAlign: TextAlign.center,
                style: fontStyleSemiBold15.apply(
                    color: Theme.of(context).colorScheme.textColor)),
          ),

        if (title != null)
          SizedBox(
            height: Dimensions.h3,
          ),

        // Text field
        MyTextField(
            padding: padding ?? EdgeInsets.zero,
            maxLine: maxLine,
            isEnabled: isEnabled,
            borderRadius: Dimensions.r10,
            prefixIcon: CustomSvgAssetImage(
              image: prefixIcon,
              width: Dimensions.w25,
              color: isEnabled != null && isEnabled == false
                  ? Theme.of(context).colorScheme.hintTextColor
                  : Theme.of(context).colorScheme.textColor,
            ),
            textStyle: isEnabled != null && isEnabled == false
                ? fontStyleRegular14.apply(
                    color: Theme.of(context).colorScheme.textColor)
                : fontStyleSemiBold14.apply(
                    color: Theme.of(context).colorScheme.textColor),
            height: Dimensions.h40,
            textInputType: textInputType,
            hintTextColor: ColorConst.hintColor,
            textController: controller,
            textInputAction: textInputAction,
            textFieldBorderColor: Colors.transparent,
            iconBottomPadding: iconBottomPadding,
            hintText: hintText),
      ],
    );
  }
}
