
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/main_page/cures/cures.dart';

class CuresDatabase {
  final CollectionReference curesCollection =
  FirebaseFirestore.instance.collection('cures');

  Future<Cures?> addCure(String _curesName,String _about,String _recipe,String _image)async {
    var documentRef = await curesCollection.add({
      'curesName': _curesName,
      'about': _about,
      'recipe': _recipe,
      'image': _image,
    });

  }

  Stream<QuerySnapshot> getCureList() {
    return curesCollection.orderBy('curesName').snapshots();
  }


  // Cures _curesFromSnapshot(DocumentSnapshot snapshot) {
  //   return Cures(
  //     curesName: snapshot['curesName'],
  //     about: snapshot['about'],
  //     recipe:snapshot['recipe'],
  //     image:snapshot['image'],
  //   );
  // }

  List<Cures> _curesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Cures(
        curesName: doc.get('curesName') ?? '',
        about: doc.get('about') ?? '',
        recipe: doc.get('recipe') ?? '',
        image: doc.get('image') ?? '',
      );
    }).toList();
  }

  Stream<List<Cures>> get curesData {
    return curesCollection.snapshots().map(_curesListFromSnapshot);
  }

}
