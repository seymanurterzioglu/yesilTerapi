import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/main_page/profile/users_info.dart';

class UserDatabase {
  final String? uid;

  UserDatabase({this.uid});

  final CollectionReference terapiCollection =
  FirebaseFirestore.instance.collection('users');

  Future updateUserData(String firstName, String lastName, String age,
      String height, String weight, String disease, String discomfort) async {
    return await terapiCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'height': height,
      'weight': weight,
      'disease': disease,
      'discomfort': discomfort,
    });
  }

  List<UsersInfo> _usersListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return UsersInfo(
        firstName: doc.get('firstName') ?? '', //?? eğer varsa
        lastName: doc.get('lastName') ?? '',
        age: doc.get('age') ?? '',
        height: doc.get('height') ?? '',
        weight: doc.get('weight') ?? '',
        disease: doc.get('disease') ?? '',
        discomfort: doc.get('discomfort') ?? '',
      );
    }).toList();
  }

  // get stream
  Stream<List<UsersInfo>> get users {
    return terapiCollection.snapshots().map(_usersListFromSnapshot);
  }
}
