import 'package:flutter/cupertino.dart';
import 'package:rstsocial/core/basic_features.dart';

class CustomTabBarSliverDelegate extends SliverPersistentHeaderDelegate {
  final Widget Function(bool overlapsContent) buildChild;
  final double? maxHeight;
  final double? minHeight;

  CustomTabBarSliverDelegate({
    required this.buildChild,
    this.maxHeight,
    this.minHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // Check if the widget is still attached to the tree before building
    if (context.owner != null) {
      final child = buildChild(overlapsContent);
      return child;
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  double get maxExtent =>
      maxHeight ?? Dimensions.h40;

  @override
  double get minExtent =>
      minHeight ?? Dimensions.h35; // Adjust the minimum height of the header

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false; // Return true if the header needs to be rebuilt on changes
  }
}
