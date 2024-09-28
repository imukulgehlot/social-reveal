import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/color_const.dart';
import '../../../constants/dimensions.dart';
import '../../../utils/custom_text_style.dart';
import '../../custom_text_widget.dart';

// import '../../core/utils/custom_text_style.dart';
// import '../../core/widgets/custom_text_widget.dart';

class SearchBarTextBoxField extends StatefulWidget {
  final inputFormatters;
  final double? height;
  final bool isRequiredField;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? title;
  final String? headerText;
  final TextEditingController textController;
  final Color? hintTextColor;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final TextInputType? inputType;
  final TextAlign? textAlign;
  final int? maxLine, maxLength;
  final double? topLeftRadius,
      topRightRadius,
      bottomLeftRadius,
      bottomRightRadius;
  final keyboardType;
  final bool? obscureText;
  final bool? isReadOnly;
  final Color? bgColor;
  final bool showLabelText;
  final Function(String) onChanged;
  final Function() afterClearButton;
  ValueChanged? onFieldSubmit;
  FormFieldValidator? validator;
  final String? hintText;
  final Function? onTap;

  SearchBarTextBoxField(
      {super.key,
      this.inputFormatters,
      this.height,
      this.focusNode,
      this.maxLine,
      this.textAlign = TextAlign.start,
      this.maxLength,
      this.topLeftRadius,
      this.topRightRadius,
      this.bottomLeftRadius,
      this.bottomRightRadius,
      this.keyboardType,
      this.title,
      this.headerText,
      this.validator,
      this.obscureText = false,
      required this.textController,
      this.onFieldSubmit,
      this.bgColor,
      this.isReadOnly,
      this.showLabelText = false,
      this.hintTextColor,
      this.suffixIcon,
      this.prefixIcon,
      required this.onChanged,
      this.textInputAction,
      this.hintText,
      this.onTap,
      this.inputType,
      this.isRequiredField = false,
      required this.afterClearButton});

  @override
  State<SearchBarTextBoxField> createState() => _SearchBarTextBoxFieldState();
}

class _SearchBarTextBoxFieldState extends State<SearchBarTextBoxField> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          widget.headerText != null
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
                  child: Row(
                    children: [
                      CustomTextWidget.medium18(
                        text: widget.headerText.toString(),
                        color: ColorConst.blackColor,
                      ),
                      if (widget.isRequiredField)
                        CustomTextWidget.medium18(
                          text: ' *',
                          color: Colors.red,
                        ),
                    ],
                  ),
                )
              : const SizedBox(),
          Container(
            height: widget.height ?? Dimensions.h45,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.topLeftRadius ?? 0.00),
                topRight: Radius.circular(widget.topRightRadius ?? 0.00),
                bottomLeft: Radius.circular(widget.bottomLeftRadius ?? 0.00),
                bottomRight: Radius.circular(widget.bottomRightRadius ?? 0.00),
              ),
              color: widget.bgColor ?? ColorConst.textFieldColor,
            ),
            child: TextFormField(
                autofocus: false,
                obscureText: false,
                focusNode: widget.focusNode,
                textCapitalization: TextCapitalization.none,
                textAlignVertical: TextAlignVertical.center,
                style: CustomTextStyle.instance.medium18.copyWith(
                    color: ColorConst.blackColor,
                    fontSize: Dimensions.sp13,
                    fontWeight: FontWeight.w400),
                cursorColor: ColorConst.primaryColor,
                textAlign: widget.textAlign ?? TextAlign.start,
                onFieldSubmitted: widget.onFieldSubmit,
                controller: widget.textController,
                inputFormatters: widget.inputFormatters,
                decoration: InputDecoration(
                    labelText: widget.showLabelText ? widget.hintText : null,
                    isDense: true,
                    prefixIconConstraints:
                        BoxConstraints(minHeight: 0, minWidth: Dimensions.w6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    labelStyle: CustomTextStyle.instance.medium18.copyWith(
                        color: ColorConst.blackColor,
                        fontSize: Dimensions.sp15,
                        fontWeight: FontWeight.w500),
                    // fillColor: ColorCon,
                    // filled: true,
                    hintText: widget.hintText ?? "",
                    hintStyle: CustomTextStyle.instance.medium18.copyWith(
                        color: widget.hintTextColor ?? ColorConst.blackColor,
                        fontSize: Dimensions.sp13,
                        fontWeight: FontWeight.w400),
                    contentPadding: EdgeInsets.only(right: Dimensions.w10),
                    prefixIcon: widget.prefixIcon ??
                        Padding(
                          padding: EdgeInsets.only(
                              right: Dimensions.w5,
                              left: Dimensions.w10,
                              top: Dimensions.w10,
                              bottom: Dimensions.w10),
                          child: Icon(
                            CupertinoIcons.calendar,
                            color: ColorConst.blackColor,
                            size: Dimensions.w16,
                          ),
                        ),
                    suffixIconConstraints: BoxConstraints(
                        minHeight: widget.height ?? Dimensions.h40,
                        minWidth: 0),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.textController.clear();
                        });
                        widget.afterClearButton.call();
                      },
                      child: widget.suffixIcon ??
                          Padding(
                            padding: EdgeInsets.only(
                                right: Dimensions.w5,
                                left: Dimensions.w10,
                                top: Dimensions.w10,
                                bottom: Dimensions.w10),
                            child: widget.textController.text.isNotEmpty
                                ? Icon(
                                    CupertinoIcons.clear_circled,
                                    color: ColorConst.blackColor,
                                    size: Dimensions.w16,
                                  )
                                : const SizedBox(),
                          ),
                    )),
                onChanged: (val) {
                  widget.onChanged(val);
                  setState(() {});
                },
                onSaved: (value) {
                  value = widget.textController.text;
                },
                onTap: () {
                  widget.onTap?.call();
                },
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text),
          ),
        ],
      ),
    );
  }
}
