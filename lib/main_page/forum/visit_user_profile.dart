import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/main_page/chat/send_message.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/services/cloud_store.dart';
import 'package:fitterapi/services/user_database.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import '../../size_config.dart';

class VisitUserProfile extends StatefulWidget {
  final String user; // takerId
  // final String userImage; //currentUserImage

  VisitUserProfile({required this.user});

  @override
  State<VisitUserProfile> createState() => _VisitUserProfileState();
}

class _VisitUserProfileState extends State<VisitUserProfile> {
  UserData userData = UserData();
  final currentUser = FirebaseAuth.instance.currentUser;

  int? share_count;
  List<DocumentSnapshot> listOfDocumentSnapshot = [];

  List myFriendList = [];

  getFriendList() async {
    var list = await FirebaseFirestore.instance
        .collection('friend')
        .doc(currentUser!.uid)
        .collection('list')
        .get();
    setState(() {
      myFriendList = list.docs;
    });
  }

  final TextEditingController _msgTextController = new TextEditingController();
  FocusNode _writingTextFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    UserDatabase userDatabase = UserDatabase(uid: widget.user);
    getFriendList();  //arkadaş listesini aldık
    return Scaffold(
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
      body: SingleChildScrollView(
        child: StreamBuilder<UserData>(
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
                          SizedBox(width: getProportionateScreenWidth(25)),
                          // send message
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      title: Text('Mesaj Gönder'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconTheme(
                                            data: IconThemeData(
                                                color: kPrimaryColor),
                                            child: Container(
                                              height:
                                                  getProportionateScreenHeight(
                                                      200),
                                              width:
                                                  getProportionateScreenWidth(
                                                      250),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Card(
                                                      color: Colors.white,
                                                      elevation: 2.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                getProportionateScreenHeight(
                                                                    12)),
                                                      ),
                                                      child: Container(
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  20, 5, 10, 5),
                                                          child: TextField(
                                                            focusNode:
                                                                _writingTextFocus,
                                                            controller:
                                                                _msgTextController,
                                                            //onSubmitted: _handleSubmitted,
                                                            maxLines: 7,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
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
                                            Navigator.of(context).pop();
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
                                                _msgTextController.text);

                                            Navigator.of(context).pop();
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
                              size: getProportionateScreenHeight(35),
                            ),
                          ),
                          // send friend request (if we ara not friend)
                          myFriendList.contains(_userData.uid)
                              ? Text('')
                              : IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0))),
                                            title: Text(
                                                'Arkadaşlık isteği gönder'),
                                            // content: Column(
                                            //   mainAxisSize: MainAxisSize.min,
                                            //   children: [
                                            //   ],
                                            // ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  // arkadaşlık isreği gönder
                                                  FirebaseFirestore.instance
                                                      .collection(
                                                          'friendRequest')
                                                      .doc(_userData.uid)
                                                      .collection('list')
                                                      .doc(currentUser!.uid)
                                                      .set({
                                                    'requestSenderId':currentUser!.uid,
                                                    'time': DateTime.now(),
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Kapat'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Gönder'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.person_add_alt_1,
                                    color: kPrimaryColor,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    // paylasım sayısı
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: getProportionateScreenHeight(80),
                        width: getProportionateScreenWidth(300),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: StreamBuilder<dynamic>(
                            stream: FirebaseFirestore.instance
                                .collection('shares')
                                .where('userId', isEqualTo: _userData.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                listOfDocumentSnapshot = snapshot.data!.docs;
                                share_count = listOfDocumentSnapshot.length;
                                return Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_box_outlined,
                                          color: Colors.white,
                                          size:
                                              getProportionateScreenHeight(27)),
                                      SizedBox(
                                          width:
                                              getProportionateScreenWidth(5)),
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
                                              text: '${share_count.toString()}',
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
                                );
                              }
                              return Text('HATA');
                            }),
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
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
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
      ),
    );
  }
}
