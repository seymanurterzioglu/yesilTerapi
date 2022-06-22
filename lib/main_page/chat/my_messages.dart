import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/main_page/chat/message_room.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/services/user_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../const.dart';
import '../../size_config.dart';

class MyMessages extends StatefulWidget {
  @override
  State<MyMessages> createState() => _MyMessagesState();
}

class _MyMessagesState extends State<MyMessages> {
  bool unread = false;

  final currentUser = FirebaseAuth.instance.currentUser;

  List<DocumentSnapshot> listOfDocumentSnapshot = [];

  UserDatabase? userDatabase;

  // getData() async {
  //   await FirebaseFirestore.instance
  //       .collection('chat')
  //       .get()
  //       .then((QuerySnapshot? querySnapshot) {
  //     querySnapshot!.docs.forEach((doc) {
  //       allData = doc["users"];
  //       //  print("getData = ${doc["item_text_"]}");
  //     });
  //   });
  //   setState(() {
  //     sender = allData[0];  // burada hep en snuncusu kaydedilyor o yüzden değişim hep aynı
  //     taker =allData[1];
  //   });
  // }

  // streamDefine() {
  //   if (sender == currentUser!.uid) {
  //     userDatabase = UserDatabase(uid: taker);
  //   } else // başka biri bana gönderdi ise
  //   {
  //     userDatabase = UserDatabase(uid: sender);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //streamDefine();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mesajlarım',
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
        //chatroom -> kullanıcı -> who -> mesaj gönderenlerin listesi
        stream: FirebaseFirestore.instance
            .collection('chatroom')
            .doc(currentUser!.uid)
            .collection('who')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // mesaj yoksa
            return Container(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.message,
                    color: Colors.grey[700],
                    size: 64,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      'Mesajınız Yok',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )),
            );
          }
          listOfDocumentSnapshot = snapshot.data!.docs;
          //getData();

          if (listOfDocumentSnapshot.length != 0) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: listOfDocumentSnapshot.length,
              itemBuilder: (context, index) {
                userDatabase = UserDatabase(
                    uid: (listOfDocumentSnapshot[index].data()
                            as Map)['whoId'] ??
                        ' ');
                return Column(
                  children: [
                    StreamBuilder<UserData>(
                      stream: userDatabase!.userData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          UserData? _userData = snapshot.data;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type:
                                  PageTransitionType.rightToLeft,
                                  child: MessageRoom(userId:_userData!.uid!),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white70),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: unread // chat.unread
                                        ? BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)),
                                            border: Border.all(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            // shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                              ),
                                            ],
                                          )
                                        : BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
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
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  // WidgetSpan(
                                                  //   child: sender !=
                                                  //           currentUser!.uid
                                                  //       ? Icon(
                                                  //           Icons
                                                  //               .subdirectory_arrow_right,
                                                  //           size: 16)
                                                  //       : Icon(
                                                  //           Icons
                                                  //               .subdirectory_arrow_left,
                                                  //           size: 16),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.sms),
                                            // Text(
                                            //   DateFormat('kk:mm \n dd-MM-yyyy')
                                            //       .format(((listOfDocumentSnapshot[
                                            //                           index]
                                            //                       .data() as Map)[
                                            //                   'messageTime'] ??
                                            //               ' ')
                                            //           .toDate()),
                                            //   style: TextStyle(
                                            //     fontSize: 11,
                                            //     fontWeight: FontWeight.w600,
                                            //     color: Colors.black54,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(10),
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
                                  ),
                                ],
                              ),
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
                    Icons.message,
                    color: Colors.grey[700],
                    size: 64,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      'Mesajınız Yok',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )),
            );
          }
        },
      ),
    );
  }
}

// StreamBuilder<QuerySnapshot>(
//   stream: FirebaseFirestore.instance.collection('users').where('userId',isEqualTo: sender).snapshots(),
//   builder: (context,snapshot){
//     list= snapshot.data!.docs;
//     return Text(
//       (list[index].data()
//       as Map)['nickname'] ??
//           ' ',
//       style: TextStyle(
//         fontSize:
//         getProportionateScreenHeight(16),
//         fontWeight: FontWeight.bold,
//         overflow: TextOverflow.ellipsis,
//       ),
//     );
//   },
// ),
