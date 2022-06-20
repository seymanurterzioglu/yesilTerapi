import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/chat/friend_request.dart';
import 'package:fitterapi/main_page/forum/visit_user_profile.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/services/cloud_store.dart';
import 'package:fitterapi/services/user_database.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../size_config.dart';

class FriendList extends StatelessWidget {
  List<DocumentSnapshot> listOfDocumentSnapshot = [];
  final currentUser = FirebaseAuth.instance.currentUser;

  final TextEditingController _msgTextController = new TextEditingController();
  FocusNode _writingTextFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Arkadaşlarım',
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        child: FriendRequest(),
                        childCurrent: this));
              },
              icon: Icon(Icons.emoji_people),
            ),
          )
        ],
      ),
      body: StreamBuilder<dynamic>(
        stream: FirebaseFirestore.instance
            .collection('friend')
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
                              as Map)['friendId'] ??
                          ' ');
                  return Column(
                    children: [
                      StreamBuilder<UserData>(
                        stream: userDatabase.userData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            UserData? _userData = snapshot.data;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type:
                                          PageTransitionType.fade,
                                      child: VisitUserProfile(
                                          user: (listOfDocumentSnapshot[index]
                                                  .data() as Map)['friendId'] ??
                                              ' '),),
                                );
                              },
                              child: Container(
                                decoration:
                                    BoxDecoration(color: Colors.black12),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          0.45,
                                      padding: EdgeInsets.only(
                                          top: getProportionateScreenHeight(5),
                                          left:
                                              getProportionateScreenHeight(10)),
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
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
                                    ),
                                    //send message
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                  title: Text('Mesaj Gönder'),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      IconTheme(
                                                        data: IconThemeData(
                                                            color:
                                                                kPrimaryColor),
                                                        child: Container(
                                                          height:
                                                              getProportionateScreenHeight(
                                                                  200),
                                                          width:
                                                              getProportionateScreenWidth(
                                                                  250),
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      2.0),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Card(
                                                                  color: Colors
                                                                      .white,
                                                                  elevation:
                                                                      2.0,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            getProportionateScreenHeight(12)),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              20,
                                                                              5,
                                                                              10,
                                                                              5),
                                                                      child:
                                                                          TextField(
                                                                        focusNode:
                                                                            _writingTextFocus,
                                                                        controller:
                                                                            _msgTextController,
                                                                        //onSubmitted: _handleSubmitted,
                                                                        maxLines:
                                                                            7,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border:
                                                                              InputBorder.none,
                                                                          hintText:
                                                                              '    ...',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              // Container(
                                                              //   margin:
                                                              //       EdgeInsets.symmetric(
                                                              //           horizontal: 2.0),
                                                              //   child: IconButton(
                                                              //       icon: Icon(Icons.send),
                                                              //       onPressed: () {
                                                              //         //_handleSubmitted(_msgTextController.text);
                                                              //       }),
                                                              // ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Kapat'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        //mesaj yollayanlar listesine kaydet
                                                        CloudStore.messageList(
                                                          //takerId
                                                          _userData.uid!,
                                                          //senderId = currentUserId
                                                          currentUser!.uid,
                                                          // //takerImage
                                                          // _userData.image!,
                                                          // // currentUserImage =senderImage
                                                          // widget.userImage,
                                                        );

                                                        //mesajı kaydet
                                                        CloudStore.sendMessage(
                                                            //senderId
                                                            currentUser!.uid,
                                                            //takerID
                                                            _userData.uid!,
                                                            // //takerImage
                                                            // _userData.image!,
                                                            _msgTextController
                                                                .text);

                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Gönder'),
                                                    ),
                                                  ],
                                                );
                                              });

                                          //---------------------send message sayfaıan yönlednr.ama orada sorun oluştu
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) => SendMessageUser(
                                          //           messageSender: currentUser!.uid,
                                          //           messageTaker: _userData.uid!)),
                                          // );
                                        },
                                        icon: Icon(
                                          Icons.chat_bubble_outlined,
                                          color: kPrimaryColor,
                                          size:
                                              getProportionateScreenHeight(35),
                                        ),
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
                      Icons.person_pin_sharp,
                      color: kPrimaryColor,
                      size: 64,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Text(
                        'Arkadaş listeniz boş',
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
