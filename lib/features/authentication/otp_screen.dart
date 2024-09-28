import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/features/home/home_screen.dart';

import '../../core/widgets/custom_image.dart';
import 'controllers/cognito_sign_up_controller.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  // final SignUpController signUpController = Get.find(tag: "signUpController");
  final SignUpController signUpController =
      Get.put(SignUpController(), tag: "signUpController");

  late RxList<FocusNode> _focusNodes;
  late RxList<TextEditingController> _controllers;

  final codeLength = 6;
  final RxInt _resendDuration = 60.obs;
  final RxBool _isTimerRunning = false.obs;

  @override
  void initState() {
    super.initState();

    // Initialize focus nodes and controllers for each digit
    _focusNodes = List.generate(codeLength, (index) => FocusNode()).obs;
    _controllers = List.generate(
      codeLength,
      (index) => TextEditingController(),
    ).obs;

    // Add listeners to move focus to the next digit when a digit is entered
    for (int i = 0; i < codeLength - 1; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1) {
          _focusNodes[i + 1].requestFocus();
          _controllers.refresh();
        }
      });
    }

    // To open first box
    _focusNodes.first.requestFocus();
  }

  @override
  void dispose() {
    // Dispose of controllers and focus nodes to avoid memory leaks
    for (int i = 0; i < 4; i++) {
      _controllers[i].dispose();
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                // Top Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox.square(
                      dimension: kToolbarHeight,
                      child: IconButton(
                        iconSize: Dimensions.w28,
                        icon: CustomSvgAssetImage(
                          image: ImageAsset.icBackArrowNav,
                          width: Dimensions.w28,
                          height: Dimensions.h28,
                          color: Theme.of(context).colorScheme.textColor,
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.h25, right: Get.width * 0.15),
                        child: // Top Logo
                            CustomSvgAssetImage(
                          image:  Get.theme.brightness == Brightness.dark ? ImageAsset.icAppLogoLight : ImageAsset.icAppLogoDark,
                          color: ColorConst.primaryColor,
                          width: Dimensions.w105,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.h10,
                ),

                // Tagline
                Text(
                  AppString.socialNetworkUiShowcase,
                  style:
                      fontStyleSemiBold13.apply(color: ColorConst.primaryColor),
                ),
                SizedBox(
                  height: Get.height * 0.23,
                ),

                // Enter Your OTP Title
                Text(
                  "Enter your OTP here",
                  style: fontStyleSemiBold21.apply(
                      color: Get.theme.colorScheme.textColor),
                ),
                SizedBox(
                  height: Dimensions.h13,
                ),

                // OTP Field
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    codeLength,
                    (index) => buildOTPDigitField(index),
                  ),
                ),

                SizedBox(height: Dimensions.h20),

                // Submit Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.h80),
                  child: MyButton(
                    height: Dimensions.h35,
                    title: AppString.submit,
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();

                      bool allFieldFilled = !_controllers
                          .any((element) => element.text.trim().isEmpty);

                      if (allFieldFilled) {
                        String confirmationCode = '';
                        for (var element in _controllers) {
                          confirmationCode += element.text.trim();
                        }
                        // signUpController.confirmUser(
                            // confirmationCode: confirmationCode);

                        Get.offAll(()=> const HomeScreen());
                      } else {
                        AppUtils.showSnackBar(message: 'Oops! Fill all fields');
                      }
                    },
                  ),
                ),

                _isTimerRunning.value
                    ? TextButton(
                        onPressed: null,
                        child: Text('Resend in ${_resendDuration.value} s'),
                      )
                    : TextButton(
                        onPressed: () async {
                          startResendTimer();

                          // await signUpController.resendCode();
                        },
                        child: const Text('Resend OTP'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOTPDigitField(int index) {
    bool isSelectedOrFilled = _controllers[index].text.trim().isNotEmpty ||
        _focusNodes[index].hasFocus;

    bool areAllLastFieldsFilled =
        !List.generate(index, (i) => _controllers[i].text.trim().isEmpty)
            .any((isEmpty) => isEmpty);

    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: isSelectedOrFilled ? Dimensions.w43 : Dimensions.w40,
        height: isSelectedOrFilled ? Dimensions.w43 : Dimensions.w40,
        margin: EdgeInsets.symmetric(horizontal: Dimensions.w5),
        decoration: BoxDecoration(
          color: isSelectedOrFilled
              ? ColorConst.primaryLightColor.withOpacity(0.4)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(Dimensions.r10),
        ),
        child: TextField(
          enabled: areAllLastFieldsFilled,
          controller: _controllers[index],
          inputFormatters: [AppUtils.inputFormatter.number],
          onChanged: (value) {
            if (value.isEmpty) {
              // If the current TextField is empty, move focus to the previous one on backspace
              if (index > 0) {
                _focusNodes[index].unfocus();
                _focusNodes[index - 1].requestFocus();
              }
            } else {
              // If a digit is entered, move focus to the next TextField
              if (index < codeLength - 1) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _focusNodes[index + 1].requestFocus());
              }
            }
            _controllers.refresh();
          },
          focusNode: _focusNodes[index],
          textInputAction: index == codeLength - 1
              ? TextInputAction.done
              : TextInputAction.next,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          maxLength: 1,
          style: fontStyleRegular15.apply(
              color: Theme.of(context).colorScheme.textColor),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  void startResendTimer() {
    _resendDuration.value = 60;
    _isTimerRunning.value = true;

    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (timer) {
      if (_resendDuration.value > 0) {
        _resendDuration.value--;
      } else {
        _isTimerRunning.value = false;
        timer.cancel();
      }
    });
  }
}
