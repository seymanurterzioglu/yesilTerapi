import 'package:cloud_firestore/cloud_firestore.dart';

class Shares {
  final String userName;
  final String userImage;
  final int shareTime;
  final String shareId;
  final String shareContent;
  final int shareLikeCount;
  final int shareCommentCount;
  final String about;
  final String shareTitle;

  Shares(
      {required this.userName,
        required this.userImage,
      required this.shareTime,
      required this.shareContent,
      required this.shareLikeCount,
      required this.shareCommentCount,
      required this.about,
      required this.shareTitle,
      required this.shareId});

  Shares.fromSnapshot(DocumentSnapshot snapshot)
      : userName = snapshot['userName'],
        userImage = snapshot['userImage'],
        shareTime = snapshot['shareTime'],
        shareContent = snapshot['shareContent'],
        shareLikeCount = snapshot['shareLikeCount'],
        shareCommentCount = snapshot['shareCommentCount'],
        about = snapshot['about'],
        shareTitle = snapshot['shareTitle'],
        shareId = snapshot['shareId'];
}
