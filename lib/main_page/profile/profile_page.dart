import 'package:cloud_firestore/cloud_firestore.dart';
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

import '../prepared/idb_icons.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  UserData userData = UserData();
  int? share_count;
  List<DocumentSnapshot> listOfDocumentSnapshot = [];
  bool showList = false;

  @override
  Widget build(BuildContext context) {
    UserDatabase userDatabase = UserDatabase(uid: currentUser!.uid);
    return Scaffold(
      endDrawer: ProfileSideBar(),
      resizeToAvoidBottomInset: false,
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
              return SingleChildScrollView(
                child: Column(
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
                          margin: EdgeInsets.only(
                              top: getProportionateScreenHeight(5)),
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
                              Text(
                                _userData.nickname!,
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: "Roboto",
                                    fontSize: getProportionateScreenHeight(35),
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "${_userData.firstName!}" +
                                    " " +
                                    "${_userData.lastName!}",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontFamily: "Roboto",
                                    fontSize: getProportionateScreenHeight(18),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          // IconButton(
                          //   icon: Icon(Icons.sms,color: kPrimaryColor,size: getProportionateScreenHeight(40)),
                          //   onPressed: (){},
                          // ),
                        ],
                      ),
                    ),
                    // paylasım sayısı
                    SizedBox(height: getProportionateScreenHeight(20)),
                    StreamBuilder<dynamic>(
                        stream: FirebaseFirestore.instance
                            .collection('shares')
                            .where('userId', isEqualTo: currentUser?.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            listOfDocumentSnapshot = snapshot.data!.docs;
                            share_count = listOfDocumentSnapshot.length;
                            return Column(
                              children: [
                                // Yapılan paylaşım sayısı ve buton
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showList = !showList;
                                    });
                                  },
                                  child: Container(
                                    height: getProportionateScreenHeight(80),
                                    width: getProportionateScreenWidth(300),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                              (showList != false)
                                                  ? Icons.menu_book
                                                  : Icons.menu,
                                              color: Colors.white,
                                              size:
                                                  getProportionateScreenHeight(
                                                      27)),
                                          SizedBox(
                                              width:
                                                  getProportionateScreenWidth(
                                                      7)),
                                          RichText(
                                            text: TextSpan(children: <TextSpan>[
                                              TextSpan(
                                                  text: 'Yapılan Paylaşım : ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        getProportionateScreenHeight(
                                                            22),
                                                  )),
                                              TextSpan(
                                                  text:
                                                      '${share_count.toString()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        getProportionateScreenHeight(
                                                            22),
                                                  )),
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                //SizedBox(height: getProportionateScreenHeight(10)),

                                // paylaşımları silebilmek için
                                showList != false
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            listOfDocumentSnapshot.length,
                                        itemBuilder: (context, index) {
                                          String icon =
                                              (listOfDocumentSnapshot[index]
                                                          .data()
                                                      as Map)['about'] ??
                                                  ' ';
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                              elevation: 2.0,
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          //kür-soru... icon
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              icon == 'Çay'
                                                                  ? DBIcons.tea
                                                                  : icon ==
                                                                          'Kür'
                                                                      ? DBIcons
                                                                          .mortar
                                                                      : icon ==
                                                                              'Soru'
                                                                          ? Icons
                                                                              .announcement_rounded
                                                                          : Icons
                                                                              .insert_drive_file,
                                                              size:
                                                                  getProportionateScreenHeight(
                                                                      25),
                                                              color:
                                                                  kPrimaryColor,
                                                            ),
                                                          ),
                                                          // share title
                                                          SizedBox(
                                                            width:
                                                                getProportionateScreenWidth(
                                                                    200),
                                                            child: Text(
                                                              (listOfDocumentSnapshot[index]
                                                                              .data()
                                                                          as Map)[
                                                                      'shareTitle'] ??
                                                                  ' ',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              softWrap: false,
                                                              style: TextStyle(
                                                                fontSize:
                                                                    getProportionateScreenHeight(
                                                                        22),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      2)),
                                                          Spacer(),
                                                          // delete share
                                                          IconButton(
                                                            onPressed: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      title: Text(
                                                                          'Silmek istediğinize emin misiniz?'),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            if (snapshot.data.docs.length !=
                                                                                0) {
                                                                              // delete
                                                                              FirebaseFirestore.instance.collection('shares').doc((listOfDocumentSnapshot[index].data() as Map)['shareId'] ?? ' ').delete();
                                                                            }
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text('Sil'),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              Text('İptal'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  });
                                                              // if (snapshot.data.docs.length != 0) {
                                                              //   // delete
                                                              //   FirebaseFirestore.instance
                                                              //       .collection('shares')
                                                              //   .doc((listOfDocumentSnapshot[index]
                                                              //       .data()
                                                              //   as Map)['shareId'] ??
                                                              //       ' ')
                                                              //       .delete();
                                                              // }
                                                            },
                                                            icon: Icon(
                                                              Icons.delete,
                                                              size:
                                                                  getProportionateScreenHeight(
                                                                      28),
                                                              color:
                                                                  kPrimaryColor,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          );
                                        })
                                    : Text(' '),
                              ],
                            );
                          }
                          return Text('HATA');
                        }),
                  ],
                ),
              );
            } else {
              return Container(
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
            }
          }),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Seçenek1'),
                    Text('Seçenek2'),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Kapat'))
                ],
              );
            });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(25),
            vertical: getProportionateScreenWidth(9)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black38,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}

// int? share_count_func(String currentUserId) {
//   List<DocumentSnapshot> listOfDocumentSnapshot = [];
//   int? count;
//   StreamBuilder<dynamic>(
//       stream: FirebaseFirestore.instance
//           .collection('shares')
//           .where('userId', isEqualTo: '5sjkeNu3PQdBvkGzWPm6z6vBodf1')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           listOfDocumentSnapshot = snapshot.data!.docs;
//           count = listOfDocumentSnapshot.length;
//           return Text('');
//         }
//         return Text('');
//       });
//   print(listOfDocumentSnapshot.length);
//   print(currentUserId);
//   return count;
// }

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
            size: getProportionateScreenWidth(15),
          ),
          SizedBox(width: getProportionateScreenWidth(5)),
          TextButton(
            onPressed: onPress,
            child: Text(
              this.text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: getProportionateScreenHeight(13),
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
