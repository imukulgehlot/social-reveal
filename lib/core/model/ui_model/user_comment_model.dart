class UserCommentModel {
  final String userName;
  final String userProfile;
  final String comment;
  final DateTime commentTime;

  UserCommentModel(
      {required this.userName,
      required this.userProfile,
      required this.comment,
      required this.commentTime});
}
