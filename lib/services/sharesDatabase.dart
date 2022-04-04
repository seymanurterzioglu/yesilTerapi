import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/main_page/forum/share/shares.dart';

class SharesDatabase{

  final CollectionReference sharesCollection =
  FirebaseFirestore.instance.collection('shares');

  Stream<QuerySnapshot> getSharesList() {
    return sharesCollection.orderBy('postTime',descending: true).snapshots();
  }

  List<Shares> _shareListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Shares(
        userName: doc.get('userName') ?? '',
        userImage: doc.get('userImage') ?? '',
        shareTime: doc.get('shareTime') ?? '',
        shareContent: doc.get('shareContent') ?? '',
        shareLikeCount: doc.get('shareLikeCount') ?? '',
        shareCommentCount: doc.get('shareCommentCount') ?? '',
        about: doc.get('about') ?? '',
        shareTitle: doc.get('shareTitle') ?? '',
        shareId: doc.get('shareId') ?? '',
      );
    }).toList();
  }



  Stream<List<Shares>> get shareData {
    return sharesCollection.snapshots().map(_shareListFromSnapshot);
  }

}