import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/main_page/forum/share/share_detail.dart';
import 'package:fitterapi/main_page/forum/share/share_info.dart';
import 'package:fitterapi/main_page/forum/share/shares.dart';
import 'package:fitterapi/main_page/prepared/idb_icons.dart';
import 'package:fitterapi/main_page/prepared/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const.dart';
import '../../size_config.dart';

class ForumMain extends StatefulWidget {
  @override
  _ForumMainState createState() => _ForumMainState();
}

class _ForumMainState extends State<ForumMain>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  bool _isSearching = false;

  List _allResults = [];
  List _resultsList = [];
  late Future resultsLoaded;

  late TabController _controller;
  late int defaultChoiceIndex;
  final List<String> choice = [
    'Hepsi',
    'Çaylar',
    'Kürler',
    'Sorular',
    'Bilgiler'
  ];
  final List<String> bottomChoice = [
    'Hepsi',
    'Çay',
    'Kür',
    'Soru',
    'Bilgi'
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    defaultChoiceIndex = 0;
    _controller = new TabController(length: choice.length, vsync: this);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   // _takeUserDataFromFB();
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getSharesSnapshot();
  }

  // Future<void> _takeUserDataFromFB() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  // }

  getSharesSnapshot() async {
    var data = await FirebaseFirestore.instance
        .collection('shares')
        // descending:true  son eklenenden ilklere doğru sıralama yapıyor
        .orderBy('shareTime', descending: true)
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return 'complete';
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var shareSnapshot in _allResults) {
        var title = Shares.fromSnapshot(shareSnapshot).shareTitle.toLowerCase();
        var title2 =
            Shares.fromSnapshot(shareSnapshot).shareContent.toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(shareSnapshot);
        } else if (title2.contains(_searchController.text.toLowerCase())) {
          showResults.add(shareSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      this._isSearching = false;
                      _searchController.clear();
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    setState(() {
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
              spacing: 8,
              children: List.generate(choice.length, (index) {
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
                    choiceListIndex(index);
                  },
                  // backgroundColor: color,
                  elevation: 1,
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenHeight(14)),
                );
              }),
            ),

            // DefaultTabController(
            //   length: choice.length,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       decoration: BoxDecoration(
            //           color: Colors.white.withOpacity(0.2),
            //           border: Border(
            //               bottom: BorderSide(color: Colors.black, width: 0.8))),
            //       child: TabBar(
            //         controller: _controller,
            //         unselectedLabelColor: kPrimaryColor,
            //         indicatorSize: TabBarIndicatorSize.tab,
            //         labelColor: kPrimaryColor,
            //         isScrollable: true,
            //         indicator: BoxDecoration(
            //           gradient: LinearGradient(
            //               colors: [Colors.black12, Colors.white12],
            //               begin: Alignment.center),
            //           borderRadius: BorderRadius.circular(10),
            //           // boxShadow: [
            //           //   BoxShadow(
            //           //     offset: Offset(0, 4),
            //           //     blurRadius: 10,
            //           //     color: Colors.black38.withOpacity(0.6),
            //           //   ),
            //           // ],
            //           color: Colors.white70,
            //           //border: Border.all(color: kPrimaryColor,width: 170)
            //         ),
            //         tabs: [
            //           Tab(
            //             child: Align(
            //               alignment: Alignment.center,
            //               child: Text(choice[0]),
            //             ),
            //           ),
            //           Tab(
            //             child: Align(
            //               alignment: Alignment.center,
            //               child: Text(choice[1]),
            //             ),
            //           ),
            //           Tab(
            //             child: Align(
            //               alignment: Alignment.center,
            //               child: Text(choice[2]),
            //             ),
            //           ),
            //           Tab(
            //             child: Align(
            //               alignment: Alignment.center,
            //               child: Text(choice[3]),
            //             ),
            //           ),
            //           Tab(
            //             child: Align(
            //               alignment: Alignment.center,
            //               child: Text(choice[4]),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // // tab controller nereyi gösterecek
            // Expanded(
            //   child: TabBarView(
            //     controller: _controller,
            //     children: [
            //       listChoiceAll(),
            //       listChoiceTeas(),
            //       listChoiceCures(),
            //       listChoiceAll(),
            //       listChoiceAll(),
            //     ],
            //   ),
            // ),

            SizedBox(height: getProportionateScreenHeight(10)),
            _resultsList.length > 0
                ? Expanded(
                 //refresh firebase data- when add new one, cant load quickly
                  child: RefreshIndicator(
                    color: kPrimaryColor,
                    onRefresh: () async {
                      await getSharesSnapshot();
                    },
                    child: ListView.builder(
                      itemCount: _resultsList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          listShare(context, _resultsList[index]),
                    ),
                  ),
                )
                // eğer veri yoksa paylaşım yok uyarısı
                : Container(
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
                  ),
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
  choiceListIndex(int index) {
    var result = [];
    if (index == 0) {
      result = _allResults;
    } else if (index == 1) {

      for (var shareSnapshot in _allResults) {
        var title = Shares.fromSnapshot(shareSnapshot).about.toLowerCase();

        if (title.contains(bottomChoice[index].toLowerCase())) {
          result.add(shareSnapshot);
        }
      }
    } else if (index == 2) {
      for (var shareSnapshot in _allResults) {
        var title = Shares.fromSnapshot(shareSnapshot).about.toLowerCase();

        if (title.contains(bottomChoice[index].toLowerCase())) {
          result.add(shareSnapshot);
        }
      }
    }
    setState(() {
      _resultsList = result;
    });
  }

  // choiceList(String choice) {
  //   var result = [];
  //   if (choice == "Hepsi") {
  //     result = _allResults;
  //   } else if (choice == 'Çay') {
  //     for (var shareSnapshot in _allResults) {
  //       var title = Shares.fromSnapshot(shareSnapshot).about.toLowerCase();
  //
  //       if (title.contains(choice.toLowerCase())) {
  //         result.add(shareSnapshot);
  //       }
  //     }
  //   } else if (choice == 'Kür') {
  //     for (var shareSnapshot in _allResults) {
  //       var title = Shares.fromSnapshot(shareSnapshot).about.toLowerCase();
  //
  //       if (title.contains(choice.toLowerCase())) {
  //         result.add(shareSnapshot);
  //       }
  //     }
  //   } else if (choice == 'Soru') {
  //     for (var shareSnapshot in _allResults) {
  //       var title = Shares.fromSnapshot(shareSnapshot).about.toLowerCase();
  //
  //       if (title.contains(choice.toLowerCase())) {
  //         result.add(shareSnapshot);
  //       }
  //     }
  //   } else if (choice == 'Bilgi') {
  //     for (var shareSnapshot in _allResults) {
  //       var title = Shares.fromSnapshot(shareSnapshot).about.toLowerCase();
  //       if (title.contains(choice.toLowerCase())) {
  //         result.add(shareSnapshot);
  //       }
  //     }
  //   }
  //   setState(() {
  //     _resultsList = result;
  //   });
  // }



  Widget listChoiceAll() {
    // choiceList('Hepsi');
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          _resultsList.length > 0
              ? Expanded(
                  //refresh firebase data- when add new one, cant load quickly
                  child: RefreshIndicator(
                    color: kPrimaryColor,
                    onRefresh: () async {
                      await getSharesSnapshot();
                    },
                    child: ListView.builder(
                      itemCount: _resultsList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          listShare(context, _resultsList[index]),
                    ),
                  ),
                )
              // eğer veri yoksa paylaşım yok uyarısı
              : Container(
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
                    ),
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
              : Container(),
        ],
      ),
    );
  }

  Widget listChoiceTeas() {
    // choiceList('Çay');
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          _resultsList.length > 0
              ? Expanded(
                  //refresh firebase data- when add new one, cant load quickly
                  child: RefreshIndicator(
                    color: kPrimaryColor,
                    onRefresh: () async {
                      await getSharesSnapshot();
                    },
                    child: ListView.builder(
                      itemCount: _resultsList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          listShare(context, _resultsList[index]),
                    ),
                  ),
                )
              // eğer veri yoksa paylaşım yok uyarısı
              : Container(
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
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
                ),
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
    );
  }

  Widget listChoiceCures() {
    // choiceList('Kür');
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          _resultsList.length > 0
              ? Expanded(
                  //refresh firebase data- when add new one, cant load quickly
                  child: RefreshIndicator(
                    color: kPrimaryColor,
                    onRefresh: () async {
                      await getSharesSnapshot();
                    },
                    child: ListView.builder(
                      itemCount: _resultsList.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) =>
                          listShare(context, _resultsList[index]),
                    ),
                  ),
                )
              // eğer veri yoksa paylaşım yok uyarısı
              : Container(
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
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
                ),
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
    );
  }





  void _moveToShareDetail(DocumentSnapshot document) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ShareDetail(
                document: document,
              )),
    );
  }

  Widget listShare(BuildContext context, DocumentSnapshot document) {
    final share = Shares.fromSnapshot(document);
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 10, 8, 10),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => _moveToShareDetail(document),
                child: Row(
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
              ),
              Divider(height: 4, color: Colors.black26),
              GestureDetector(
                onTap: () => _moveToShareDetail(document),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                  child: Text(
                    share.shareContent,
                    style:
                        TextStyle(fontSize: getProportionateScreenHeight(20)),
                  ),
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
                    GestureDetector(
                      onTap: () => _moveToShareDetail(document),
                      child: Row(
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
}
