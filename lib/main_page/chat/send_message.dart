import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/const.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class SendMessageUser extends StatefulWidget {
  final String messageSender;
  final String messageTaker;

  SendMessageUser({required this.messageSender, required this.messageTaker});

  @override
  State<SendMessageUser> createState() => _SendMessageUserState();
}

class _SendMessageUserState extends State<SendMessageUser> {
  final TextEditingController _msgTextController = new TextEditingController();
  FocusNode _writingTextFocus = FocusNode();
  String? senderId ;
  String? takerId;
  String senderName='';
  String takerName='';

  @override
  void initState() {
    super.initState();
    senderId = widget.messageSender;
    takerId = widget.messageTaker;
  }

  String? getSender() {

    DocumentReference sender = FirebaseFirestore.instance
        .collection('users')
        .doc(senderId);

    sender.get().then((DocumentSnapshot ds) {
      senderName = ds['nickname'];
    });

    return senderName;
  }

  String? getTaker(){
    DocumentReference taker =
        FirebaseFirestore.instance.collection('users').doc(takerId);

    taker.get().then((DocumentSnapshot ds) {
      takerName= ds['nickname'];
    });

    return takerName;
  }


  // PROBLEM VAR
  // sayfa ilk açıldığı zaman  sendername ve takername işlemlerini yapmıyor sayfa yenilenince fonkion çalışıyor

  @override
  Widget build(BuildContext context) {
    List<String> userList = [widget.messageTaker, widget.messageSender];
    senderName=getSender()!;
    takerName=getTaker()!;
    print(senderName);
    print(takerName);
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
          'Mesaj Gönder',
          style: TextStyle(
              fontSize: getProportionateScreenHeight(25),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  senderName+takerName,
                  style: TextStyle(
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          _buildTextComposer(),
          SizedBox(height: getProportionateScreenHeight(10)),
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
                    //_handleSubmitted(_msgTextController.text);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmitted(String text) async {
    try {} catch (e) {
      print('Mesaj göndermede sprun oluştu. \n Lütfen sonra tekrar deneyiniz.');
    }
  }
}
