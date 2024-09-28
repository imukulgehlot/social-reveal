import 'user_comment_model.dart';
import 'user_post_model.dart';

class SampleData {
  ///// COMMENTS
  static List<UserCommentModel> sampleComments2 = [
    UserCommentModel(
      userName: 'Tom',
      userProfile:
          'https://i.pinimg.com/564x/a9/3c/b7/a93cb7935e56c771aff48e72eb4295b7.jpg',
      commentTime: DateTime.now().subtract(const Duration(days: 1)),
      comment: 'What\'s up, doc?',
      // comment: 'I think bitching is healthy. I said what I said.',
    ),
    UserCommentModel(
      userName: 'Jerry',
      userProfile:
          'https://i.pinimg.com/564x/71/29/a4/7129a4cd6b49412a4921bdc02e028b6b.jpg',
      commentTime: DateTime.now().subtract(const Duration(days: 2)),
      comment: 'I love cheese!',
    ),
  ];

  static List<UserCommentModel> sampleComments3 = [
    UserCommentModel(
      userName: 'Bart Simpson',
      userProfile:
          'https://i.pinimg.com/564x/d6/66/73/d66673d253a2385b8669085613f5c234.jpg',
      commentTime: DateTime.now().subtract(const Duration(days: 7)),
      comment: 'Ay, caramba!',
    ),
    UserCommentModel(
      userName: 'Homer Simpson',
      userProfile:
          'https://i.pinimg.com/564x/84/e4/2a/84e42a599011057a5f48498a5e467d51.jpg',
      commentTime: DateTime.now().subtract(const Duration(days: 8)),
      comment: 'Mmm... donuts.',
    ),
    UserCommentModel(
      userName: 'Mickey Mouse',
      userProfile:
          'https://i.pinimg.com/564x/a1/c2/f5/a1c2f5589568829b689647f5143b5663.jpg',
      commentTime: DateTime.now().subtract(const Duration(days: 9)),
      comment: 'Oh, boy!',
    ),
  ];

  static List<UserCommentModel> sampleComments4 = [
    UserCommentModel(
      userName: 'Bugs Bunny',
      userProfile:
          'https://i.pinimg.com/564x/50/9f/34/509f34da7581990c2b241122d97b2443.jpg',
      commentTime: DateTime.now().subtract(const Duration(days: 3)),
      comment: 'What\'s up, doc?',
    ),
    UserCommentModel(
      userName: 'Daffy Duck',
      userProfile:
          'https://i.pinimg.com/564x/9f/d0/93/9fd0933a9d5b08d153a9268a95172112.jpg',
      commentTime: DateTime.now().subtract(const Duration(days: 4)),
      comment: 'You\'re despicable, despicable!',
    ),
    UserCommentModel(
      userName: 'Garfield',
      userProfile:
          'https://i.pinimg.com/564x/98/8f/6c/988f6ca5327373b000a1f4f12b59a906.jpg',
      commentTime: DateTime.now().subtract(const Duration(days: 5)),
      comment: 'I\'m not fat, I\'m just fluffy.',
    ),
    UserCommentModel(
      userName: 'Snoopy',
      userProfile:
          'https://i.pinimg.com/564x/a7/88/73/a78873220c86bf129a81750c61705d2e.jpg',
      commentTime: DateTime.now().subtract(const Duration(days: 6)),
      comment: 'Zzzzz...',
    ),
  ];

  /// USER POSTS
  static List<UserPostModel> samplePosts = [
    UserPostModel(
        profileImage:
            'https://i.pinimg.com/564x/a9/3c/b7/a93cb7935e56c771aff48e72eb4295b7.jpg',
        postImage:
            'https://i.pinimg.com/564x/a9/3c/b7/a93cb7935e56c771aff48e72eb4295b7.jpg',
        userName: 'Chris',
        dateTime: DateTime.now().subtract(const Duration(hours: 2)),
        isPrimeMember: true,
        caption: 'Walking For Good Health and Be Productive all day long',
        likes: 23,
        replies: 2,
        comments: sampleComments2),
    UserPostModel(
      profileImage:
          'https://i.pinimg.com/564x/ca/59/27/ca5927d4570a6354d10453a52d9f8602.jpg',
      postImage:
          'https://i.pinimg.com/564x/ca/59/27/ca5927d4570a6354d10453a52d9f8602.jpg',
      userName: 'Evans',
      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
      isPrimeMember: false,
      caption: 'Running in the park is my favorite way to start the day!',
      likes: 23,
      replies: 2,
      comments: sampleComments2,
    ),
    UserPostModel(
        profileImage:
            'https://i.pinimg.com/564x/e4/89/29/e489290d34eaa5ee7b347ca12df22e33.jpg',
        postImage:
            'https://i.pinimg.com/564x/e4/89/29/e489290d34eaa5ee7b347ca12df22e33.jpg',
        userName: 'Robert Downey Jr',
        dateTime: DateTime.now().subtract(const Duration(hours: 7)),
        isPrimeMember: false,
        caption: 'That Road Runner is going down this time!',
        likes: 78,
        replies: 13,
        comments: sampleComments2),
    UserPostModel(
      profileImage:
          'https://i.pinimg.com/564x/e4/89/29/e489290d34eaa5ee7b347ca12df22e33.jpg',
      userName: 'Robert Downey Jr',
      dateTime: DateTime.now().subtract(const Duration(hours: 7)),
      isPrimeMember: false,
      caption: 'That Road Runner is going down this time!',
      likes: 78,
      replies: 13,
      comments: sampleComments2,
    ),
    UserPostModel(
        profileImage:
            'https://i.pinimg.com/564x/a9/3c/b7/a93cb7935e56c771aff48e72eb4295b7.jpg',
        userName: 'Chris',
        dateTime: DateTime.now().subtract(const Duration(hours: 2)),
        isPrimeMember: false,
        caption: 'Walking For Good Health and Be Productive all day long',
        likes: 23,
        replies: 2,
        comments: sampleComments2),
  ];
}
