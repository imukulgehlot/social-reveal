import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../../../core/widgets/custom_image.dart';

class AwardsPointsCriteriaScreen extends StatelessWidget {
  AwardsPointsCriteriaScreen({super.key});

  final pointsList = [
    'Choose a category earn reward points for every 5 likes on that post.',
    'To earn reward points, users can answer questions, leave comments, or share their thoughts',
    'Users who opt not to participate will receive a 0.20 award, while the content creator receives 1 point (divisible by liker preferences and categories)',
    'Users start at Level 0, advancing to Level 1 with 1 like or comment on their article.',
    'Both sponsees and sponsors can create and engage with posts, earning award points based on likes.',
    'The system gathers feedback every 5 likes within a category to assess content impact and user benefit.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.awardPointsCriteria,
          style: fontStyleSemiBold17.apply(
            color: Theme.of(context).colorScheme.textColor,
          ),
        ),
        titleSpacing: 0,
        leading: IconButton(
          iconSize: Dimensions.w28,
          icon: CustomSvgAssetImage(
            image: ImageAsset.icBackArrowNav,
            width: Dimensions.w28,
            height: Dimensions.h28,
            color: Theme.of(context).colorScheme.textColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // Top Heading
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.commonPaddingForScreen),
              child: Column(
                children: [
                  // Heading
                  Text(
                    'This is the procedure for obtaining and transferring award points',
                    style: fontStyleSemiBold14.copyWith(
                      color: Get.theme.colorScheme.textColor,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.h10,
                  ),
                ],
              ),
            ),
          ),

          // Our Sliver List of Award Points
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.commonPaddingForScreen),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: Dimensions.w8,
                  leading: CustomSvgAssetImage(
                    image: ImageAsset.icDialogueChecked,
                    width: Dimensions.w30,
                    height: Dimensions.w30,
                  ),
                  title: Text(
                    pointsList[index],
                    style: fontStyleRegular12.copyWith(
                      height: 1.30,
                      color: Get.theme.colorScheme.textColor,
                    ),
                  ),
                ),
                childCount: pointsList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
