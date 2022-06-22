import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/main_page/cures/cures.dart';
import 'package:fitterapi/main_page/forum/visit_user_profile.dart';
import 'package:fitterapi/main_page/prepared/bottom_nav_bar.dart';
import 'package:fitterapi/main_page/prepared/utils.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/services/cloud_store.dart';
import 'package:fitterapi/services/user_database.dart';

import 'package:flutter/material.dart';

import '../../const.dart';
import '../../size_config.dart';

class CureCommentPage extends StatefulWidget {
  final DocumentSnapshot document;
  final String name;

  CureCommentPage({required this.document, required this.name});

  @override
  _CureCommentPageState createState() => _CureCommentPageState();
}

class _CureCommentPageState extends State<CureCommentPage> {
  late Cures _cures = Cures.fromSnapshot(widget.document);
  final currentUser = FirebaseAuth.instance.currentUser;
  String? nickname;
  String? image;
  String? id;

  // Future<String?> getData(String userId) async {
  //   DocumentReference documentReference =
  //       FirebaseFirestore.instance.collection('users').doc(userId);
  //   String? nick;
  //   String? img;
  //   String? uId;
  //   await documentReference.get().then((snapshot) {
  //     nick = snapshot.get('nickname').toString();
  //     img = snapshot.get('image').toString();
  //     uId = img = snapshot.get('userId').toString();
  //   });
  //   nickname = nick;
  //   image = img;
  //   id = uId;
  //   print('nick' + '${nickname}');
  //   return null;
  // }

  final TextEditingController _msgTextController = new TextEditingController();
  FocusNode _writingTextFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    // getData(currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: getProportionateScreenHeight(85),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          '${widget.name} Yorumları',
          style: TextStyle(
              fontSize: getProportionateScreenHeight(20),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cures')
            .doc(_cures.curesId)
            .collection('comment')
            .orderBy('commentTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          UserDatabase userDatabase = UserDatabase(uid: (currentUser!.uid));
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: getProportionateScreenHeight(10)),
                      // docs da sıkıntı çıkarsa StreamBuilder<QuerySnapshot>olarak düzenle
                      snapshot.data!.docs.length > 0
                          ? Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: snapshot.data!.docs.map((document) {
                                  return commentListItem(document, size);
                                }).toList(),
                              ),
                            )
                          : Container(
                              child: Center(
                                  child:
                                      Text('İlk yorumu siz yapabilirsiniz'))),
                    ],
                  ),
                ),
              ),
              StreamBuilder<UserData>(
                  stream: userDatabase.userData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      UserData? _userData = snapshot.data;
                      nickname=_userData!.nickname;
                      image=_userData.image;
                      id=_userData.uid;

                      return _buildTextComposer();
                    } else {
                      return Center();
                    }
                  }),
            ],
          );
        },
      ),
    );
  }

  Widget commentListItem(DocumentSnapshot data, Size size) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: getProportionateScreenWidth(48),
            height: getProportionateScreenHeight(48),
            child: Image.network(data['userImage']),
          ),
          SizedBox(width: getProportionateScreenWidth(15)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text uzun olunca rederflex hatası geliyordu. o yüzden bu ayarlar yapıldı
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // eğer kullanıcı currentuser ise profil sayfasına gönder
                          if (data['userId'] == currentUser!.uid) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavBar(selectedIndex: 5),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VisitUserProfile(user: data['userId'])),
                            );
                          }
                        },
                        child: Text(
                          data['userName'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenHeight(18)),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Text(
                        data['commentContent'],
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
                width: size.width - 100,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, top: 5),
                child: Container(
                    width: getProportionateScreenWidth(230),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Utils().readTimestamp(data['commentTime'])),
                        // Text(
                        //   'Beğen',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, color: Colors.grey),
                        // ),
                        // Text(
                        //   'Cevap Ver',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, color: Colors.grey),
                        // ),
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    // sadece burada düzgün bir şekilde update işlemini yerine getiriyor
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
                      onSubmitted: _handleSubmitted,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Yorum Yap',
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
      CloudStore.commentToCures(
          _cures.curesId!, _msgTextController.text, nickname!, image!, id!);
      FocusScope.of(context).requestFocus(FocusNode());
      _msgTextController.text = '';
    } catch (e) {
      print('Yorum göndermede sorun oldu');
    }
  }
}
