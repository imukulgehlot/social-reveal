import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';

import '../../../../../../core/widgets/custom_image.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.eventDetails,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
                height: Dimensions.h170,
                //  width: Dimensions.w90,
                borderRadius: Dimensions.r10,
                image:
                    'https://assets-chicagomarathon-com.s3.amazonaws.com/wp-content/uploads/2022/06/Apply-700x225.jpg'),
            SizedBox(
              height: Dimensions.h15,
            ),
            Text(
              'Marathon',
              style:
                  fontStyleBold17.apply(color: Get.theme.colorScheme.textColor),
            ),
            SizedBox(
              height: Dimensions.h5,
            ),

            // Category
            Chip(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.h5, horizontal: Dimensions.w10),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Get.theme.colorScheme.textColor),
                  borderRadius: BorderRadius.circular(Dimensions.r20)),
              avatar: CustomSvgAssetImage(
                image: ImageAsset.icPhysical,
                width: Dimensions.w28,
                height: Dimensions.h28,
                color: Theme.of(context).colorScheme.textColor,
              ),
              labelPadding: EdgeInsets.only(left: Dimensions.w5),
              label: Text(
                AppString.friends,
                style: fontStyleMedium12.apply(
                    color: Get.theme.colorScheme.textColor),
              ),
            ),

            SizedBox(
              height: Dimensions.h15,
            ),

            MyButton(
              onPressed: () {},
              title: AppString.iAmInterested,
            ),

            SizedBox(
              height: Dimensions.h15,
            ),

            // Location
            Text(
              AppString.eventDate,
              style: fontStyleSemiBold14.apply(
                  color: Get.theme.colorScheme.textColor),
            ),
            Text(
              "20 March 2023, 10:00 AM",
              style: fontStyleMedium12.copyWith(
                  fontSize: Dimensions.sp11,
                  color: Get.theme.colorScheme.textColor),
            ),
            SizedBox(
              height: Dimensions.h10,
            ),

            // Valid Up to
            Text(
              AppString.eventVanue,
              style: fontStyleSemiBold14.apply(
                  color: Get.theme.colorScheme.textColor),
            ),
            Text("New York, USA",
                style: fontStyleMedium12.copyWith(
                    fontSize: Dimensions.sp11,
                    color: Get.theme.colorScheme.hintTextColor)),
            SizedBox(
              height: Dimensions.h10,
            ),

            // Description
            Text(
              AppString.description,
              style: fontStyleSemiBold14.apply(
                  color: Get.theme.colorScheme.textColor),
            ),
            Text(
              "33 Cyclist from across the country will participate in USA's Inland 1400 Km long distance cycling marathon scheduled to be flagged in New York on Friday. The Participants will ride all the way to LA and Will return to New York. the entire strech is likely to be covered in about 112 hours.",
              style: fontStyleMedium12.copyWith(
                  fontSize: Dimensions.sp11,
                  color: Get.theme.colorScheme.textColor),
            ),
            SizedBox(
              height: Dimensions.h10,
            ),
          ],
        ),
      ),
    );
  }
}
