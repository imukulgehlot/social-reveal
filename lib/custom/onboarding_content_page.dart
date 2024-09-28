import 'package:flutter/cupertino.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../core/widgets/custom_image.dart';

class OnBoardingContent extends StatefulWidget {
  final String text1;
  final String text2;
  final bool showAnimation;
  final String image;

  const OnBoardingContent(
      {super.key,
      required this.text1,
      this.showAnimation = true,
      required this.text2,
      required this.image});

  @override
  State<OnBoardingContent> createState() => _OnBoardingContentState();
}

class _OnBoardingContentState extends State<OnBoardingContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Start the animation
    if (widget.showAnimation) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Rich Text
        ScaleTransition(
          scale:
              Tween<double>(begin: widget.showAnimation ? 1.2 : 1.0, end: 1.0)
                  .animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutSine,
          )),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.w10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: widget.text1,
                  children: [
                    TextSpan(
                        text: widget.text2,
                        style: fontStyleBold18.apply(
                            color: ColorConst.primaryLightColor))
                  ],
                  style: fontStyleSemiBold18.apply(
                    color: ColorConst.primaryColor,
                  )),
            ),
          ),
        ),

        // Content Image
        ScaleTransition(
          scale:
              Tween<double>(begin: widget.showAnimation ? 0.6 : 1.0, end: 1.0)
                  .animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutSine,
          )),
          child: CustomSvgAssetImage(
            image: widget.image,
            height: Dimensions.h350,
          ),
        )
      ],
    );
  }
}
