import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/main_page/forum/profil_data.dart';
import 'package:fitterapi/main_page/prepared/utils.dart';

class CloudStore {
  static Future<void> likeToShare(String shareId, MyProfileData userProfile,
      bool isLikeShare) async {
    if (isLikeShare) {
      DocumentReference likeReference = FirebaseFirestore.instance
          .collection('shares')
          .doc(shareId)
          .collection('like')
          .doc(userProfile.myName);
      await FirebaseFirestore.instance
          .runTransaction((Transaction myTransaction) async {
        await myTransaction.delete(likeReference);
      });
    } else {
      await FirebaseFirestore.instance
          .collection('shares')
          .doc(shareId)
          .collection('like')
          .doc(userProfile.myName)
          .set({
        'userName': userProfile.myName,
        'userImage': userProfile.image,
      });
    }

    // if (isLikePost) {
    //   DocumentReference likeReference = FirebaseFirestore.instance.collection('shares').doc(shareId).collection('like').doc(userProfile.myName);
    //   await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
    //     await myTransaction.delete(likeReference);
    //   });
    // }else {
    //   await FirebaseFirestore.instance.collection('shares').doc(shareId).collection('like').doc(userProfile.myName).set({
    //     'userName':userProfile.myName,
    //     'userImage':userProfile.image,
    //   });
    // }
  }

  //share like count
  static Future<void> updateShareLikeCount(DocumentSnapshot postData, bool isLikeShare) async {
    int count=postData['shareLikeCount'];
    isLikeShare ? count=count-1 : count=count+1;
    print(count);
    postData.reference
        .update({'shareLikeCount': FieldValue.increment(isLikeShare ? -1 : 1)});
  }

  // share comment like count
  // static Future<void> updateCommentLikeCount(DocumentSnapshot postData,bool isLikePost,MyProfileData myProfileData) async{
  //   postData.reference.update({'commentLikeCount': FieldValue.increment(isLikePost ? -1 : 1)});
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       flutterLocalNotificationsPlugin.show(
  //           notification.hashCode,
  //           notification.title,
  //           notification.body,
  //           NotificationDetails(
  //             android: AndroidNotificationDetails(
  //               channel.id,
  //               channel.name,
  //               channel.description,
  //               // TODO add a proper drawable resource to android, for now using
  //               //      one that already exists in example app.
  //               icon: 'launch_background',
  //             ),
  //           ));
  //     }
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('A new onMessageOpenedApp event was published!');
  //     Navigator.pushNamed(context, '/message',
  //         arguments: MessageArguments(message, true));
  //   });
  //   if(!isLikePost){
  //     await FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //       print('A new onMessageOpenedApp event was published!');
  //       Navigator.pushNamed(context, '/message',
  //           arguments: MessageArguments(message, true));
  //     });
  //     await FirebaseMessaging.instance.sendNotificationMessageToPeerUser('${myProfileData.myName} likes your comment','${myProfileData.myName}',postData['FCMToken']);
  //   }
  // }

  static Future<void> commentToShare(String shareId, String commentContent,
      String userName, String image) async {
    String commentId = Utils().generateRandomString(20);
    FirebaseFirestore.instance
        .collection('shares')
        .doc(shareId)
        .collection('comment')
        .doc(commentId)
        .set({
      'shareId': shareId,
      'userName': userName,
      'commentTime': DateTime.now().millisecondsSinceEpoch,
      'commentContent': commentContent,
      'commentLikeCount': 0,
      'userImage': image,
      // 'userImage':
    });
  }

  static Future<void> commentToCures(String curesId, String commentContent,
      String userName, String image) async {
    String commentId = Utils().generateRandomString(20);
    FirebaseFirestore.instance
        .collection('cures')
        .doc(curesId)
        .collection('comment')
        .doc(commentId)
        .set({
      'curesId': curesId,
      'userName': userName,
      'commentTime': DateTime.now().millisecondsSinceEpoch,
      'commentContent': commentContent,
      'userImage': image,
      // 'userImage':
    });
  }
}
