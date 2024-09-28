import 'package:flutter/material.dart';

import '../../../core/constants/app_string.dart';
import '../../../core/utils/style.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        AppString.logout,
        style: fontStyleSemiBold15,
      )),
      backgroundColor: Colors.yellow,
    );
  }
}
