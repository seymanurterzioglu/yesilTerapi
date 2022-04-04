import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/main_page/forum/profil_data.dart';
import 'package:fitterapi/main_page/prepared/utils.dart';

class CloudStore{

  // static Future<void> updateShareCommentCount(String shareId){
  //
  // }

  static Future<void> commentToShare(String shareId,String commentContent, String userName) async {
    String commentId = Utils().generateRandomString(20);
    FirebaseFirestore.instance.collection('shares').doc(shareId).collection('comment').doc(commentId).set({
      'shareId':shareId,
      'userName': userName,
      'commentTime': DateTime.now().millisecondsSinceEpoch,
      'commentContent': commentContent,
      'commentLikeCount': 0,
      // 'userImage':
    });
  }

}