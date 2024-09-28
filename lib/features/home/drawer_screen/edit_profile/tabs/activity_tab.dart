import 'package:flutter/material.dart';

import '../../../../../core/basic_features.dart';
import '../../../../../core/widgets/custom_image.dart';

class ActivityTab extends StatelessWidget {
  const ActivityTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsetsDirectional.zero,
      itemBuilder: (context, index) => Material(
        color: Get.theme.colorScheme.textFieldColor,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(Dimensions.r10),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.w15, vertical: Dimensions.h8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomNetworkImage(
                    height: Dimensions.w80,
                    width: Dimensions.w80,
                    borderRadius: Dimensions.r10,
                    image:
                        'https://qph.cf2.quoracdn.net/main-qimg-d3e0cff696d0e1cef4165c8e766ca02d-lq'),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimensions.w10, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Participated in Event",
                          style: fontStyleSemiBold16.copyWith(
                              color: Get.theme.colorScheme.textColor),
                          maxLines: 1,
                        ),
                        Text(
                          "Need a host for an food event that is food event that...",
                          style: fontStyleMedium12.copyWith(
                              color: Get.theme.colorScheme.textColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: Dimensions.h5,
                        ),
                        Text(
                          "2 Hours Ago",
                          style: fontStyleRegular10.copyWith(
                              color: Get.theme.colorScheme.textColor
                                  .withOpacity(0.8)),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(
        height: Dimensions.h5,
      ),
      itemCount: 4,
    );
  }
}
