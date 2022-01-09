import 'package:fitterapi/main_page/course/course_page.dart';
import 'package:fitterapi/main_page/cures/cures_page.dart';
import 'package:fitterapi/main_page/favorite/favorite_page.dart';
import 'package:fitterapi/main_page/forum/forum_page.dart';
import 'package:fitterapi/main_page/prepared/idb_icons.dart';
import 'package:fitterapi/main_page/profile/profile_page.dart';
import 'package:fitterapi/main_page/teas/teas_page.dart';

import 'package:flutter/material.dart';


class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //sanırım klavye çıkınca ekranı yeniden ölçeklendirmeyi devre dışı bırakıyor
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        items: const <BottomNavigationBarItem>[

          // forum sayfasını dizayn etmedim
          // edince geri ekleyceğim

          // BottomNavigationBarItem(
          //   icon: Icon(DBIcons.home, color: Colors.black),
          //   label: "Anasayfa",
          // ),
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


      body: IndexedStack(
        index: _selectedIndex,
        children: [
          //ForumPage(), //index 0
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
