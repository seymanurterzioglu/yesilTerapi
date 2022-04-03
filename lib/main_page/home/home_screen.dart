import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/main_page/forum/profil_data.dart';
import 'package:fitterapi/main_page/prepared/utils.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/services/user_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../prepared/bottom_nav_bar.dart';


class HomeScreen extends StatefulWidget {
  static String routeName = "/login";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // çözümünü bulamadım
  // late yapınca LateInitializationError: Field 'myName' has not been initialized. hatası
  // String? yapınca null ceck used on  null veriable hatası
    MyProfileData? myData;
  final currentUser = FirebaseAuth.instance.currentUser;
  //
  // @override
  // void initState(){
  //   _takeMyData();
  //   super.initState();
  // }

  Future<void> _takeMyData(String myName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.get('myName') == null) {
      String tempName = Utils().generateRandomString(6);
      prefs.setString('myName',tempName);
      myName = tempName;
    }
    setState(() {
      myData = MyProfileData(
        myName: myName,
      );
    });
  }

  void updateMyData(MyProfileData newMyData) {
    setState(() {
      myData = newMyData;
    });
  }

  @override
  Widget build(BuildContext context) {
    //UserDatabase userDatabase = UserDatabase(uid: currentUser!.uid);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),


    );
  }
}
//
// StreamBuilder<UserData>(
// stream: userDatabase.userData,
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// UserData? _userData = snapshot.data;
// _takeMyData(_userData!.nickname!);
// return BottomNavBar();
// }
// return Container(
// child: Center(
// child: CircularProgressIndicator(),
// ),
// );
// }
// ),
