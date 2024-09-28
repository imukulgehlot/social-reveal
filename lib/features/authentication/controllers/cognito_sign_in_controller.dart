import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/basic_features.dart';
import '../../../core/utils/logger_util.dart';

class SignInController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final RxBool isPasswordVisible = true.obs;

  void checkValidation() {
    if (emailController.text.trim().isEmpty) {
      AppUtils.showSnackBar(message: AppString.emailCantBeEmpty);
      // } else if (!emailController.text.trim().isEmail) {
      //   Const.showSnackBar(message: AppString.pleaseEnterAValidEmailAddress);
    } else if (passwordController.text.trim().isEmpty) {
      AppUtils.showSnackBar(message: AppString.passwordCantBeEmpty);
    } else if (passwordController.text.trim().length < 8) {
      AppUtils.showSnackBar(message: AppString.passwordShouldBeAtLeast);
    } else {
      isPasswordVisible.value = true;
      _signInUser(emailController.text.trim(), passwordController.text);
    }
  }

  Future<void> _signInUser(String username, String password) async {
    EasyLoading.show();
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      logger.i(
          "So result is:\n IsSignedIn: ${result.isSignedIn}\nNext Step Status: ${result.nextStep}\nSetup Details: ${result.nextStep.totpSetupDetails}\nSignInStep: ${result.nextStep}");
      // await _handleSignInResult(result);
      EasyLoading.dismiss();
    } on AuthException catch (e) {
      EasyLoading.dismiss();
      logger.e('Error signing in: ${e.message}');
    }
  }
}
