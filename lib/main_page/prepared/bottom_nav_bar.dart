import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/main_page/course/course_page.dart';
import 'package:fitterapi/main_page/cures/cures_page.dart';
import 'package:fitterapi/main_page/favorite/favorite_page.dart';
import 'package:fitterapi/main_page/forum/forum_page.dart';
import 'package:fitterapi/main_page/forum/profil_data.dart';
import 'package:fitterapi/main_page/prepared/idb_icons.dart';
import 'package:fitterapi/main_page/prepared/utils.dart';
import 'package:fitterapi/main_page/profile/profile_page.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/main_page/teas/teas_page.dart';
import 'package:fitterapi/services/user_database.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
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
  //     print(myName);
  //   });
  // }

  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // UserDatabase userDatabase = UserDatabase(uid: currentUser!.uid);
    return Scaffold(
      //sanırım klavye çıkınca ekranı yeniden ölçeklendirmeyi devre dışı bırakıyor
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        items: const <BottomNavigationBarItem>[
          // forum sayfasını dizayn etmedim
          // edince geri ekleyceğim

          BottomNavigationBarItem(
            icon: Icon(DBIcons.home, color: Colors.black),
            label: "Anasayfa",
          ),
          BottomNavigationBarItem(
            icon: Icon(DBIcons.tea, color: Colors.black),
            label: "Çaylar",
          ),
          BottomNavigationBarItem(
            icon: Icon(DBIcons.mortar, color: Colors.black),
            label: "Kürler",
          ),
          BottomNavigationBarItem(
            icon: Icon(DBIcons.course, color: Colors.black),
            label: "Seminerler",
          ),
          BottomNavigationBarItem(
            icon: Icon(DBIcons.star, color: Colors.black),
            label: "Kaydedilenler",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.perm_contact_cal_rounded,
              color: Colors.black,
            ),
            label: "Profil",
          ),
        ],
      ),

      // userData bilgilerini profil data ya ekleme home_screen de materialapp altına yapılınca
      // sayfa yüklenmede sorun oluyor. hafıza sürekli doluyor .
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          ForumPage(), //index 0
          TeaPage(), // index 1
          CuresPage(), //index 2
          CoursePage(), //index 3
          FavoritePage(), //index 4
          ProfilePage(), //index 5
        ],
      ),
    );
  }
}
