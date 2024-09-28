import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:flutter_app_version_checker/flutter_app_version_checker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rstsocial/core/utils/logger_util.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../basic_features.dart';
import '../widgets/custom_image.dart';

Future<void> gotoScreen(Widget screen) async {
  var data = await navigateToPage(screen);
  if (data != null) {}
}

void orientations() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}


class AppUtils {
  static InputFormatter inputFormatter = InputFormatter();
  static RegExpression regExpression = RegExpression();
  static String packageName = '';
  static DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static double bottomPadding(BuildContext context) {
    return buttonHeight(context) + MediaQuery.of(context).padding.bottom;
  }

  static double buttonHeight(BuildContext context) {
    // print("AppBar().preferredSize.height    ${AppBar().preferredSize.height}");
    return AppBar().preferredSize.height;
  }


  // static AppCheckerResult? appVersion;
  static AndroidDeviceInfo? androidInfo;
  static IosDeviceInfo? iosInfo;
  static bool isAndroid = Platform.isAndroid;
  static bool isIos = Platform.isIOS;

  static String platform = Platform.isAndroid ? "Android" : "iOS";

  static Future<void> config() async {
    if (Platform.isAndroid) {
      androidInfo = await deviceInfoPlugin.androidInfo;
    } else {
      iosInfo = await deviceInfoPlugin.iosInfo;
    }
  }

