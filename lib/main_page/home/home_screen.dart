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
  // final currentUser = FirebaseAuth.instance.currentUser;
  // late MyProfileData myData = MyProfileData(myName: ' ', image: ' ');
  //
  // Future<void> _takeMyData(String myName, String image) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   if (prefs.get('myName') == null) {
  //     String tempName = Utils().generateRandomString(6);
  //     prefs.setString('myName', tempName);
  //     myName = tempName;
  //   }
  //   setState(() {
  //     myData = MyProfileData(
  //       myName: myName,
  //       image: image,
  //     );
  //   });
  // }
  //
  // void updateMyData(MyProfileData newMyData) {
  //   setState(() {
  //     myData = newMyData;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //UserDatabase userDatabase = UserDatabase(uid: currentUser!.uid);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}
