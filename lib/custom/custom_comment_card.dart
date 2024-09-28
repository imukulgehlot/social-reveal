import 'package:flutter/material.dart';
import 'package:rstsocial/core/basic_features.dart';
import 'package:rstsocial/core/model/ui_model/user_comment_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomCommentCard extends StatelessWidget {
  final UserCommentModel model;

  const CustomCommentCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.w5).copyWith(
          left: Dimensions.commonPaddingForScreen,
          right: Dimensions.commonPaddingForScreen),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // USER PROFILE
          CircleAvatar(
            radius: Dimensions.r17,
            backgroundColor: Theme.of(context).colorScheme.hintTextColor,
            backgroundImage: NetworkImage(
              model.userProfile,
            ),
          ),
          SizedBox(
            width: Dimensions.w10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // USER NAME
                    Text(
                      model.userName,
                      style: fontStyleMedium13.apply(
                          color: Theme.of(context).colorScheme.textColor),
                    ),
                    // POST TIME
                    Text(
                      timeago.format(model.commentTime),
                      style: fontStyleMedium10.apply(
                          color: Theme.of(context).colorScheme.hintTextColor),
                    ),
                  ],
                ),
                // Comment Content
                Text(
                  model.comment,
                  style: fontStyleMedium12.apply(
                      color: Theme.of(context).colorScheme.hintTextColor),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
