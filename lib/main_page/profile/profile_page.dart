import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/profile/add_page.dart';

import 'package:fitterapi/main_page/profile/profile_info.dart';

import 'package:fitterapi/main_page/profile/settings.dart';
import 'package:fitterapi/main_page/profile/suggestion_page.dart';

import 'package:fitterapi/services/auth.dart';

import 'package:fitterapi/sign_in/google_sign_in.dart';
import 'package:fitterapi/sign_in/sign_in_screen.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ProfilePage extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: getProportionateScreenHeight(150)),
          // for image
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     SizedBox(width: getProportionateScreenWidth(10)),
          //     Container(
          //       height: getProportionateScreenHeight(170),
          //       width: getProportionateScreenWidth(130),
          //       margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
          //       child: Stack(
          //         children: <Widget>[
          //           CircleAvatar(
          //             radius: 80,
          //             backgroundImage: AssetImage('assets/images/back4.jpg'),
          //           ),
          //           // Align(
          //           //   alignment: Alignment.bottomRight,
          //           //   child: Container(
          //           //     height: getProportionateScreenHeight(40),
          //           //     width: getProportionateScreenWidth(40),
          //           //     decoration: BoxDecoration(
          //           //       color: Colors.white70,
          //           //       shape: BoxShape.circle,
          //           //     ),
          //           //     child: Icon(
          //           //       Icons.edit,
          //           //       color: Colors.black,
          //           //       size: getProportionateScreenHeight(25),
          //           //     ),
          //           //   ),
          //           // ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          //  List
          Expanded(
            child: ListView(
              children: <Widget>[
                ProfileListItem(
                  icon: Icons.person_add_alt_1,
                  text: 'Profil Düzenle',
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileInfo()),
                      //MaterialPageRoute(builder: (context) => ProfileEdit()),
                    );
                  },
                ),
                ProfileListItem(
                  icon: Icons.settings,
                  text: 'Ayarlar',
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsProfile()),
                    );
                  },
                ),
                ProfileListItem(
                  icon: Icons.add_box,
                  text: 'Forumda Paylaş',
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPage()),
                    );
                  },
                ),
                ProfileListItem(
                  icon: Icons.menu_book,
                  text: 'Öneri Yaz',
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SuggestionPage()),
                    );
                  },
                ),
                ProfileListItem(
                  icon: Icons.outbond,
                  text: 'Çıkış Yap',
                  //çıkış yaptığı bildirimi geliyor ama başka sayfaya gidilmiyor
                  onPress: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.logOut();
                    _auth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData? icon;
  final text;
  final bool? hasNavigation;
  final VoidCallback? onPress;

  const ProfileListItem({
    Key? key,
    this.icon,
    this.text,
    this.hasNavigation = true,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(55),
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(35))
          .copyWith(bottom: getProportionateScreenHeight(20)),
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(30)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(20)),
        color: kPrimaryColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: getProportionateScreenWidth(20),
          ),
          SizedBox(width: getProportionateScreenWidth(15)),
          TextButton(
            onPressed: onPress,
            child: Text(
              this.text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Spacer(),
          if (this.hasNavigation!)
            Icon(
              Icons.chevron_right,
              size: getProportionateScreenWidth(20),
            ),
        ],
      ),
    );
  }
}
