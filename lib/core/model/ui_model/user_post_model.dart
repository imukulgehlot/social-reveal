import 'user_comment_model.dart';

class UserPostModel {
  final String profileImage;
  final String? postImage;
  final String userName;
  final DateTime dateTime;
  final bool isPrimeMember;
  final String caption;
  final int likes;
  final int replies;
  final List<UserCommentModel> comments;

  UserPostModel(
      {required this.profileImage,
      this.postImage,
      required this.userName,
      required this.dateTime,
      required this.isPrimeMember,
      required this.caption,
      required this.likes,
      required this.replies,
      required this.comments});
}
