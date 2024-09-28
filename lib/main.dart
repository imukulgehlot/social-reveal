import 'package:flutter/material.dart';

import 'features/my_app.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();

  Future.delayed(const Duration(milliseconds: 500), () {
    runApp(const MyApp());
  });
}
