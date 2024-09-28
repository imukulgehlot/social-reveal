import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../basic_features.dart';

class MyTextField extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final double? height;
  final double? borderRadius;
  final Widget? suffixIcon;
  final String? title;
  final TextEditingController? textController;
  final Color? hintTextColor;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final int? maxLine, maxLength;
  final TextInputType? textInputType;
  final bool? obscureText;
  final bool autoFocus;
  final bool? isEnabled;
  final bool readOnly;
  final Function(String)? onChanged;
  final Function? onTap;
  final String? hintText;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final Color? textFieldColor;
  final Color? textFieldBorderColor;
  final double? iconBottomPadding;
  final EdgeInsets? padding;

  const MyTextField(
      {super.key,
      this.readOnly = false,
      this.textCapitalization = TextCapitalization.sentences,
      this.inputFormatters,
      this.isEnabled,
      this.height,
      this.textInputAction,
      this.focusNode,
      this.maxLine = 1,
      this.onTap,
      this.maxLength,
      this.textInputType,
      this.title,
      this.obscureText = false,
      this.textController,
      this.hintTextColor,
      this.suffixIcon,
      this.onChanged,
      this.borderRadius,
      this.textStyle,
      this.hintTextStyle,
      this.hintText,
      this.inputType,
      this.autoFocus = false,
      this.prefixIcon,
      this.textFieldColor,
      this.textFieldBorderColor,
      this.iconBottomPadding,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          height: maxLine == 1 ? height ?? Dimensions.h33 : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            color:
                textFieldColor ?? Theme.of(context).colorScheme.textFieldColor,
          ),
          padding: padding ?? EdgeInsets.zero,
          child: Center(
            child: TextFormField(
                autofocus: autoFocus,
                enabled: isEnabled,
                maxLines: maxLine,
                obscureText: obscureText ?? false,
                focusNode: focusNode,
                inputFormatters: textInputType == TextInputType.phone
                    ? [AppUtils.inputFormatter.number]
                    : [],
                textCapitalization: TextCapitalization.none,
                textAlignVertical: TextAlignVertical.center,
                style: textStyle,
                cursorColor: ColorConst.primaryColor,
                // textAlign: textAlign ?? TextAlign.start,
                // onFieldSubmitted: widget.onFieldSubmit,
                controller: textController,
                // inputFormatters: widget.inputFormatters,
                decoration: InputDecoration(
                  // labelText: widget.showLabelText ? widget.hintText : null,
                  hintStyle: fontStyleRegular14.apply(
                      color: Get.theme.colorScheme.hintTextColor),
                  isDense: true,
                  prefixIconConstraints:
                      const BoxConstraints(minHeight: 0, minWidth: 0),
                  suffixIconConstraints:
                      const BoxConstraints(minHeight: 0, minWidth: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  fillColor: Colors.transparent,
                  filled: true,

                  hintText: hintText ?? "",
                  contentPadding: EdgeInsets.only(right: Dimensions.w10),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.w6,
                        right: Dimensions.w8,
                        bottom: iconBottomPadding ?? 0),
                    child: prefixIcon,
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(
                        left: Dimensions.w6, right: Dimensions.w8),
                    child: suffixIcon,
                  ),
                  // )),
                ),
                onChanged: (val) {},
                onSaved: (value) {},
                onTap: () {},
                textInputAction: textInputAction ?? TextInputAction.next,
                keyboardType: textInputType),
          ),
        ),
      ],
    );
  }
}
