import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/main_page/profile/users_info.dart';

class UserDatabase {
  final String? uid;


  UserDatabase({this.uid});

  final CollectionReference terapiCollection =
      FirebaseFirestore.instance.collection('users');

  Future getUserData() async {
    try {
      DocumentSnapshot ds = await terapiCollection.doc(uid).get();
      String firstName = ds.get('firstName') ?? '';
      String lastName = ds.get('lastName');
      String age = ds.get('age');
      String height = ds.get('height');
      String weight = ds.get('weight');
      String disease = ds.get('disease');
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //users list from snapshot
  List<UsersInfo> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UsersInfo(
        firstName: doc.get('firstName') ?? '',
        //?? eğer varsa
        lastName: doc.get('lastName') ?? '',
        age: doc.get('age') ?? '',
        height: doc.get('height') ?? '',
        weight: doc.get('weight') ?? '',
        disease: doc.get('disease') ?? '',
      );
    }).toList();
  }

  //users data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      age: snapshot['age'],
      height: snapshot['height'],
      weight: snapshot['weight'],
      disease: snapshot['disease'],
      // //hangisinin işe yaradığı test edilecek
      // firstName: (snapshot.data() as DocumentSnapshot)['firstName'],
      // lastName: (snapshot.data() as DocumentSnapshot)['lastName'],
      // age: (snapshot.data() as DocumentSnapshot)['age'],
      // height: (snapshot.data() as DocumentSnapshot)['height'],
      // weight: (snapshot.data() as DocumentSnapshot)['weight'],
      // disease: (snapshot.data() as DocumentSnapshot)['disease'],
    );
  }

  // get stream
  Stream<List<UsersInfo>> get users {
    return terapiCollection.snapshots().map(_usersListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return terapiCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}
