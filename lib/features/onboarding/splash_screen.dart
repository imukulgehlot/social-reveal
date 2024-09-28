import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rstsocial/core/widgets/custom_image.dart';
import 'package:rstsocial/features/authentication/sign_in_screen.dart';
import 'package:video_player/video_player.dart';

import '../../core/basic_features.dart';
import '../../core/environment_setup/Environment.dart';
import '../../core/storage/preference_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  final RxBool showVideo = false.obs;

  @override
  void initState() {
    AppUtils.goFullScreen();

    Future.delayed(const Duration(milliseconds: 5000), () {

      // Setting Environment
      Environment().initConfig(
          PreferenceStorage.getString("CurrentBuildMode") ?? Environment.DEV);


      // Navigate To User
      Get.off(() => const SignInScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 1800));
    });

    _controller = VideoPlayerController.asset(ImageAsset.splashVideo,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..setLooping(true)
      ..setVolume(0.0)
      ..initialize().then((_) {
        Future.delayed(const Duration(milliseconds: 100), () {
          showVideo.value = true;
        });
      })
      ..play();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Get.theme.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark));

    AppUtils.exitFullScreen();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: Get.height,
        width: Get.width,
        child: showVideo.value
            ? Stack(
                children: [
                  // The Video
                  VideoPlayer(_controller),

                  // Tint
                  Container(
                    height: Get.height,
                    width: Get.width,
                    color: Colors.black.withOpacity(0.20),
                    child:
                        // App Logo
                        Center(
                            child: CustomSvgAssetImage(
                      image: ImageAsset.icAppIconWithTagline,
                      color: ColorConst.whiteColor,
                      width: Get.width * 0.5,
                    )),
                  )
                ],
              )
            : Image.asset(
                ImageAsset.imgSplashPlaceHolder,
                color: const Color(0xFF282b2b),
                fit: BoxFit.fill,
              ),
      );
    });
  }
}
