import 'package:cloud_firestore/cloud_firestore.dart';

class CuresComment {
  final String curesId;
  final String userName;
  final int commentTime;
  final String commentContent;

  CuresComment({
    required this.curesId,
    required this.userName,
    required this.commentTime,
    required this.commentContent,
  });

  CuresComment.fromSnapshot(DocumentSnapshot snapshot)
      : curesId = snapshot['curesId'],
        userName = snapshot['userName'],
        commentTime = snapshot['commentTime'],
        commentContent = snapshot['commentContent'];
}
