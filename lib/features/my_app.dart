import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rstsocial/features/onboarding/splash_screen.dart';
import 'package:get_storage/get_storage.dart';

import '../core/aws_services/amplify_configuration.dart';
import '../core/basic_features.dart';
import '../core/storage/preference_storage.dart';
import '../core/theme/app_theme_data.dart';
import '../core/utils/app_loader.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Brightness brightness = Brightness.light;

  @override
  void initState() {
    super.initState();
    initializingInitials();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    setState(() {
      this.brightness = brightness;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: brightness));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, widget) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: GetMaterialApp(
            localizationsDelegates: const [
              /// THIS IS FOR COUNTRY CODE PICKER
              // CountryLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("en"),
            ],
            builder: EasyLoading.init(
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!,
                );
              },
            ),
            darkTheme: AppThemeData.darkTheme,
            theme: AppThemeData.lightTheme,
            defaultTransition: Transition.cupertino,
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            title: AppString.appName,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }

  initializingInitials() {
    // await NotificationManager().init();
    // Permission.notification.request();

    // await Firebase.initializeApp();
    // await Const.checkUpdates();
    // await initializeTeams();

    AppUtils.config();
    // CognitoHelpingHand.configureAmplify();
    GetStorage.init();
    Loader.instance.init();
    orientations();

  }
}
