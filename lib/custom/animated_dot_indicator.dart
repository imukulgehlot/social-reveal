import 'package:flutter/cupertino.dart';
import 'package:rstsocial/core/basic_features.dart';

class AnimatedDotIndicator extends StatelessWidget {
  final int currentIndex;
  final double? smallWidth;
  final double? maxWidth;
  final int length;

  const AnimatedDotIndicator({
    super.key,
    required this.currentIndex,
    required this.length,
    this.smallWidth,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < length; i++)
          AnimatedContainer(
            width: i == currentIndex
                ? maxWidth ?? Dimensions.w38
                : smallWidth ?? Dimensions.w12,
            height: smallWidth ?? Dimensions.w12,
            margin: EdgeInsets.only(right: Dimensions.w4),
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.r20),
              color: i == currentIndex
                  ? ColorConst.primaryColor
                  : ColorConst.primaryLightColor,
            ),
          )
      ],
    );
  }
}
