import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/prepared/idb_icons.dart';
import 'package:fitterapi/main_page/prepared/like_button.dart';
import 'package:fitterapi/services/cures_database.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class CuresList extends StatefulWidget {
  @override
  _CuresListState createState() => _CuresListState();
}

class _CuresListState extends State<CuresList> {
  CuresDatabase curesDatabase = CuresDatabase();
  bool toggle = false;


  navigateToDetail(List<DocumentSnapshot> cure, int index) {
    Get.to(() => cureDetail(cure, index));
    //CureDetailScreen(cure: cure,index: index,));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: curesDatabase.getCureList(),
      builder: (context, snapshot) {
        List<DocumentSnapshot> listOfDocumentSnapshot = snapshot.data!.docs;
        return Flexible(
          child: ListView.builder(
              itemCount: listOfDocumentSnapshot.length,
              itemBuilder: (context, index) {
                return SizedBox(
                    height: getProportionateScreenHeight(200),
                    width: getProportionateScreenWidth(50),
                    child: ListTile(
                      onTap: () =>
                          navigateToDetail(listOfDocumentSnapshot, index),
                      title: ClipRRect(
                        child: Padding(
                          padding:
                              EdgeInsets.all(getProportionateScreenHeight(8)),
                          child: Container(
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(
                                  getProportionateScreenHeight(50)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        getProportionateScreenHeight(10)),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    30)),
                                        Text(
                                          (listOfDocumentSnapshot[index].data()
                                                  as Map)['curesName'] ??
                                              ' ',
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    20),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    20)),
                                        Text(
                                          (listOfDocumentSnapshot[index].data()
                                                  as Map)['about'] ??
                                              ' ',
                                          style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    16),
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
                                    (listOfDocumentSnapshot[index].data()
                                            as Map)['image'] ??
                                        ' ',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                    width: getProportionateScreenWidth(20)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
              }),
        );
      },
    );
  }

  Scaffold cureDetail(List<DocumentSnapshot> cure, int index) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          (cure[index].data() as Map)['curesName'] ?? ' ',
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
      body: Container(
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
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 20,
                        color: Colors.black38.withOpacity(0.7),
                      ),
                    ],
                  ),
                  margin:
                      EdgeInsets.only(top: getProportionateScreenHeight(30)),
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: getProportionateScreenWidth(100),
                        backgroundImage: NetworkImage(
                          (cure[index].data() as Map)['image'] ?? ' ',
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
                    topLeft: Radius.circular(getProportionateScreenHeight(40)),
                    topRight: Radius.circular(getProportionateScreenHeight(40)),
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
                    SizedBox(height: getProportionateScreenHeight(20)),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (cure[index].data() as Map)['curesName'] ??
                                        ' ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          getProportionateScreenHeight(18),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(8)),
                                  //reting bar
                                  RatingBar.builder(
                                    initialRating: 3,
                                    itemSize: getProportionateScreenHeight(28),
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
                                            color: Colors.deepOrangeAccent,
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenHeight(2),
                                    vertical: getProportionateScreenHeight(5)),

                                height: getProportionateScreenHeight(60),
                                width: getProportionateScreenWidth(80),
                                color: kPrimaryColor,
                                //   SIKINTI
                                //icon sayfadan çıkıp geri girildiğinde değişiyor!!!!!
                                child: LikeButtonWidget(),
                                // child: IconButton(
                                //     icon: toggle
                                //         ? Icon(Icons.favorite_border)
                                //         : Icon(
                                //             Icons.favorite,
                                //           ),
                                //     onPressed: () {
                                //       setState(() {
                                //         // Here we changing the icon.
                                //         toggle = !toggle;
                                //       });
                                //     }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${(cure[index].data() as Map)['about'] ?? ' '} için faydalı',
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(17),
                                  fontFamily: 'muli',
                                color: kPrimaryColor
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(15)),
                            Text(
                              (cure[index].data() as Map)['recipe'] ?? ' ',
                              style: TextStyle(
                                fontSize: getProportionateScreenHeight(15),
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
    );
  }
}

// Bu şekilde oldu burası şekillenicek

//   (cure[index].data() as Map)['curesName'] ?? ' ' bu şekilde kullanılıcak

class PricerCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double ignoreHeight = 20;
    path.lineTo(0, size.height - ignoreHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - ignoreHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

// class CureDetailScreen extends StatefulWidget {
//   final List<DocumentSnapshot> cure;
//   int index;
//
//   CureDetailScreen({required this.cure,required this.index});
//   @override
//   _CureDetailScreenState createState() => _CureDetailScreenState();
// }
//
// class _CureDetailScreenState extends State<CureDetailScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListTile(
//         title: Text((widget.cure as Map)['curesName'] ?? ' '),
//         subtitle: Text((widget.cure as Map)['about'] ?? ' '),
//       ),
//     );
//   }
// }

//
// Text(
// (listOfDocumentSnapshot[index].data()as Map)['curesName'] ?? ' ',   //Şu anca doğru çıkan
// style: TextStyle(
// fontSize: 30,
// ),
// );

// class CureViewModel extends ChangeNotifier {
//   CuresDatabase _database = CuresDatabase();
//
//   Stream<List<Cures>> getCuresList() {
//     Stream<List<DocumentSnapshot>> streamListDocument =
//         _database.getCureList().map((querySnapshot) => querySnapshot.docs);
//
//     Stream<List<Cures>> streamListCures = streamListDocument.map(
//             (listOfDocSnap) => listOfDocSnap
//                 .map((docSnap) => Cures.fromMap(docSnap.data()))
//         .toList());
//
//     return streamListCures;
//   }
// }

// return StreamBuilder<Cures>(
//     stream: CuresDatabase().curesData,
//     builder: (context, snaphot) {
//       return !snaphot.hasData
//           ? CircularProgressIndicator()
//           : ListView.builder(
//               itemCount:
//               itemBuilder: (context, index) {
//                 DocumentSnapshot cure =snaphot.data!.docs[index];
//                 return CureCard(
//                     cure: cure[index]
//                 );
//         },
//       );
//     }
// );



//  eski switch
// switch (index) {
// case 0:
// return Icon(
// Icons.sentiment_very_dissatisfied,
// color: Colors.red,
// );
// case 1:
// return Icon(
// Icons.sentiment_dissatisfied,
// color: Colors.deepOrangeAccent,
// );
// case 2:
// return Icon(
// Icons.sentiment_neutral,
// color: Colors.amberAccent,
// );
// case 3:
// return Icon(
// Icons.sentiment_satisfied,
// color: Colors.lightGreen,
// );
// case 4:
// return Icon(
// Icons.sentiment_very_satisfied,
// color: kPrimaryColor,
// );
// default:
// return Icon(
// Icons.sentiment_very_dissatisfied,
// color: Colors.red,
// );
// }