import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rstsocial/core/basic_features.dart';

class AppThemeData {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xff8C74FB),
    splashColor: ColorConst.primaryLightColor.withOpacity(0.2),
    highlightColor: ColorConst.primaryLightColor.withOpacity(0.1),
    colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light, seedColor: ColorConst.primaryColor),
    cardColor: const Color(0xfff9f9f9),
    scaffoldBackgroundColor: Colors.white,
    canvasColor: ColorConst.whiteColor,
    // textTheme: TextTheme(bodyMedium: fontStyleMedium16),
    dialogBackgroundColor: const Color(0x80000000),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      elevation: 0.0,
      color: ColorConst.whiteColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      centerTitle: false,
    ),
    navigationBarTheme: NavigationBarThemeData(
      iconTheme: MaterialStateProperty.all(const IconThemeData(
        color: Colors.black, // Set the color for your icons here
      )),
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      labelTextStyle:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return fontStyleSemiBold12.apply(
              color: ColorConst.backgroundColorDark);
        } else {
          return fontStyleRegular12.apply(
              color: ColorConst.backgroundColorDark);
        }
      }),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h3),
        backgroundColor: ColorConst.signInModeButtonColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.r10)),
        side:
            const BorderSide(color: ColorConst.signInModeButtonColor, width: 0),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    dialogBackgroundColor: Colors.white.withOpacity(0.01),
    primaryColor: const Color(0xff8C74FB),
    shadowColor: Colors.white38,
    splashColor: ColorConst.primaryLightColor.withOpacity(0.2),
    highlightColor: ColorConst.primaryLightColor.withOpacity(0.1),
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: ColorConst.primaryColor,
    ),
    canvasColor: ColorConst.backgroundColorDark,
    scaffoldBackgroundColor: ColorConst.backgroundColorDark,
    cardColor: const Color(0xff202020),
    hintColor: ColorConst.hintColor,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      elevation: 0.0,
      color: ColorConst.backgroundColorDark,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
      centerTitle: false,
    ),
    navigationBarTheme: NavigationBarThemeData(
      iconTheme: MaterialStateProperty.all(const IconThemeData(
        color: Colors.white, // Set the color for your icons here
      )),
      backgroundColor: ColorConst.backgroundColorDark,
      surfaceTintColor: ColorConst.backgroundColorDark,
      labelTextStyle:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return fontStyleSemiBold12.apply(color: ColorConst.whiteColor);
        } else {
          return fontStyleRegular12.apply(color: ColorConst.whiteColor);
        }
      }),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: Dimensions.h3),
        backgroundColor: const Color(0xff202020),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.r10)),
        side: const BorderSide(color: Colors.transparent, width: 0),
      ),
    ),
  );
}
