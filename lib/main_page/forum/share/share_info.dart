import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/main_page/prepared/idb_icons.dart';
import 'package:fitterapi/main_page/prepared/utils.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/services/auth.dart';
import 'package:fitterapi/services/user_database.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';

// ignore: must_be_immutable
class ShareInfo extends StatefulWidget {
  String choice;

  ShareInfo({Key? key, required this.choice}) : super(key: key);

  @override
  State<ShareInfo> createState() => _ShareInfoState();
}

class _ShareInfoState extends State<ShareInfo> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final AuthService auth = AuthService();

  UserData userData = UserData();

  String? content;
  String? title;
  String? id;
  String? user;
  String? image;

  bool _isLoading = false;

  // daha sonra resim eklemeyi ekleyebilirim
  // static Future<String?> uploadPostImages({required String postID,required File postImageFile}) async {
  //   try {
  //     String fileName = 'images/$postID/postImage';
  //     String? postImageURL;
  //     Reference reference = FirebaseStorage.instance.ref().child(fileName);
  //     UploadTask uploadTask = reference.putFile(postImageFile);
  //     uploadTask.whenComplete(() {
  //       postImageURL = reference.getDownloadURL() as String;
  //     });
  //     return postImageURL;
  //   }catch(e) {
  //     return null;
  //   }
  // }

  Future<void> _sendShareInFirebase(String shContent, String id,String title,String user,String image) async {
    setState(() {
      _isLoading = true;
    });
    String shareId= Utils().generateRandomString(20);
    FirebaseFirestore.instance.collection('shares').doc(shareId).set({
      'userName': user,
      'userId': id,
      'userImage':image,
      'shareTime': DateTime.now().millisecondsSinceEpoch,
      'shareContent': shContent,
      'shareLikeCount': 0,
      'shareCommentCount': 0,
      'about': widget.choice,
      'shareTitle':title,
      'shareId':shareId
    });
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    UserDatabase userDatabase = UserDatabase(uid: currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "${widget.choice} Payla??",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {
              _sendShareInFirebase(content!, id!,title!,user!,image!);
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Bitti',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenHeight(19)),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<UserData>(
        stream: userDatabase.userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? _userData = snapshot.data;
            String? _nickname =_userData!.nickname;
            image=_userData.image;
            user=_nickname;
            id = _userData.uid;
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Card(
                      color: Colors.white,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenHeight(12)),
                      ),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // ??ay-k??r-icon-bilgi icon
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      widget.choice == '??ay'
                                          ? DBIcons.tea
                                          : widget.choice == 'K??r'
                                              ? DBIcons.mortar
                                              : widget.choice == 'Soru'
                                                  ? Icons.announcement_rounded
                                                  : Icons.insert_drive_file,
                                      size: getProportionateScreenHeight(32),
                                    ),
                                  ),
                                  // payla????m yapan ki??i
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      user!,
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(22),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(height: 2, color: Colors.black26),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // payla????m??n ba??l??????

                    Padding(
                      padding: EdgeInsets.only(top: 12,left: 12,bottom: 5),
                      child: Text('Payla??mak istedi??iniz i??eri??in ba??l??????n?? yaz??n??z',style: TextStyle(color: Colors.black26,fontSize: getProportionateScreenHeight(15),fontWeight: FontWeight.bold),),
                    ),

                    Card(
                      color: Colors.white,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenHeight(12)),
                      ),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            onSaved: (newValue) => title = newValue,
                            onChanged: (value) {
                              setState(() => title = value);
                              return null;
                            },
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Ba??l??????n??z ...',
                              hintMaxLines: 4,
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                        ),
                      ),
                    ),

                    // payla????m??n i??eri??i

                    Padding(
                      padding: EdgeInsets.only(top: 12,left: 12,bottom: 5),
                      child: Text('Payla??mak istedi??iniz i??eri??inizi yaz??n??z.',style: TextStyle(color: Colors.black26,fontSize: getProportionateScreenHeight(15),fontWeight: FontWeight.bold),),
                    ),

                    Card(
                      color: Colors.white,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            getProportionateScreenHeight(12)),
                      ),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            onSaved: (newValue) => content = newValue,
                            onChanged: (value) {
                              setState(() => content = value);
                              return null;
                            },
                            autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '????erik ...',
                              hintMaxLines: 4,
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                _isLoading
                    ? Positioned(
                        child: Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                          color: Colors.white.withOpacity(0.7),
                        ),
                      )
                    : Container(),
              ],
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
