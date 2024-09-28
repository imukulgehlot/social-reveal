import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import 'drawer_screen/navigation_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        key: drawerScaffoldKey,
        drawer: const NavigationDrawerScreen(),
        body: drawerScreens[selectedDrawerScreen.value],
      ),
    );
  }
}
