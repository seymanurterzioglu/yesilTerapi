import 'package:fitterapi/main_page/course/course_page.dart';
import 'package:fitterapi/main_page/cures/cures_page.dart';
import 'package:fitterapi/main_page/favorite/favorite_page.dart';
import 'package:fitterapi/main_page/forum/forum_page.dart';
import 'package:fitterapi/main_page/prepared/idb_icons.dart';
import 'package:fitterapi/main_page/profile/profile_page.dart';
import 'package:fitterapi/main_page/teas/teas_page.dart';
import 'package:flutter/material.dart';


class BottomNavBar extends StatefulWidget {
  late int selectedIndex;
  BottomNavBar({required this.selectedIndex});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {




  void _onItemTap(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // UserDatabase userDatabase = UserDatabase(uid: currentUser!.uid);
    return Scaffold(
      //sanırım klavye çıkınca ekranı yeniden ölçeklendirmeyi devre dışı bırakıyor
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.selectedIndex,
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
        index: widget.selectedIndex,
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
