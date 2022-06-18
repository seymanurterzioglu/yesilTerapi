import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/main_page/forum/visit_user_profile.dart';
import 'package:fitterapi/main_page/prepared/bottom_nav_bar.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/services/user_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../const.dart';
import '../../size_config.dart';

class FriendRequest extends StatelessWidget {
  List<DocumentSnapshot> listOfDocumentSnapshot = [];
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Arkadaş istekleri',
          style: TextStyle(
              fontSize: getProportionateScreenHeight(25),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: getProportionateScreenHeight(95),
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        // ),
        backgroundColor: kPrimaryColor,
      ),
      body: StreamBuilder<dynamic>(
        stream: FirebaseFirestore.instance
            .collection('friendRequest')
            .doc(currentUser!.uid)
            .collection('list')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            listOfDocumentSnapshot = snapshot.data!.docs;
            if (listOfDocumentSnapshot.length > 0) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: listOfDocumentSnapshot.length,
                itemBuilder: (context, index) {
                  UserDatabase userDatabase = UserDatabase(
                      uid: (listOfDocumentSnapshot[index].data()
                              as Map)['requestSenderId'] ??
                          ' ');
                  return Column(
                    children: [
                      //  request adedi
                      Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(10),
                            left: getProportionateScreenHeight(150),
                            bottom: getProportionateScreenHeight(10),
                            right: getProportionateScreenHeight(150)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                getProportionateScreenHeight(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person_add_alt,
                                  size: getProportionateScreenHeight(40),
                                  color: kPrimaryColor,
                                ),
                                SizedBox(width: getProportionateScreenWidth(5)),
                                RichText(
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: (listOfDocumentSnapshot.length)
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenHeight(25),
                                        )),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder<UserData>(
                        stream: userDatabase.userData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            UserData? _userData = snapshot.data;
                            return Container(
                              decoration: BoxDecoration(color: Colors.white),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(
                                        _userData!.image!,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    padding: EdgeInsets.only(
                                        top: getProportionateScreenHeight(5),
                                        left: getProportionateScreenHeight(25)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            GestureDetector(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              '${_userData.nickname!}   ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    20),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // ekleyeceğim
                                                  Text(
                                                    DateFormat('kk:mm \n dd-MM-yyyy')
                                                        .format(((listOfDocumentSnapshot[
                                                                            index]
                                                                        .data() as Map)['time'] ??
                                                                ' ')
                                                            .toDate()),
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .fade,
                                                        child: VisitUserProfile(
                                                            user: _userData
                                                                .uid!)));
                                              },
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      10),
                                            ),
                                            // Container(
                                            //   alignment: Alignment.topLeft,
                                            //   child: Text(
                                            //     (listOfDocumentSnapshot[index].data()
                                            //             as Map)['message'] ??
                                            //         ' ',
                                            //     style: TextStyle(
                                            //       fontSize:
                                            //           getProportionateScreenHeight(13),
                                            //       color: Colors.black54,
                                            //     ),
                                            //     overflow: TextOverflow.ellipsis,
                                            //     maxLines: 1,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  // arkadaşlık isteği reddet
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'friendRequest')
                                                      .doc(currentUser!.uid)
                                                      .collection('list')
                                                      .doc(_userData.uid)
                                                      .delete();
                                                  // sonra profil ana sayfa
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child: BottomNavBar(
                                                            selectedIndex: 5,
                                                          )));
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  size:
                                                      getProportionateScreenHeight(
                                                          30),
                                                )),
                                            IconButton(
                                                onPressed: () {
                                                  // arkadaşlık isteği kabul et
                                                  // gönderenin arkadaşlarına kaydet
                                                  FirebaseFirestore.instance
                                                      .collection('friend')
                                                      .doc(_userData.uid)
                                                      .collection('list')
                                                      .doc(currentUser!.uid)
                                                      .set({
                                                    'friendId':
                                                        currentUser!.uid,
                                                  });
                                                  // current user arkadaşlara kaydet
                                                  FirebaseFirestore.instance
                                                      .collection('friend')
                                                      .doc(currentUser!.uid)
                                                      .collection('list')
                                                      .doc(_userData.uid)
                                                      .set({
                                                    'friendId': _userData.uid,
                                                  });

                                                  // sonra arkadaş request listesinden sil
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                      'friendRequest')
                                                      .doc(currentUser!.uid)
                                                      .collection('list')
                                                      .doc(_userData.uid)
                                                      .delete();

                                                  //sonra profil ana sayfaya git
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child: BottomNavBar(
                                                            selectedIndex: 5,
                                                          )));
                                                },
                                                icon: Icon(
                                                  Icons.done,
                                                  size:
                                                      getProportionateScreenHeight(
                                                          30),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Center();
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              return Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person_add_disabled,
                      color: kPrimaryColor,
                      size: 64,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        'Yeni arkadaş isteği yok',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )),
              );
            }
          }
        },
      ),
    );
  }
}