  static String getDuration(Duration duration) {
    final int hours = duration.inHours.toString().length;
    return duration.inHours > 0
        ? hours == 1
            ? duration.toString().substring(0, 7)
            : duration.toString().substring(0, 8)
        : duration.toString().substring(2, 7);
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  // static checkUpdates() async {
  //   final checker = AppVersionChecker(
  //     appId: packageName,
  //   );
  //   appVersion = await checker.checkUpdate();
  //   if (kDebugMode) {
  //     print('App Version $appVersion');
  //   }
  // }

  static String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static Pattern phonePattern = r'(^[0-9 ]*$)';

  static void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static showSnackBar(
      {bool isSuccess = false,
      String? title,
      required String message,
      int durationMilliSecond = 4000}) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        "",
        "",
        reverseAnimationCurve: Curves.fastOutSlowIn,
        maxWidth: Get.width * 0.92,
        borderRadius: Dimensions.r8,
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        backgroundColor: ColorConst.primaryLightColor.withOpacity(0.4),
        duration: Duration(milliseconds: durationMilliSecond),
        icon: Container(
            margin: EdgeInsets.only(left: Dimensions.w5),
            height: Dimensions.w65,
            width: Dimensions.w65,
            child: Icon(
              isSuccess ? Icons.check_circle_outline : Icons.cancel_outlined,
              size: Dimensions.w30,
              color: Get.theme.colorScheme.textColor,
            )),
        titleText: Padding(
          padding: EdgeInsets.only(left: Dimensions.w5),
          child: Text(
            title ?? (isSuccess ? 'Great' : 'Whoops'),
            style:
                fontStyleBold15.apply(color: Get.theme.colorScheme.textColor),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: Dimensions.w8),
        messageText: Padding(
            padding: EdgeInsets.only(left: Dimensions.w5),
            child: Text(
              message,
              style: fontStyleMedium15.apply(
                  color: Get.theme.colorScheme.textColor),
            )),
      );
    }
  }

  static Color getRandomColor({bool dark = false}) {
    final Random random = Random();
    const int maxColorValue = 255;

    int randomColorComponent() => random.nextInt(maxColorValue);

    int randomRed = randomColorComponent();
    int randomGreen = randomColorComponent();
    int randomBlue = randomColorComponent();

    return dark
        ? Color.fromARGB(255, randomRed, randomGreen, randomBlue)
            .withOpacity(0.35)
        : Color.fromARGB(255, randomRed, randomGreen, randomBlue);
  }

  static String getUniqueName() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  static String getCurrentDateInYMDTHMS() {
    DateTime date = DateTime.now();
    DateFormat format = DateFormat("yyyy-MM-ddTHH:mm:ss");
    String formattedDate = format.format(date);
    return formattedDate;
  }

  static String convertDateTimeToMDYHMSA(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate = DateFormat('M/d/yyyy h:mm:ss a').format(dateTime);
    return formattedDate;
  }

  static String convertDateTimeToDMY(DateTime date) {
    String formattedDate = DateFormat('M/d/yyyy').format(date);
    return formattedDate;
  }

  static String convertDateTimeToHHmma(DateTime date) {
    String formattedDate = DateFormat('HH:mm a').format(date);
    return formattedDate;
  }

  static String convertDateAndTime(DateTime date) {
    String formattedDate = DateFormat('dd MMM').format(date);

    return formattedDate;
  }

  static String convertDateToFilterReq(DateTime? date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date!);
    return formattedDate;
  }

  static String convertDurationToHHmma(Duration times) {
    /*final time = Duration( minutes: times.inMinutes);
    return "${time.toString().split(":")[0]}:${time.toString().split(":")[1]}";*/
    DateTime ftime = DateFormat("hh:mm").parse(times.toString());
    String ft = DateFormat('hh:mm a').format(ftime);
    return ft;
  }

  static String getEventDateFormat(val) {
    var inputFormat = DateFormat('dd/MM/yyyy');
    var utc = inputFormat.parse(val);
    // var invoiceDates = inputFormat.parse(utc.toLocal().toString(), true);
    var outputFormat = DateFormat('EEE, MMM yy');
    var eventDate = outputFormat.format(utc);
    return eventDate;
  }

  static Future<void> openLink({required String link}) async {
    final Uri encodedURl = Uri.parse(link);

    if (await canLaunchUrl(encodedURl)) {
      await launchUrl(encodedURl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $encodedURl';
    }
  }

  static Future<String?> genThumbnailFile(String path) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
    );
    logger.f("Meow -> $fileName");
    return fileName;
  }

  static bool isVideoFile(String filePath) {
    final supportedVideoExtensions = [
      '.mp4',
      '.webm',
      '.mkv',
      '.avi',
      '.mov',
      '.wmv'
    ];

    final lowerCaseFilePath = filePath.toLowerCase();
    return supportedVideoExtensions
        .any((ext) => lowerCaseFilePath.endsWith(ext));
  }

  static Future<bool> isMediaPermissionGranted() async {
    final permission =
        Platform.isAndroid && AppUtils.androidInfo!.version.sdkInt <= 32
            ? Permission.storage
            : Permission.photos;

    final status = await permission.status;

    if (status.isDenied) {
      final newStatus = await permission.request();
      return newStatus.isGranted || newStatus.isLimited;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> isExternalStoragePermissionGranted() async {
    var  permission = androidInfo!.version.sdkInt <= 32 ? Permission.storage : Permission.manageExternalStorage;

    final status = await permission.status;
    if (status.isDenied) {
      final newStatus = await permission.request();
      return newStatus.isGranted || newStatus.isLimited;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> haveLocationPermission() async {
    final status = await Permission.location.status;
    if (status.isDenied) {
      final newStatus = await Permission.location.request();
      return newStatus.isGranted || newStatus.isLimited;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      return true;
    }
  }

  static Future<void> getCurrentLocation() async {
    if (await AppUtils.haveLocationPermission()) {
      EasyLoading.show();
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double latitude = position.latitude;
      double longitude = position.longitude;

      EasyLoading.dismiss();
      AppUtils.showSnackBar(
          message: "Location Permission Granted Successfully",
          isSuccess: true);
    }
  }

  static RegExp amountRegExp = RegExp(r'([.]*0)(?!.*\d)');

  static bool validateEmail(String email) {
    return RegExp(emailPattern).hasMatch(email);
  }

  static showToast(val) {
    Fluttertoast.showToast(
        msg: val,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConst.blackColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<XFile> getCompressionImage(filePath) async {
    int randomImageInt = Random().nextInt(100);

    final dir = await getTemporaryDirectory();
    final targetPath = "${dir.absolute.path}/${randomImageInt.toString()}.jpg";

    XFile? result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      targetPath,
      quality: 25,
    );

    return result!;
  }

  static void goFullScreen() =>
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  static Future<void> exitFullScreen() =>
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ]);

  static void showCustomDialog({
    required String title,
    required String contentText,
    bool barrierDismiss = true,
    bool mergeDefaultWithContent = false,
    String? firstButtonText,
    Widget? myWidget,
    String? icon,
    Function? onDialogCloseFunction,
    Function? firstButtonFunction,
    Function? secondButtonFunction,
    String? secondButtonText,
  }) {
    showGeneralDialog(
      context: Get.context!,
      barrierDismissible: barrierDismiss,
      barrierLabel: "Meow",
      transitionDuration: const Duration(milliseconds: 350),
      transitionBuilder: (_, animation, __, child) {
        return ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            )),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut,
                ),
              ),
              child: child,
            ));
      },
      pageBuilder: (context, _, __) {
        return Center(
          child: Container(
            width: Get.width * 0.78,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.r15),
              color: Get.theme.colorScheme.dialogColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Close Icon
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: CustomSvgAssetImage(
                      image: ImageAsset.icCross,
                      width: Dimensions.w15,
                      height: Dimensions.w15,
                    ),
                    onPressed: () => Get.back(),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(Dimensions.commonPaddingForScreen)
                      .copyWith(top: 0),
                  child: myWidget != null && !mergeDefaultWithContent
                      ? myWidget
                      : Column(
                          children: [
                            // Top Icon
                            if (icon != null)
                              CustomSvgAssetImage(
                                image: icon,
                                width: Dimensions.w130,
                                height: Dimensions.w130,
                              ),

                            // Title Text
                            Text(
                              title,
                              style: fontStyleBold18.copyWith(
                                  color: Get.theme.colorScheme.textColor),
                            ),
                            SizedBox(
                              height: Dimensions.h2,
                            ),

                            // Content Text
                            Text(
                              contentText,
                              textAlign: TextAlign.center,
                              style: fontStyleMedium12.copyWith(
                                  color: Get.theme.colorScheme.textColor),
                            ),

                            if (myWidget != null) myWidget,

                            // First Button
                            if (firstButtonText != null)
                              Padding(
                                padding: EdgeInsets.only(top: Dimensions.h10),
                                child: MyButton(
                                    onPressed: () {
                                      Get.back();
                                      firstButtonFunction?.call();
                                    },
                                    cornerRadius: Dimensions.r10,
                                    height: Dimensions.h32,
                                    textStyle: fontStyleSemiBold14.copyWith(
                                        color: Colors.white,
                                        fontSize: Dimensions.sp13),
                                    title: firstButtonText),
                              ),

                            // Second Button
                            if (secondButtonText != null)
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                    secondButtonFunction?.call();
                                  },
                                  child: Text(
                                    secondButtonText,
                                    style: fontStyleSemiBold14.copyWith(
                                        color: Colors.redAccent,
                                        fontSize: Dimensions.sp13),
                                  )),
                          ],
                        ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) => onDialogCloseFunction?.call());
  }

  static Future<dynamic> openCustomBottomSheet({
    required Widget contentWidget,
    Widget? fixedBottomWidget,
    bool isInnerHorizontalPadding = true,
    bool hideTopHook = false,
  }) {
    return showModalBottomSheet(
        useRootNavigator: true,
        isScrollControlled: true,
        context: Get.context!,
        builder: (context) => SafeArea(
              child: Wrap(
                children: [
                  StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      width: Dimensions.screenWidth(),
                      decoration: BoxDecoration(
                          color: Get.theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dimensions.r15),
                              topRight: Radius.circular(Dimensions.r15))),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Column(
                            children: [
                              if (!hideTopHook)
                                SizedBox(
                                  height: Dimensions.h12,
                                ),

                              if (!hideTopHook)
                                Container(
                                  width: Dimensions.w40,
                                  height: Dimensions.h6,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(Dimensions.r15),
                                      color: Get.theme.colorScheme.textColor
                                          .withOpacity(0.2)),
                                ),

                              SizedBox(
                                height: Dimensions.h10,
                              ),

                              // Content Widget
                              Container(
                                constraints: BoxConstraints(
                                    maxHeight: Get.height * 0.82),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isInnerHorizontalPadding
                                      ? Dimensions.commonPaddingForScreen
                                      : 0,
                                ).copyWith(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom +
                                          16.0,
                                ),
                                child:
                                    SingleChildScrollView(child: contentWidget),
                              ),

                              SizedBox(
                                height: Dimensions.h20,
                              ),
                            ],
                          ),
                          if (fixedBottomWidget != null)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.commonPaddingForScreen)
                                  .copyWith(bottom: Dimensions.h10),
                              child: fixedBottomWidget,
                            )
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ));
  }

  static bool showTimer(val) {
    return DateTime.now().compareTo(DateFormat("yyyy-MM-dd").parse(val)) == -1;
  }

  static bool checkCurrentDate(val) {
    return DateTime.now().compareTo(DateFormat("dd/M/yyyy").parse(val)) > 0;
  }

  static Color? colorConvert(String? color) {
    if (color != null) {
      return Color(int.parse(color.replaceAll('#', '0xFF')));
    } else {
      return null;
    }
  }

  static DateTime? backButtonPressedTime;

  // For Pop Scope
  static showExitPopScopePopup(BuildContext context) {
    DateTime currentTime = DateTime.now();

    bool backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime!) >
            const Duration(seconds: 3);

    if (backButton) {
      backButtonPressedTime = currentTime;
      AppUtils.showToast('Press again to exit');
    } else {
      SystemNavigator.pop();
    }
  }

  static Future<String> getStoragePath() async {
    String? storageFolderPath;
    if (Platform.isAndroid) {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      final splittedPath = appDirectory.path.split('/');
      splittedPath.removeLast();
      Directory folder = Directory('${splittedPath.join('/')}/files');
      folder.createSync(recursive: true);
      storageFolderPath = folder.path;
    } else {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      storageFolderPath = appDirectory.path;
    }
    return storageFolderPath;
  }

  static Future<String> getTempStoragePath() async {
    String? storageFolderPath;
    if (Platform.isAndroid) {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      final splittedPath = appDirectory.path.split('/');
      splittedPath.removeLast();
      Directory folder = Directory('${splittedPath.join('/')}/files/temp');
      folder.createSync(recursive: true);
      storageFolderPath = folder.path;
    } else {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      // final splittedPath = appDirectory.path.split('/');
      // splittedPath.removeLast();
      Directory folder = Directory('${appDirectory.path}/temp');
      if (await folder.exists()) {
        return folder.path;
      } else {
        folder.createSync(recursive: true);
        storageFolderPath = folder.path;
      }
    }
    return storageFolderPath;
  }

  static Future<void> deleteTempStoragePath() async {
    if (Platform.isAndroid) {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      final splittedPath = appDirectory.path.split('/');
      splittedPath.removeLast();
      Directory folder = Directory('${splittedPath.join('/')}/files/temp');
      if (await folder.exists()) {
        folder.deleteSync(recursive: true);
      }
    } else {
      Directory appDirectory = await getApplicationDocumentsDirectory();
      Directory folder = Directory('${appDirectory.path}/temp');
      if (await folder.exists()) {
        folder.deleteSync(recursive: true);
      }
    }
  }
}

class InputFormatter {
  FilteringTextInputFormatter get number =>
      FilteringTextInputFormatter.allow(RegExp(r"[0-9]"));
}

class RegExpression {
  RegExp phonePattern = RegExp(r'(^[0-9 ]*$)');
}

class FontAsset {
  static const String poppins = "Poppins";
  static const String sfPro = "SFProText";

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}


class MyDivider extends StatelessWidget {
  final double height;
  final Color? color;

  const MyDivider({super.key, this.height = 1, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(height: height, color: color ?? ColorConst.dividerColor);
  }
}
