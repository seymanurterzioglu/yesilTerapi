import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String shareId;
  final String userName;
  final int commentTime;
  final int commentLikeCount;
  final String commentContent;

  Comment({
    required this.shareId,
    required this.userName,
    required this.commentTime,
    required this.commentLikeCount,
    required this.commentContent,
  });

  Comment.fromSnapshot(DocumentSnapshot snapshot)
      : shareId = snapshot['shareId'],
        userName = snapshot['userName'],
        commentTime = snapshot['commentTime'],
        commentLikeCount = snapshot['commentLikeCount'],
        commentContent = snapshot['commentContent'];
}
