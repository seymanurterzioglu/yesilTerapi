import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/main_page/forum/forum_main.dart';
import 'package:fitterapi/main_page/prepared/utils.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/services/user_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profil_data.dart';


class ForumPage extends StatefulWidget {
  // final MyProfileData myData;
  // ForumPage({required this.myData});
  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  late MyProfileData myData = MyProfileData(myName: ' ', image: ' ');

  Future<void> _takeMyData(String myName, String image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.get('myName') == null) {
      String tempName = Utils().generateRandomString(6);
      prefs.setString('myName', tempName);
      myName = tempName;
    }
    setState(() {
      myData = MyProfileData(
        myName: myName,
        image: image,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    UserDatabase userDatabase = UserDatabase(uid: currentUser!.uid);
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<UserData>(
          stream: userDatabase.userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData? _userData = snapshot.data;
              _takeMyData(_userData!.nickname!, _userData.image!);
              return ForumMain(myData: myData);
            }
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),


    );
  }
}

