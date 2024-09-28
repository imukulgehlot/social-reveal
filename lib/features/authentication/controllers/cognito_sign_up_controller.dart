import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:rstsocial/core/utils/logger_util.dart';
import 'package:rstsocial/features/home/home_screen.dart';

import '../../../core/basic_features.dart';
import '../otp_screen.dart';

class SignUpController extends GetxController {
  final RxBool isPasswordVisible = true.obs;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUpUser({
    required String fullName,
    required String username,
    required String password,
    required String email,
  }) async {
    EasyLoading.show();
    try {
      final userAttributes = {
        AuthUserAttributeKey.name: fullName,
        AuthUserAttributeKey.email: email,
      };

      final result = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );

      EasyLoading.dismiss();
      await _handleSignUpResult(result);
    } on AuthException catch (e) {
      EasyLoading.dismiss();
      logger.e('Error signing up user: ${e.message}');
    }
  }

  Future<void> _handleSignUpResult(SignUpResult result) async {

    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignUpStep.done:
        logger.i(
            "So result is:\nNext Step Status: ${result.nextStep}\nAdditional Info: ${result.nextStep.additionalInfo}\nUser ID: ${result.userId}");

        Get.offAll(() => const HomeScreen());
        break;
    }
  }

  Future<void> resendCode() async {
    EasyLoading.show();
    ResendSignUpCodeResult result = await Amplify.Auth.resendSignUpCode(
        username: userNameController.text.trim());

    EasyLoading.dismiss();
    AppUtils.showToast(
      'A confirmation code has been sent to ${result.codeDeliveryDetails
          .destination}. '
          'Please check your ${result.codeDeliveryDetails.deliveryMedium
          .name} for the code.',
    );
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    AppUtils.showToast(
      'A confirmation code has been sent to ${codeDeliveryDetails
          .destination}. '
          'Please check your ${codeDeliveryDetails.deliveryMedium
          .name} for the code.',
    );

    Get.to(const OTPScreen());
  }

  // Check Validation Method is below
  checkValidation() {
    if (fullNameController.text
        .trim()
        .isEmpty) {} else if (userNameController.text
        .trim()
        .isEmpty) {} else if (emailController.text
        .trim()
        .isEmpty) {} else if (passwordController.text.isEmpty) {} else {
      signUpUser(
          fullName: fullNameController.text.trim(),
          username: userNameController.text.trim(),
          password: passwordController.text.trim(),
          email: emailController.text.trim());
    }
  }

  // To Confirm OTP
  Future<void> confirmUser({
    required String confirmationCode,
  }) async {
    EasyLoading.show();
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: userNameController.text.trim(),
        confirmationCode: confirmationCode,
      );
      EasyLoading.dismiss();

      await _handleSignUpResult(result);
    } on AuthException catch (e) {
      EasyLoading.dismiss();
      safePrint('Error confirming user: ${e.message}');
    }
  }




}
