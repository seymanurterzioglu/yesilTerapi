import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/main_page/forum/share/shares.dart';
import 'package:fitterapi/main_page/prepared/idb_icons.dart';
import 'package:fitterapi/main_page/prepared/utils.dart';
import 'package:fitterapi/services/cloud_store.dart';
import 'package:flutter/material.dart';
import '../../../const.dart';
import '../../../size_config.dart';
import '../profil_data.dart';



// ignore: must_be_immutable
class ShareDetail extends StatefulWidget {
  DocumentSnapshot document;
  final MyProfileData myData;
  final ValueChanged<MyProfileData> updateMyData;
  ShareDetail({required this.document,required this.myData,required this.updateMyData});

  @override
  _ShareDetailState createState() => _ShareDetailState();
}

class _ShareDetailState extends State<ShareDetail> {
  late DocumentSnapshot data;
  late Shares share = Shares.fromSnapshot(widget.document);
  late int newCommentCount=share.shareCommentCount;
  String? nickname;
  String? image;



  @override
  void initState() {

    super.initState();
  }


  final TextEditingController _msgTextController = new TextEditingController();
  FocusNode _writingTextFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    nickname=widget.myData.myName;
    image=widget.myData.image;
    final size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      // klavyeden oluşan renderflex hatası için
       //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: getProportionateScreenHeight(95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          'Paylaşım Detayı',
          style: TextStyle(
              fontSize: getProportionateScreenHeight(25),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('shares').doc(share.shareId)
            .collection('comment').orderBy('commentTime',descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          newCommentCount=snapshot.data!.docs.length;
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 2.0,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      share.about == 'Çay'
                                          ? DBIcons.tea
                                          : share.about == 'Kür'
                                          ? DBIcons.mortar
                                          : share.about == 'Soru'
                                          ? Icons.announcement_rounded
                                          : Icons.insert_drive_file,
                                      size: getProportionateScreenHeight(32),
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      //  kullanıcı ismine tıklandığında kullanıcının profil sayfasını götürecek
                                      GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          share.userName,
                                          style: TextStyle(
                                            fontSize:
                                            getProportionateScreenHeight(20),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: getProportionateScreenHeight(
                                              2)),
                                      Text(
                                        Utils().readTimestamp(share.shareTime),
                                        style: TextStyle(
                                            fontSize:
                                            getProportionateScreenHeight(15)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // paylaşımın başlığı
                              SizedBox(
                                height: getProportionateScreenHeight(5),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(7, 4, 10, 2),
                                      child: Text(
                                        share.shareTitle,
                                        style: TextStyle(
                                            fontSize:
                                            getProportionateScreenHeight(22),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(height: 4, color: Colors.black26),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    4, 10, 4, 10),
                                child: Text(
                                  share.shareContent,
                                  style: TextStyle(
                                      fontSize: getProportionateScreenHeight(
                                          20)),
                                ),
                              ),
                              //Divider(height: 4, color: Colors.black26),
                              // Beğen-Yorum
                              Padding(
                                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .end,
                                  children: [
                                    // Beğen
                                    // Row(
                                    //   children: [
                                    //     Icon(Icons.thumb_up_alt_outlined),
                                    //     SizedBox(
                                    //         width: getProportionateScreenWidth(
                                    //             5)),
                                    //
                                    //     // farklı renklerde metinler yazabilmek için
                                    //     RichText(
                                    //       text: TextSpan(children: <TextSpan>[
                                    //         TextSpan(
                                    //             text: 'Beğen ',
                                    //             style: TextStyle(
                                    //               color: kPrimaryColor,
                                    //               fontSize:
                                    //               getProportionateScreenHeight(
                                    //                   18),
                                    //             )),
                                    //         TextSpan(
                                    //             text: '(${share
                                    //                 .shareLikeCount})',
                                    //             style: TextStyle(
                                    //               color: Colors.black,
                                    //               fontSize:
                                    //               getProportionateScreenHeight(
                                    //                   18),
                                    //             )),
                                    //       ]),
                                    //     ),
                                    //     // Text(
                                    //     //   "Beğen (${share.shareLikeCount})",
                                    //     //   style: TextStyle(
                                    //     //       color: kPrimaryColor,
                                    //     //       fontSize: getProportionateScreenHeight(18),
                                    //     //       fontWeight: FontWeight.bold),
                                    //     // ),
                                    //   ],
                                    // ),
                                    // Yorum
                                    Row(
                                      children: [
                                        Icon(Icons.comment_outlined,color: kPrimaryColor,),
                                        SizedBox(
                                            width: getProportionateScreenWidth(
                                                5)),
                                        RichText(
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                '${newCommentCount}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                  getProportionateScreenHeight(
                                                      18),
                                                )),
                                          ]),
                                        ),
                                        // Text(
                                        //   "Yorum (${share.shareCommentCount})",
                                        //   style: TextStyle(
                                        //       color: kPrimaryColor,
                                        //       fontSize: getProportionateScreenHeight(18),
                                        //       fontWeight: FontWeight.bold),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      snapshot.data!.docs.length > 0 ? Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((document) {
                            return commentListItem(document, size);
                          }).toList(),
                        ),
                      )
                      : Container(child: Center(child: Text('İlk yorumu siz yapabilirsiniz'))),
                    ],
                  ),
                ),
              ),
              _buildTextComposer(),
            ],
          );
        },
      ),
    );

  }

  // firebase de ki share comment count günceller
  updateCommentCount(){
    FirebaseFirestore.instance.collection('shares').doc(share.shareId).update({'shareCommentCount': (newCommentCount)});
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
                      Text(
                        data['userName'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenHeight(18)),
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
                        Text(
                          'Beğen',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
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
    updateCommentCount();
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

    // Şimdiki kullanıcın ismini buraya göndermem gerek
  Future<void> _handleSubmitted(String text) async {
    try {
      //print('nickname: ${widget.myData.myName}');
      CloudStore.commentToShare(
          share.shareId, _msgTextController.text, nickname!,image!);
      FocusScope.of(context).requestFocus(FocusNode());
      _msgTextController.text = '';
    } catch (e) {
      print('Yorum göndermede sorun oldu');
    }
  }
}
