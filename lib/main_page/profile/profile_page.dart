import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/profile/add_page.dart';
import 'package:fitterapi/main_page/profile/profile_info.dart';
import 'package:fitterapi/main_page/profile/settings.dart';
import 'package:fitterapi/main_page/profile/suggestion_page.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/services/auth.dart';
import 'package:fitterapi/services/user_database.dart';
import 'package:fitterapi/sign_in/google_sign_in.dart';
import 'package:fitterapi/sign_in/sign_in_screen.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    UserDatabase userDatabase = UserDatabase(uid: currentUser!.uid);
    return Scaffold(
      endDrawer: ProfileSideBar(),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(
              fontSize: getProportionateScreenHeight(25),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: getProportionateScreenHeight(95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: StreamBuilder<UserData>(
          stream: userDatabase.userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData? _userData = snapshot.data;
              return Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(20)),
                  // image
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: getProportionateScreenHeight(250),
                        width: getProportionateScreenWidth(230),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/circle.jpg"),
                              fit: BoxFit.cover),
                        ),
                        margin: EdgeInsets.only(top: getProportionateScreenHeight(5)),
                        child: Stack(

                          children: <Widget>[
                            Positioned(
                              top: 19,
                              left: 53,
                              child: CircleAvatar(
                                radius: getProportionateScreenWidth(80),
                                backgroundImage:
                                NetworkImage(_userData!.image!),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //user name -surname
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Container(
                    color: Colors.white10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(_userData.nickname!, style: TextStyle(color: Colors.grey[800], fontFamily: "Roboto",
                                fontSize: getProportionateScreenHeight(35), fontWeight: FontWeight.w700
                            ),),
                            Text("${_userData.firstName!}"+" "+"${_userData.lastName!}", style: TextStyle(color: Colors.grey[500], fontFamily: "Roboto",
                                fontSize:getProportionateScreenHeight(18), fontWeight: FontWeight.w400
                            ),),
                          ],
                        ),
                        // IconButton(
                        //   icon: Icon(Icons.sms,color: kPrimaryColor,size: getProportionateScreenHeight(40)),
                        //   onPressed: (){},
                        // ),
                      ],
                    ),
                  ),

                ],
              );
            } else {
              Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.error,
                      color: Colors.grey[700],
                      size: 64,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        'Bir hata ile karşılaşıldı. Lütfen\n internetinizi kontrol ediniz.',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )),
              );
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}

class ProfileSideBar extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 50),
          children: [
            DrawerHeader(
              child: Padding(
                padding: EdgeInsets.fromLTRB(80, 30, 30, 20),
                child: Text(
                  'Seçenekler',
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(30),
                      fontWeight: FontWeight.bold),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/images/g1.png"),
                      fit: BoxFit.cover)),
            ),
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
                  MaterialPageRoute(builder: (context) => SettingsProfile()),
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
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
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
    );
  }
}

// Expanded(
// child: ListView(
// children: <Widget>[
// ProfileListItem(
// icon: Icons.person_add_alt_1,
// text: 'Profil Düzenle',
// onPress: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => ProfileInfo()),
// //MaterialPageRoute(builder: (context) => ProfileEdit()),
// );
// },
// ),
// ProfileListItem(
// icon: Icons.settings,
// text: 'Ayarlar',
// onPress: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => SettingsProfile()),
// );
// },
// ),
// ProfileListItem(
// icon: Icons.add_box,
// text: 'Forumda Paylaş',
// onPress: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => AddPage()),
// );
// },
// ),
// ProfileListItem(
// icon: Icons.menu_book,
// text: 'Öneri Yaz',
// onPress: () {
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => SuggestionPage()),
// );
// },
// ),
//
// ProfileListItem(
// icon: Icons.outbond,
// text: 'Çıkış Yap',
// //çıkış yaptığı bildirimi geliyor ama başka sayfaya gidilmiyor
// onPress: () {
// final provider = Provider.of<GoogleSignInProvider>(context,
// listen: false);
// provider.logOut();
// _auth.signOut();
// Navigator.push(
// context,
// MaterialPageRoute(builder: (context) => SignInScreen()),
// );
// },
// ),
// ],
// ),
// ),

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
