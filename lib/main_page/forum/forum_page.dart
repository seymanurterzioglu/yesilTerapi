import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/main_page/forum/forum_main.dart';
import 'package:fitterapi/main_page/forum/profil_data.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/services/user_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class ForumPage extends StatefulWidget {


  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  // // çözümünü bulamadım
  // // late yapınca LateInitializationError: Field 'myName' has not been initialized. hatası
  // // String? yapınca null ceck used on  null veriable hatası
  // String myName='null';
  // late MyProfileData myData;
  // final currentUser = FirebaseAuth.instance.currentUser;
  //
  //
  // // @override
  // // void initState() {
  // //   _takeMyData();
  // //   super.initState();
  // // }
  //
  // Future<void> _takeMyData() async {
  //   //SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   setState(() {
  //     myData = MyProfileData(
  //       myName: myName,
  //     );
  //   });
  // }
  //
  // void updateMyData(MyProfileData newMyData) {
  //   setState(() {
  //     myData = newMyData;
  //   });
  // }
  //

  @override
  Widget build(BuildContext context) {
    //UserDatabase userDatabase = UserDatabase(uid: currentUser!.uid);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ForumMain(),
    );
  }
}

//
// StreamBuilder<UserData>(
// stream: userDatabase.userData,
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// UserData? _userData = snapshot.data;
// String? _firstName = _userData!.firstName;
// String? _lastName = _userData.lastName;
// myName = (_firstName! + ' ' + _lastName!);
// _takeMyData();
// return ForumMain(myData: myData, updateMyData: updateMyData);
// }
// return Container(
// child: Center(
// child: CircularProgressIndicator(),
// ),
// );
// }
// ),
