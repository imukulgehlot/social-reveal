import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_image.dart';
import '../constants/color_const.dart';
import '../constants/dimensions.dart';

class CustomNetworkImage extends StatelessWidget {
  double? height;
  double? width;
  double? borderRadius;
  final String image;
  BoxFit? fitType;
  bool showAquinasLogo;

  CustomNetworkImage(
      {super.key,
      this.height,
      this.width,
      this.borderRadius,
      required this.image,
      this.fitType,
      this.showAquinasLogo = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(borderRadius ?? 0)),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
          height: height,
          width: width ?? double.infinity,
          child: CachedNetworkImage(
              fit: fitType ?? BoxFit.cover,
              imageUrl: image,
              placeholder: (context, url) => const Center(
                      child: CupertinoActivityIndicator(
                    radius: 10,
                  )),
              errorWidget: (context, url, error) => Container(
                    color: ColorConst.greyColor,
                    child: showAquinasLogo
                        ? Padding(
                            padding: EdgeInsets.all(Dimensions.w20),
                            child: Image.asset(
                              ImageAsset.icDrawerIcon,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.r35,
                                vertical: Dimensions.r33),
                            child: Image.asset(
                              ImageAsset.icDrawerIcon,
                              fit: BoxFit.fill,
                            ),
                          ),
                  ))),
    );
  }
}

class MyNetworkImage extends StatelessWidget {
  double height;
  double radius;
  double? width;
  final String image;
  BoxFit? fitType;

  MyNetworkImage(
      {super.key,
      this.radius = 0,
      required this.height,
      this.width,
      required this.image,
      this.fitType});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width ?? double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: CachedNetworkImage(
              fit: fitType ?? BoxFit.cover,
              imageUrl: image,
              placeholder: (context, url) => const Center(
                      child: CupertinoActivityIndicator(
                    radius: 10,
                  )),
              errorWidget: (context, url, error) => Image.asset(
                    ImageAsset.icAppLogoLight,
                    fit: BoxFit.fill,
                  )),
        ));
  }
}

class MyCircleNetworkImage extends StatelessWidget {
  var radius;
  final String image;

  MyCircleNetworkImage({
    super.key,
    this.radius,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: radius,
      child: CachedNetworkImage(
          fit: BoxFit.fill,
          filterQuality: FilterQuality.none,
          imageBuilder: (context, provider) {
            return CircleAvatar(
              radius: radius,
              backgroundImage: provider,
            );
          },
          imageUrl: image,
          placeholder: (context, url) => const Center(
                  child: CupertinoActivityIndicator(
                radius: 10,
              )),
          errorWidget: (context, url, error) => CircleAvatar(
              radius: radius,
              backgroundImage: const AssetImage(ImageAsset.icAppLogoLight))),
    );
  }
}

class MyRoundCornerNetworkImage extends StatelessWidget {
  double height;
  double? width;
  double radius;
  final String image;

  MyRoundCornerNetworkImage({
    super.key,
    required this.height,
    this.width,
    this.radius = 10,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: CachedNetworkImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.none,
          imageBuilder: (context, provider) {
            return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConst.greyColor, width: 1),
                    borderRadius: BorderRadius.circular(radius),
                    image: DecorationImage(
                      image: provider,
                      fit: BoxFit.cover,
                    )));
          },
          /*imageBuilder: (context,provider){
            return ClipRRect(
              borderRadius: BorderRadius.circular(radius), child: Image(images: provider,));
          },*/
          imageUrl: image,
          placeholder: (context, url) => const Center(
                  child: CupertinoActivityIndicator(
                radius: 10,
              )),
          errorWidget: (context, url, error) => ClipRRect(
              borderRadius: BorderRadius.circular(
                radius,
              ),
              child: Image.asset(ImageAsset.icAppLogoLight))),
    );
  }
}

class MyRoundCornerAssetImage extends StatelessWidget {
  double height;
  double? width;
  double radius;
  Color? imageColor;
  final String image;

  MyRoundCornerAssetImage({
    super.key,
    required this.height,
    this.width,
    this.imageColor,
    this.radius = 10,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(
          image,
          fit: BoxFit.contain,
          height: height,
          width: width,
          color: imageColor,
        ));
  }
}

class CustomSvgAssetImage extends StatelessWidget {
  double? height;
  double? width;
  Function? onTap;
  final String image;
  var color;

  CustomSvgAssetImage({
    super.key,
    this.height,
    this.width,
    this.onTap,
    this.color,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              onTap?.call();
            }
          : null,
      child: SvgPicture.asset(
        image,
        color: color,
        fit: BoxFit.contain,
        height: height,
        width: width,
      ),
    );
  }
}

class CustomAssetImage extends StatelessWidget {
  double? height;
  double? width;
  Color? imageColor;
  Function? onTap;
  final String image;

  CustomAssetImage({
    super.key,
    this.height,
    this.width,
    this.imageColor,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null
          ? () {
              onTap?.call();
            }
          : null,
      child: Image.asset(
        image,
        fit: BoxFit.contain,
        height: height,
        width: width,
        color: imageColor,
      ),
    );
  }
}

class CustomRoundCornerNetworkImage extends StatelessWidget {
  double? height;
  double? width;
  double radius;
  final String image;

  CustomRoundCornerNetworkImage({
    super.key,
    this.height,
    this.width,
    this.radius = 10,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: CachedNetworkImage(
          fit: BoxFit.cover,
          filterQuality: FilterQuality.none,
          imageBuilder: (context, provider) {
            return Container(
                decoration: BoxDecoration(
                    // border: Border.all(color: ColorConst.greyColor, width: 1),
                    borderRadius: BorderRadius.circular(radius),
                    image: DecorationImage(
                      image: provider,
                      fit: BoxFit.cover,
                    )));
          },
          /*imageBuilder: (context,provider){
            return ClipRRect(
              borderRadius: BorderRadius.circular(radius), child: Image(images: provider,));
          },*/
          imageUrl: image,
          placeholder: (context, url) => const Center(
                  child: CupertinoActivityIndicator(
                color: ColorConst.primaryColor,
                radius: 10,
              )),
          errorWidget: (context, url, error) => ClipRRect(
              borderRadius: BorderRadius.circular(
                radius,
              ),
              child: Image.asset(ImageAsset.icReadedNotification))),
    );
  }
}
