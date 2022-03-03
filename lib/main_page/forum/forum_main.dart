import 'package:fitterapi/main_page/forum/write_info.dart';
import 'package:fitterapi/main_page/prepared/search.dart';
import 'package:fitterapi/main_page/prepared/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const.dart';
import '../../size_config.dart';

class PostDataStructure {
  final String userName;
  final int postTime;
  final String postContent;

  //final String postImage;
  final int postLikeCount;
  final int postCommentCount;

  PostDataStructure(
      {required this.userName,
      required this.postTime,
      required this.postContent,
      //required this.postImage,
      required this.postLikeCount,
      required this.postCommentCount});
}

class ForumMain extends StatefulWidget {
  @override
  _ForumMainState createState() => _ForumMainState();
}

class _ForumMainState extends State<ForumMain> {
  List<PostDataStructure> dummyData = [
    new PostDataStructure(
        userName: "Derya",
        postTime: DateTime.now()
            .subtract(new Duration(seconds: 10))
            .millisecondsSinceEpoch,
        postContent: "test",
        postLikeCount: 4,
        postCommentCount: 5),
    new PostDataStructure(
        userName: "Menekşe",
        postTime: DateTime.now()
            .subtract(new Duration(hours: 3))
            .millisecondsSinceEpoch,
        postContent: "test var",
        postLikeCount: 4,
        postCommentCount: 5),
    new PostDataStructure(
        userName: "Emre",
        postTime: DateTime.now()
            .subtract(new Duration(days: 2))
            .millisecondsSinceEpoch,
        postContent: "yeni deneme",
        postLikeCount: 4,
        postCommentCount: 5),
    new PostDataStructure(
        userName: "Suzan",
        postTime: DateTime.now()
            .subtract(new Duration(seconds: 10))
            .millisecondsSinceEpoch,
        postContent:
            "yenfvgsdfxdslkflsdjklfkjsdljflkdsjflkjsdlkfjsldjflsjdfljsdlfsdf"
            "sdfldsjkflkjsdf"
            "sdfkldsjflkdsjfkls"
            "fdslfkjsdlfjkskldfj"
            "sdflsdkfjlsdkjflksdj",
        postLikeCount: 4,
        postCommentCount: 5),
  ];
  bool _isLoading = false;

  @override
  void initState() {
    // _takeUserDataFromFB();
    super.initState();
  }

  Future<void> _takeUserDataFromFB() async {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: getProportionateScreenHeight(95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Text(
            'Paylaşımlar',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenHeight(26),
                color: Colors.black),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 30, 10),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  side: BorderSide(width: 2, color: Colors.white60),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    builder: ((builder) => bottomChoiceSheet()),
                    context: context,
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.add_box_outlined, color: Colors.black),
                    SizedBox(width: getProportionateScreenWidth(3)),
                    Text(
                      'Paylaş',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Container(
          //   padding: EdgeInsets.symmetric(
          //       vertical: getProportionateScreenWidth(20),
          //       horizontal: getProportionateScreenHeight(20)),
          //   decoration: BoxDecoration(
          //     color: kPrimaryColor,
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(50),
          //       bottomRight: Radius.circular(50),
          //     ),
          //   ),
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(
          //         vertical: getProportionateScreenWidth(10),
          //         horizontal: getProportionateScreenHeight(30)),
          //     child: Row(
          //       children: <Widget>[
          //         Container(
          //           width: getProportionateScreenWidth(250),
          //           height: 50,
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               Text(
          //                 "Paylaşımlar",
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: getProportionateScreenHeight(30),
          //                     color: Colors.black),
          //               ),
          //               SizedBox(width: getProportionateScreenWidth(10)),
          //               OutlinedButton(
          //                 style: OutlinedButton.styleFrom(
          //                     shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(10.0),
          //                     ),
          //                     side: BorderSide(width: 2, color: Colors.white70)
          //                 ),
          //                 onPressed: () {},
          //                 child: Text(
          //                   'Paylaş',
          //                   style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: getProportionateScreenHeight(18)),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         SizedBox(width: getProportionateScreenWidth(10)),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: dummyData.map(_listTile).toList(),
            ),
          ),
          _isLoading
              ? Positioned(
                  child: Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _listTile(PostDataStructure data) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        data.userName,
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20)),
                      ),
                      Text(
                        readTimestamp(data.postTime),
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(20)),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(height: 4, color: Colors.black26),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                child: Text(
                  data.postContent,
                  style: TextStyle(fontSize: getProportionateScreenHeight(20)),
                ),
              ),
              Divider(height: 4, color: Colors.black26),
              // Beğen-Yorum
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Beğen
                    Row(
                      children: [
                        Icon(Icons.thumb_up_alt_outlined),
                        SizedBox(width: getProportionateScreenWidth(5)),
                        Text(
                          "Beğen (${data.postLikeCount})",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: getProportionateScreenHeight(18),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    // Yorum
                    Row(
                      children: [
                        Icon(Icons.comment_outlined),
                        SizedBox(width: getProportionateScreenWidth(5)),
                        Text(
                          "Yorum (${data.postCommentCount})",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: getProportionateScreenHeight(18),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomChoiceSheet() {
    return Container(
      height: getProportionateScreenHeight(100),
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenHeight(30),
          vertical: getProportionateScreenWidth(20)),
      child: Column(
        children: <Widget>[
          Text(
            'Ne hakkında paylaşmak istersiniz?',
            style: TextStyle(fontSize: getProportionateScreenWidth(17)),
          ),
          SizedBox(height: getProportionateScreenHeight(16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                onPressed: () {

                },
                icon: Icon(Icons.camera_alt),
                label: Text('Çay',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                    )),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                onPressed: () async {

                },
                icon: Icon(Icons.image),
                label: Text('Kür',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
