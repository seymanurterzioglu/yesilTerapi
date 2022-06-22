import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/services/cloud_store.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../const.dart';

class MessageRoom extends StatefulWidget {
  final String userId;

  MessageRoom({required this.userId});

  @override
  State<MessageRoom> createState() => _MessageRoomState();
}

class _MessageRoomState extends State<MessageRoom> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final TextEditingController _msgTextController = new TextEditingController();
  FocusNode _writingTextFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mesaj Odası',
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
            .collection('chat')
            .where('messageId', whereIn: [
              widget.userId + currentUser!.uid,
              currentUser!.uid + widget.userId
            ])
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('Bir hata ile karşılaşıldı'));
          }
          List<DocumentSnapshot> listOfDocumentSnapshot = snapshot.data!.docs;
          if (listOfDocumentSnapshot.length != 0) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listOfDocumentSnapshot.length,
                      itemBuilder: (context, index) {
                        bool isMe;
                        bool isOther;
                        String sender = (listOfDocumentSnapshot[index].data()
                                as Map)['sender'] ??
                            ' ';
                        if (sender == currentUser!.uid) {
                          isMe = true;
                          isOther = false;
                        } else {
                          isMe = false;
                          isOther = true;
                        }
                        // final bool isMe =
                        //     (listOfDocumentSnapshot[index].data() as Map)['sender'] ??
                        //         ' ' == currentUser!.uid;
                        //
                        // final bool isOther =
                        //     (listOfDocumentSnapshot[index].data() as Map)['sender'] ??
                        //         ' ' == widget.userId;

                        if (isMe) {
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    right: getProportionateScreenHeight(10),
                                    top: getProportionateScreenHeight(10)),
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.80,
                                    ),
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey.withOpacity(0.5),
                                      //     spreadRadius: 2,
                                      //     blurRadius: 5,
                                      //   ),
                                      // ],
                                    ),
                                    child: Column(
                                      children: [
                                        // Divider(
                                        //     height: 1, color: Colors.black26),
                                        Text(
                                          (listOfDocumentSnapshot[index].data()
                                                  as Map)['message'] ??
                                              ' ',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              !isOther
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          DateFormat('kk:mm').format(
                                              ((listOfDocumentSnapshot[index]
                                                              .data() as Map)[
                                                          'messageTime'] ??
                                                      ' ')
                                                  .toDate()),

                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black45,
                                          ),

                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )
                                  : Container(
                                      child: null,
                                    ),
                            ],
                          );
                        } else {
                          return Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: getProportionateScreenHeight(10),
                                    top: getProportionateScreenHeight(10)),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.80,
                                    ),
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      (listOfDocumentSnapshot[index].data()
                                              as Map)['message'] ??
                                          ' ',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              isOther
                                  ? Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          DateFormat('kk:mm').format(
                                              ((listOfDocumentSnapshot[index]
                                                              .data() as Map)[
                                                          'messageTime'] ??
                                                      ' ')
                                                  .toDate()),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black45,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(
                                      child: null,
                                    ),
                            ],
                          );
                        }
                      }),
                ),
                _buildTextComposer(),
              ],
            );
          } else {
            return Center(child: Text('list 0'));
          }
        },
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: kPrimaryColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: Card(
                color: Colors.white,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenHeight(12)),
                ),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      focusNode: _writingTextFocus,
                      controller: _msgTextController,
                      //onSubmitted: _handleSubmitted,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '    ...',
                        hintMaxLines: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _handleSubmitted(_msgTextController.text);
                    // CloudStore.sendMessage(
                    //    //senderId
                    //     currentUser!.uid,
                    //     //takerID
                    //     widget.userId,
                    //     // //takerImage
                    //     // _userData.image!,
                    //     _msgTextController.text);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmitted(String text) async {
    try {
      //print('nickname: ${widget.myData.myName}');
      CloudStore.sendMessage(
          //senderId
          currentUser!.uid,
          //takerID
          widget.userId,
          // //takerImage
          // _userData.image!,
          _msgTextController.text);
      FocusScope.of(context).requestFocus(FocusNode());
      _msgTextController.text = '';
    } catch (e) {
      print('Yorum göndermede sorun oldu');
    }
  }
}
