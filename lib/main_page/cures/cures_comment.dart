import 'package:cloud_firestore/cloud_firestore.dart';

class CuresComment {
  final String curesId;
  final String userName;
  final int commentTime;
  final String commentContent;
  final String userId;

  CuresComment({
    required this.curesId,
    required this.userName,
    required this.commentTime,
    required this.commentContent,
    required this.userId,
  });

  CuresComment.fromSnapshot(DocumentSnapshot snapshot)
      : curesId = snapshot['curesId'],
        userName = snapshot['userName'],
        commentTime = snapshot['commentTime'],
        userId= snapshot['userId'],
        commentContent = snapshot['commentContent'];
}
