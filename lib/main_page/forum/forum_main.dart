import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/main_page/forum/share/share_detail.dart';
import 'package:fitterapi/main_page/forum/share/share_info.dart';
import 'package:fitterapi/main_page/forum/visit_user_profile.dart';
import 'package:fitterapi/main_page/prepared/idb_icons.dart';
import 'package:fitterapi/main_page/prepared/localTempDB.dart';
import 'package:fitterapi/main_page/prepared/utils.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/services/cloud_store.dart';
import 'package:flutter/material.dart';
import '../../const.dart';
import '../../size_config.dart';
import 'profil_data.dart';

class ForumMain extends StatefulWidget {
  final MyProfileData myData;
  final ValueChanged<MyProfileData> updateMyData;

  ForumMain({required this.myData, required this.updateMyData});

  @override
  _ForumMainState createState() => _ForumMainState();
}

class _ForumMainState extends State<ForumMain>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  bool _isSearching = false;

  // List _allResults = [];
  // List _resultsList = [];

  List<DocumentSnapshot> listOfDocumentSnapshot = [];

  late Future resultsLoaded;

 //isLikeList for
  final currentUser = FirebaseAuth.instance.currentUser;


  int defaultChoiceIndex = 0;
  late int newChoice;
  final List<String> choice = [
    'Hepsi',
    'Çaylar',
    'Kürler',
    'Sorular',
    'Bilgiler'
  ];
  final List<String> bottomChoice = ['Hepsi', 'Çay', 'Kür', 'Soru', 'Bilgi'];

  Stream? newStream;

  void resetStreamWithSearch(int index) {
    setState(() {
      if (_searchController.text != "") {
      } else {
        if (index == 0) {
          newStream = FirebaseFirestore.instance
              .collection('shares')
              .orderBy('shareTime', descending: true)
              .snapshots();
        } else if (index == 1) {
          newStream = FirebaseFirestore.instance
              .collection('shares')
              .where('about', isEqualTo: bottomChoice[index])
              .snapshots();
        } else if (index == 2) {
          newStream = FirebaseFirestore.instance
              .collection('shares')
              .where('about', isEqualTo: bottomChoice[index])
              .snapshots();
        } else if (index == 3) {
          newStream = FirebaseFirestore.instance
              .collection('shares')
              .where('about', isEqualTo: bottomChoice[index])
              .snapshots();
        } else if (index == 4) {
          newStream = FirebaseFirestore.instance
              .collection('shares')
              .where('about', isEqualTo: bottomChoice[index])
              .snapshots();
        }
      }
    });
  }

  UserData userData = UserData();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future getSharesSnapshot() async {
    newStream = FirebaseFirestore.instance
        .collection('shares')
        .orderBy('shareTime', descending: true)
        .snapshots();
    // setState(() {
    //   _allResults = data.docs;
    // });
    //searchResultsList();
  }

  _onSearchChanged() {
    //searchResultsList();
    resetStreamWithSearch(defaultChoiceIndex);
  }

  // searchResultsList() {
  //   var showResults = [];
  //
  //   if (_searchController.text != "") {
  //     for (var shareSnapshot in _allResults) {
  //       var title = Shares.fromSnapshot(shareSnapshot).shareTitle.toLowerCase();
  //       var title2 =
  //           Shares.fromSnapshot(shareSnapshot).shareContent.toLowerCase();
  //
  //       if (title.contains(_searchController.text.toLowerCase())) {
  //         showResults.add(shareSnapshot);
  //       } else if (title2.contains(_searchController.text.toLowerCase())) {
  //         showResults.add(shareSnapshot);
  //       }
  //     }
  //   } else {
  //     defaultChoiceIndex = 0;
  //     showResults = List.from(_allResults);
  //   }
  //   setState(() {
  //     _resultsList = showResults;
  //   });
  // }

  void _updateLikeCount(DocumentSnapshot document,bool isLikeShare) async {

    List<String>? newLikeList = await LocalTempDB.saveLikeList(
        document['shareId'], widget.myData.myLikeList,isLikeShare);
    MyProfileData myProfileData = MyProfileData(
        myName: widget.myData.myName,
        image: widget.myData.image,
        myLikeList: newLikeList);
    widget.updateMyData(myProfileData);
    await CloudStore.updateShareLikeCount(document,isLikeShare);
    await CloudStore.likeToShare(
        document['shareId'],
        widget.myData,
        isLikeShare
    );
  }


  void _moveToShareDetail(DocumentSnapshot document) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ShareDetail(
                document: document,
                myData: widget.myData,
                updateMyData: widget.updateMyData,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // burada çağrılmazsa eğer dosyalar gelmiyor
    resetStreamWithSearch(defaultChoiceIndex);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: getProportionateScreenHeight(95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        backgroundColor: kPrimaryColor,
        title: !_isSearching
            ? Text(
                'Paylaşımlar',
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.bold),
              )
            : TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Sen sor biz arayalım',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
        actions: <Widget>[
          //search
          _isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      defaultChoiceIndex = 0;
                      this._isSearching = false;
                      _searchController.clear();
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      defaultChoiceIndex = 0;
                      resetStreamWithSearch(defaultChoiceIndex);
                      this._isSearching = true;
                    });
                  },
                ),
          // Paylaş (Çay-Kür-Soru-Bilgi)
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 25, 10),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  builder: ((builder) => bottomChoiceSheet()),
                  context: context,
                );
              },
              icon: Icon(
                Icons.add_box_outlined,
                color: Colors.white,
                size: getProportionateScreenHeight(30),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            Wrap(
              spacing: 5,
              children: List.generate(choice.length, (index) {
                newChoice = index;
                return ChoiceChip(
                  labelPadding: EdgeInsets.all(2.0),
                  label: Text(
                    choice[index],
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white, fontSize: 14),
                  ),
                  selected: defaultChoiceIndex == index,
                  selectedColor: kPrimaryColor,
                  onSelected: (value) {
                    setState(() {
                      defaultChoiceIndex = value ? index : defaultChoiceIndex;
                    });
                    //resetStreamWithSearch(index);
                    // choiceListIndex(index);
                  },
                  // backgroundColor: color,
                  elevation: 1,
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenHeight(14)),
                );
              }),
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            // MAIN PART
            Expanded(
              child: RefreshIndicator(
                color: kPrimaryColor,
                onRefresh: () async {
                  await getSharesSnapshot();
                },
                child: StreamBuilder<dynamic>(
                    //----burada dynaöic sonradan ekelendi
                    // stream: FirebaseFirestore.instance
                    //     .collection('shares')
                    //     .orderBy('shareTime', descending: true)
                    //     .snapshots(),
                    // stream: posts.orderBy('shareTime', descending: true).snapshots(),
                    stream: newStream,
                    builder: (context, snapshot) {
                      // List<QueryDocumentSnapshot> listOfDocumentSnapshot = (snapshot.data as QuerySnapshot).docs;
                      if (!snapshot.hasData) {
                        return Container(
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
                                  'Paylaşım Yok',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[700]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )),
                        );
                      }
                      // listofdocumentsnpahot yukarıda olunca null ceheck error oluşuyor
                      listOfDocumentSnapshot = snapshot.data!.docs;

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: listOfDocumentSnapshot.length,
                          itemBuilder: (context, index) {
                            String icon = (listOfDocumentSnapshot[index].data()
                                    as Map)['about'] ??
                                ' ';
                            return Card(
                              elevation: 2.0,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                //kür-soru... icon
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                  child: Icon(
                                                    icon == 'Çay'
                                                        ? DBIcons.tea
                                                        : icon == 'Kür'
                                                            ? DBIcons.mortar
                                                            : icon == 'Soru'
                                                                ? Icons
                                                                    .announcement_rounded
                                                                : Icons
                                                                    .insert_drive_file,
                                                    size:
                                                        getProportionateScreenHeight(
                                                            32),
                                                    color: kPrimaryColor,
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    //  kullanıcı ismine tıklandığında kullanıcının profil sayfasını götürecek
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => VisitUserProfile(user:  (listOfDocumentSnapshot[
                                                              index]
                                                                  .data()
                                                              as Map)[
                                                              'userId'] ??
                                                                  ' ')),
                                                        );

                                                      },
                                                      child: Text(
                                                        (listOfDocumentSnapshot[
                                                                            index]
                                                                        .data()
                                                                    as Map)[
                                                                'userName'] ??
                                                            ' ',
                                                        style: TextStyle(
                                                          decoration: TextDecoration.underline,
                                                          fontSize:
                                                              getProportionateScreenHeight(
                                                                  20),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            getProportionateScreenHeight(
                                                                2)),
                                                    Text(
                                                      Utils().readTimestamp(
                                                          (listOfDocumentSnapshot[index]
                                                                          .data()
                                                                      as Map)[
                                                                  'shareTime'] ??
                                                              ' '),
                                                      style: TextStyle(
                                                          fontSize:
                                                              getProportionateScreenHeight(
                                                                  15)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // paylaşımın başlığı
                                        SizedBox(
                                          height:
                                              getProportionateScreenHeight(5),
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    7, 4, 10, 2),
                                                child: Text(
                                                  (listOfDocumentSnapshot[
                                                                  index]
                                                              .data() as Map)[
                                                          'shareTitle'] ??
                                                      ' ',
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              22),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            height: 4, color: Colors.black26),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              4, 10, 4, 10),
                                          child: Text(
                                            (listOfDocumentSnapshot[index]
                                                        .data()
                                                    as Map)['shareContent'] ??
                                                ' ',
                                            style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        20)),
                                          ),
                                        ),
                                        Divider(
                                            height: 4, color: Colors.black26),
                                      ],
                                    ),
                                    // Beğen-Yorum
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Beğen
                                          GestureDetector(
                                            onTap: () {
                                              _updateLikeCount(listOfDocumentSnapshot[index],widget.myData
                                                  .myLikeList !=
                                                  null &&
                                                  widget.myData
                                                      .myLikeList!
                                                      .contains(listOfDocumentSnapshot[
                                                  index]
                                                  [
                                                  'shareId'])
                                                  ? true : false);
                                              print('tıklandı');
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .thumb_up_alt_outlined,
                                                      color: widget.myData
                                                                      .myLikeList !=
                                                                  null &&
                                                              widget.myData
                                                                  .myLikeList!
                                                                  .contains(listOfDocumentSnapshot[
                                                                          index]
                                                                      [
                                                                      'shareId'])
                                                          ? Colors.red
                                                          : Colors.black),
                                                  SizedBox(
                                                      width:
                                                          getProportionateScreenWidth(
                                                              5)),

                                                  // farklı renklerde metinler yazabilmek için
                                                  RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                      TextSpan(
                                                          text: 'Beğen ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    18),
                                                          )),
                                                      TextSpan(
                                                          text:
                                                              '(${(listOfDocumentSnapshot[index].data() as Map)['shareLikeCount'] ?? ' '})',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    18),
                                                          )),
                                                    ]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Yorum
                                          GestureDetector(
                                            onTap: () => _moveToShareDetail(
                                                listOfDocumentSnapshot[index]),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.comment_outlined),
                                                  SizedBox(
                                                      width:
                                                          getProportionateScreenWidth(
                                                              5)),
                                                  RichText(
                                                    text: TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: 'Yorum ',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontSize:
                                                                    getProportionateScreenHeight(
                                                                        18),
                                                              )),
                                                          TextSpan(
                                                              text:
                                                                  '(${(listOfDocumentSnapshot[index].data() as Map)['shareCommentCount'] ?? ' '})',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontSize:
                                                                    getProportionateScreenHeight(
                                                                        18),
                                                              )),
                                                        ]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }),
              ),
            ),

            // _resultsList.length > 0
            //     ? Expanded(
            //         //refresh firebase data- when add new one, cant load quickly
            //         child: RefreshIndicator(
            //           color: kPrimaryColor,
            //           onRefresh: () async {
            //             await getSharesSnapshot();
            //           },
            //           child: ListView.builder(
            //             itemCount: _resultsList.length,
            //             shrinkWrap: true,
            //             itemBuilder: (BuildContext context, int index) =>
            //                 listShare(context, _resultsList[index]),
            //           ),
            //         ),
            //       )
            //     // eğer veri yoksa paylaşım yok uyarısı
            //     : Container(
            //         child: Center(
            //             child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: <Widget>[
            //             Icon(
            //               Icons.error,
            //               color: Colors.grey[700],
            //               size: 64,
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.all(14.0),
            //               child: Text(
            //                 'Paylaşım Yok',
            //                 style: TextStyle(
            //                     fontSize: 16, color: Colors.grey[700]),
            //                 textAlign: TextAlign.center,
            //               ),
            //             ),
            //           ],
            //         )),
            //       ),
            _isLoading
                ? Positioned(
                    child: Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : Container(),
          ],
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShareInfo(choice: 'Çay')),
                  );
                },
                icon: Icon(DBIcons.tea, color: Colors.black54),
                label: Text('Çay',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                    )),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShareInfo(choice: 'Kür')),
                  );
                },
                icon: Icon(DBIcons.mortar, color: Colors.black54),
                label: Text('Kür',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                    )),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShareInfo(choice: 'Soru')),
                  );
                },
                icon: Icon(Icons.announcement_rounded, color: Colors.black54),
                label: Text('Soru',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                    )),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShareInfo(choice: 'Bilgi')),
                  );
                },
                icon: Icon(Icons.insert_drive_file, color: Colors.black54),
                label: Text('Bilgi',
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

// Widget listShare(BuildContext context, DocumentSnapshot document) {
//   final share = Shares.fromSnapshot(document);
//   return Padding(
//     padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
//     child: Card(
//       elevation: 2.0,
//       child: Padding(
//         padding: EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             GestureDetector(
//               onTap: () => _moveToShareDetail(document),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Row(
//                         children: [
//                           // kür-soru... icon
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Icon(
//                               share.about == 'Çay'
//                                   ? DBIcons.tea
//                                   : share.about == 'Kür'
//                                   ? DBIcons.mortar
//                                   : share.about == 'Soru'
//                                   ? Icons.announcement_rounded
//                                   : Icons.insert_drive_file,
//                               size: getProportionateScreenHeight(32),
//                               color: kPrimaryColor,
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               //  kullanıcı ismine tıklandığında kullanıcının profil sayfasını götürecek
//                               GestureDetector(
//                                 onTap: () {},
//                                 child: Text(
//                                   share.userName,
//                                   style: TextStyle(
//                                     fontSize:
//                                     getProportionateScreenHeight(20),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                   height: getProportionateScreenHeight(2)),
//                               Text(
//                                 Utils().readTimestamp(share.shareTime),
//                                 style: TextStyle(
//                                     fontSize:
//                                     getProportionateScreenHeight(15)),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   // paylaşımın başlığı
//                   SizedBox(
//                     height: getProportionateScreenHeight(5),
//                   ),
//                   Row(
//                     children: [
//                       Flexible(
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(7, 4, 10, 2),
//                           child: Text(
//                             share.shareTitle,
//                             style: TextStyle(
//                                 fontSize: getProportionateScreenHeight(22),
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Divider(height: 4, color: Colors.black26),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
//                     child: Text(
//                       share.shareContent,
//                       style: TextStyle(
//                           fontSize: getProportionateScreenHeight(20)),
//                     ),
//                   ),
//                   Divider(height: 4, color: Colors.black26),
//                 ],
//               ),
//             ),
//             // Beğen-Yorum
//             Padding(
//               padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   // Beğen
//                   GestureDetector(
//                     onTap: () {
//                       _updateLikeCount(document);
//                       print('tıklandı');
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Row(
//                         children: [
//                           Icon(Icons.thumb_up_alt_outlined),
//                           SizedBox(width: getProportionateScreenWidth(5)),
//
//                           // farklı renklerde metinler yazabilmek için
//                           RichText(
//                             text: TextSpan(children: <TextSpan>[
//                               TextSpan(
//                                   text: 'Beğen ',
//                                   style: TextStyle(
//                                     color: kPrimaryColor,
//                                     fontSize:
//                                     getProportionateScreenHeight(18),
//                                   )),
//                               TextSpan(
//                                   text: '(${share.shareLikeCount})',
//                                   style: TextStyle(
//                                     color: Colors.black,
//                                     fontSize:
//                                     getProportionateScreenHeight(18),
//                                   )),
//                             ]),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Yorum
//                   Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Row(
//                       children: [
//                         Icon(Icons.comment_outlined),
//                         SizedBox(width: getProportionateScreenWidth(5)),
//                         RichText(
//                           text: TextSpan(children: <TextSpan>[
//                             TextSpan(
//                                 text: 'Yorum ',
//                                 style: TextStyle(
//                                   color: kPrimaryColor,
//                                   fontSize: getProportionateScreenHeight(18),
//                                 )),
//                             TextSpan(
//                                 text: '(${share.shareCommentCount})',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: getProportionateScreenHeight(18),
//                                 )),
//                           ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
