import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/main_page/forum/share/shares.dart';
import 'package:fitterapi/main_page/prepared/utils.dart';
import 'package:flutter/material.dart';

import '../../../const.dart';
import '../../../size_config.dart';

class ShareDetail extends StatefulWidget {
  DocumentSnapshot document;

  ShareDetail({required this.document});

  @override
  _ShareDetailState createState() => _ShareDetailState();
}

class _ShareDetailState extends State<ShareDetail> {
  late DocumentSnapshot data;
  late Shares share = Shares.fromSnapshot(widget.document);

  final TextEditingController _msgTextController = new TextEditingController();
  FocusNode _writingTextFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
              child: Column(
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
                              Column(
                                children: [
                                  Text(
                                    share.userName,
                                    style: TextStyle(
                                        fontSize: getProportionateScreenHeight(20)),
                                  ),
                                  Text(
                                    Utils().readTimestamp(share.shareTime),
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
                              share.shareContent,
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(20)),
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
                                      "Beğen (${share.shareLikeCount})",
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
                                      "Yorum (${share.shareCommentCount})",
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
                ],
              ),
            ),
          ),
          _buildTextComposer(),
        ],
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
              child:Card(
                color: Colors.white,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      getProportionateScreenHeight(12)),
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
              child:
                  IconButton(icon: Icon(Icons.send), onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmitted(String text) async {
    try {

    } catch (e) {
      print('Yorum göndermede sorun oldu');
    }
  }
}
