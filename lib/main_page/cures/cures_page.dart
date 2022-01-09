import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/cures/cures.dart';
import 'package:fitterapi/main_page/prepared/idb_icons.dart';
import 'package:fitterapi/main_page/prepared/pricer_cliper.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CuresPage extends StatefulWidget {
  @override
  State<CuresPage> createState() => _CuresPageState();
}

class _CuresPageState extends State<CuresPage> {
  TextEditingController _searchController = TextEditingController();

  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

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
    resultsLoaded = getCourseSnapshot();
  }

  getCourseSnapshot() async {
    var data = await FirebaseFirestore.instance
        .collection('cures')
        .orderBy('curesName')
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
      for (var cureSnapshot in _allResults) {
        var title = Cures.fromSnapshot(cureSnapshot).curesName!.toLowerCase();
        var title2 = Cures.fromSnapshot(cureSnapshot).about!.toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(cureSnapshot);
        }
        else if (title2.contains(_searchController.text.toLowerCase())) {
          showResults.add(cureSnapshot);
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
      body: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: <Widget>[
            //Search(),
            //Search bar
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenWidth(20),
                  horizontal: getProportionateScreenHeight(20)),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenWidth(10),
                    horizontal: getProportionateScreenHeight(30)),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: getProportionateScreenWidth(250),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "Sen sor biz arayalım",
                          hintStyle: TextStyle(color: Colors.black38),
                          prefixIcon: Icon(
                            Icons.search_sharp,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenHeight(5),
                            vertical: getProportionateScreenWidth(15),
                          ),
                        ),
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    SizedBox(width: getProportionateScreenWidth(10)),
                  ],
                ),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Flexible(
              child: ListView.builder(
                itemCount: _resultsList.length,
                itemBuilder: (BuildContext context, int index) =>
                    listCure(context, _resultsList[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listCure(BuildContext context, DocumentSnapshot document) {
    final cure = Cures.fromSnapshot(document);
    return SizedBox(
        height: getProportionateScreenHeight(200),
        width: getProportionateScreenWidth(50),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => detailCures(context, document)),
            );
          },
          title: ClipRRect(
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(8)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenHeight(40)),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 3,
                      color: kPrimaryColor.withOpacity(0.6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.all(getProportionateScreenHeight(10)),
                        child: Column(
                          children: [
                            SizedBox(height: getProportionateScreenHeight(30)),
                            Text(
                              cure.curesName!,
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(20),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: getProportionateScreenHeight(20)),
                            Text(
                              cure.about!,
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(
                        cure.image!,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(width: getProportionateScreenWidth(25)),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget detailCures(BuildContext context, DocumentSnapshot document) {
    final cures = Cures.fromSnapshot(document);

    Future addtoFavorites() async {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      var currentUser = _auth.currentUser;
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('users-favorites');
      return _collectionRef
          .doc(currentUser!.email)
          .collection("cures")
          .doc()
          .set({
        "curesName": cures.curesName,
        "about": cures.about,
        "image": cures.image,
        "recipe": cures.recipe,
      }).then((value) => print("Added to favourite"));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          cures.curesName!,
          style: TextStyle(
            color: Colors.black26,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      // image
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: getProportionateScreenWidth(10)),
                          Container(
                            height: getProportionateScreenHeight(200),
                            width: getProportionateScreenWidth(180),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 4),
                                  blurRadius: 20,
                                  color: Colors.black38.withOpacity(0.7),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(
                                top: getProportionateScreenHeight(30)),
                            child: Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: getProportionateScreenWidth(100),
                                  backgroundImage: NetworkImage(
                                    cures.image!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      // information
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  getProportionateScreenHeight(40)),
                              topRight: Radius.circular(
                                  getProportionateScreenHeight(40)),
                            ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 7),
                                blurRadius: 20,
                                color: Colors.black38.withOpacity(0.7),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(20)),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: getProportionateScreenWidth(8),
                                    right: getProportionateScreenWidth(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cures.curesName!,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        18),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        8)),
                                            //reting bar
                                            RatingBar.builder(
                                              initialRating: 3,
                                              itemSize:
                                                  getProportionateScreenHeight(
                                                      28),
                                              itemCount: 5,
                                              itemBuilder: (context, index) {
                                                switch (index) {
                                                  case 0:
                                                    return Icon(
                                                      DBIcons.mortar,
                                                      color: Colors.red,
                                                    );
                                                  case 1:
                                                    return Icon(
                                                      DBIcons.mortar,
                                                      color: Colors
                                                          .deepOrangeAccent,
                                                    );
                                                  case 2:
                                                    return Icon(
                                                      DBIcons.mortar,
                                                      color: Colors.amberAccent,
                                                    );
                                                  case 3:
                                                    return Icon(
                                                      DBIcons.mortar,
                                                      color: Colors.lightGreen,
                                                    );
                                                  case 4:
                                                    return Icon(
                                                      DBIcons.mortar,
                                                      color: kPrimaryColor,
                                                    );
                                                  default:
                                                    return Icon(
                                                      DBIcons.mortar,
                                                      color: Colors.red,
                                                    );
                                                }
                                              },
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      // LikeButtonWidget(),
                                      // favorite button
                                      ClipPath(
                                        clipper: PricerCliper(),
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          padding: EdgeInsets.only(
                                            right: getProportionateScreenHeight(
                                                14),
                                          ),
                                          height:
                                              getProportionateScreenHeight(70),
                                          width:
                                              getProportionateScreenWidth(80),
                                          color: kPrimaryColor,
                                          // child: LikeButtonWidget(),
                                          child: StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('users-favorites')
                                                .doc(FirebaseAuth.instance
                                                    .currentUser!.email)
                                                .collection('cures')
                                                .where('curesName',
                                                    isEqualTo: cures.curesName)
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.data == null) {
                                                return Text(' ');
                                              }
                                              return IconButton(
                                                onPressed: () => snapshot
                                                            .data.docs.length ==
                                                        0
                                                    ? addtoFavorites()
                                                    : print('Already added'),
                                                icon: snapshot
                                                            .data.docs.length ==
                                                        0
                                                    ? Icon(
                                                        Icons
                                                            .star_border_outlined,
                                                        size:
                                                            getProportionateScreenHeight(
                                                                50))
                                                    : Icon(
                                                        Icons.star,
                                                        size:
                                                            getProportionateScreenHeight(
                                                                50),
                                                        color: Colors.red),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${cures.about} için faydalı',
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    17),
                                            fontFamily: 'muli',
                                            color: kPrimaryColor),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(15)),
                                      Text(
                                        cures.recipe!,
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(15),
                                          fontFamily: 'muli',
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

//  BEFORE

//
// class CuresPage extends StatefulWidget {
//   @override
//   State<CuresPage> createState() => _CuresPageState();
// }
//
// class _CuresPageState extends State<CuresPage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<List<Cures>>.value(
//       value: CuresDatabase().curesData,
//       initialData: [],
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Padding(
//           padding: EdgeInsets.only(bottom: 10),
//           child: Column(
//             children: <Widget>[
//               Search(),
//               // SizedBox(
//               //   height: getProportionateScreenHeight(50),
//               //   child: Card(
//               //     color: kPrimaryColor,
//               //     child: IconButton(
//               //       onPressed: () {
//               //         Get.to(() => NewCureScreen());
//               //       },
//               //       icon: const Icon(Icons.add),
//               //     ),
//               //   ),
//               // ),
//               CuresList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
