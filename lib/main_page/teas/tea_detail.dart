import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/prepared/idb_icons.dart';
import 'package:fitterapi/main_page/prepared/pricer_cliper.dart';
import 'package:fitterapi/main_page/teas/teas.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:share_plus/share_plus.dart';

Widget teaDetail(BuildContext context, DocumentSnapshot document) {
  final tea = Teas.fromSnapshot(document);

  Future addtoFavorites() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users-favorites');
    return _collectionRef.doc(currentUser!.email).collection("teas").doc().set({
      "teaName": tea.teaName,
      "info": tea.info,
      "useful": tea.useful,
      "image": tea.image,
      "recipe": tea.recipe,
      "warning": tea.warning,
    }).then((value) => print("Added to favourite"));
  }

  void shareTea(BuildContext context,String message){
    RenderBox? box= context.findRenderObject() as RenderBox;
    Share.share(message, subject: 'Deneme', sharePositionOrigin: box.localToGlobal(Offset.zero)& box.size);
  }

  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      title: Text(
        tea.teaName!,
        style: TextStyle(
          color: Colors.black26,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () async{
            shareTea(context,tea.recipe!);
          },
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: getProportionateScreenWidth(10)),
                        FullScreenWidget(
                          backgroundColor: Colors.black,
                          backgroundIsTransparent: true,
                          child: Container(
                            height: getProportionateScreenHeight(200),
                            width: getProportionateScreenWidth(250),

                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  tea.image!,
                                ),
                                fit: BoxFit.contain,
                              ),
                              //borderRadius: BorderRadius.all(Radius.circular(70)),
                              // boxShadow: [
                              //   BoxShadow(
                              //     offset: Offset(0, 4),
                              //     blurRadius: 15,
                              //     color: Colors.white.withOpacity(0.7),
                              //   ),
                              // ],
                            ),
                            margin: EdgeInsets.only(
                                top: getProportionateScreenHeight(30)),

                            // child: Stack(
                            //   children: <Widget>[
                            //     CircleAvatar(
                            //       radius: getProportionateScreenWidth(100),
                            //       backgroundImage: NetworkImage(
                            //         (tea[index].data() as Map)['image'] ?? ' ',
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(25)),
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
                              offset: Offset(5, 2),
                              blurRadius: 10,
                              color: kPrimaryColor.withOpacity(0.9),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                  height: getProportionateScreenHeight(20)),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${tea.useful!} için ',
                                              style: TextStyle(
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          17),
                                                  color: kPrimaryColor),
                                            ),
                                            SizedBox(
                                                height:
                                                    getProportionateScreenHeight(
                                                        3)),
                                            Text(
                                              tea.teaName!,
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
                                                        5)),
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
                                                      DBIcons.tea,
                                                      color: Colors.red,
                                                    );
                                                  case 1:
                                                    return Icon(
                                                      DBIcons.tea,
                                                      color: Colors
                                                          .deepOrangeAccent,
                                                    );
                                                  case 2:
                                                    return Icon(
                                                      DBIcons.tea,
                                                      color: Colors.amberAccent,
                                                    );
                                                  case 3:
                                                    return Icon(
                                                      DBIcons.tea,
                                                      color: Colors.lightGreen,
                                                    );
                                                  case 4:
                                                    return Icon(
                                                      DBIcons.tea,
                                                      color: kPrimaryColor,
                                                    );
                                                  default:
                                                    return Icon(
                                                      DBIcons.tea,
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
                                                .collection('teas')
                                                .where('teaName',
                                                    isEqualTo: tea.teaName)
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
                                        'Çay Hakkında',
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(15),
                                          color: Colors.pinkAccent,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(2)),
                                      Text(
                                        tea.info!,
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(15),
                                          fontFamily: 'muli',
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(15)),
                                      Text(
                                        'Çay Tarifi',
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(15),
                                          color: Colors.pinkAccent,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(2)),
                                      Text(
                                        tea.recipe!,
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(15),
                                          fontFamily: 'muli',
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(15)),
                                      Text(
                                        'Okumadan Geçmeyin!',
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(15),
                                          color: Colors.pinkAccent,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(2)),
                                      Text(
                                        tea.warning!,
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

// class TeaDetail extends StatelessWidget {
//   final List<DocumentSnapshot> tea;
//   final int index;
//
//   TeaDetail({
//     required this.tea,
//     required this.index,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         iconTheme: IconThemeData(color: Colors.black),
//         backgroundColor: Colors.white,
//         title: Text(
//           (tea[index].data() as Map)['curesName'] ?? ' ',
//           style: TextStyle(
//             color: Colors.black26,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.share),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.more_vert),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                   minWidth: constraints.maxWidth,
//                   minHeight: constraints.maxHeight),
//               child: IntrinsicHeight(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           SizedBox(width: getProportionateScreenWidth(10)),
//                           Container(
//                             height: getProportionateScreenHeight(200),
//                             width: getProportionateScreenWidth(250),
//
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: NetworkImage(
//                                   (tea[index].data() as Map)['image'] ?? ' ',
//                                 ),
//                                 fit: BoxFit.cover,
//                               ),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(70)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   offset: Offset(0, 4),
//                                   blurRadius: 15,
//                                   color: kPrimaryColor.withOpacity(0.7),
//                                 ),
//                               ],
//                             ),
//                             margin: EdgeInsets.only(
//                                 top: getProportionateScreenHeight(30)),
//
//                             // child: Stack(
//                             //   children: <Widget>[
//                             //     CircleAvatar(
//                             //       radius: getProportionateScreenWidth(100),
//                             //       backgroundImage: NetworkImage(
//                             //         (tea[index].data() as Map)['image'] ?? ' ',
//                             //       ),
//                             //     ),
//                             //   ],
//                             // ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: getProportionateScreenHeight(25)),
//                       Expanded(
//                         child: Container(
//                           padding: EdgeInsets.all(10),
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(
//                                   getProportionateScreenHeight(40)),
//                               topRight: Radius.circular(
//                                   getProportionateScreenHeight(40)),
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 offset: Offset(5, 2),
//                                 blurRadius: 10,
//                                 color: kPrimaryColor.withOpacity(0.9),
//                               ),
//                             ],
//                           ),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 SizedBox(
//                                     height: getProportionateScreenHeight(20)),
//                                 Padding(
//                                   padding: const EdgeInsets.all(12.0),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 '${(tea[index].data() as Map)['useful'] ?? ' '} için ',
//                                                 style: TextStyle(
//                                                     fontSize:
//                                                         getProportionateScreenHeight(
//                                                             17),
//                                                     color: kPrimaryColor),
//                                               ),
//                                               SizedBox(
//                                                   height:
//                                                       getProportionateScreenHeight(
//                                                           3)),
//                                               Text(
//                                                 (tea[index].data()
//                                                         as Map)['teaName'] ??
//                                                     ' ',
//                                                 style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize:
//                                                       getProportionateScreenHeight(
//                                                           18),
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                   height:
//                                                       getProportionateScreenHeight(
//                                                           5)),
//                                               //reting bar
//                                               RatingBar.builder(
//                                                 initialRating: 3,
//                                                 itemSize:
//                                                     getProportionateScreenHeight(
//                                                         28),
//                                                 itemCount: 5,
//                                                 itemBuilder: (context, index) {
//                                                   switch (index) {
//                                                     case 0:
//                                                       return Icon(
//                                                         DBIcons.tea,
//                                                         color: Colors.red,
//                                                       );
//                                                     case 1:
//                                                       return Icon(
//                                                         DBIcons.tea,
//                                                         color: Colors
//                                                             .deepOrangeAccent,
//                                                       );
//                                                     case 2:
//                                                       return Icon(
//                                                         DBIcons.tea,
//                                                         color:
//                                                             Colors.amberAccent,
//                                                       );
//                                                     case 3:
//                                                       return Icon(
//                                                         DBIcons.tea,
//                                                         color:
//                                                             Colors.lightGreen,
//                                                       );
//                                                     case 4:
//                                                       return Icon(
//                                                         DBIcons.tea,
//                                                         color: kPrimaryColor,
//                                                       );
//                                                     default:
//                                                       return Icon(
//                                                         DBIcons.tea,
//                                                         color: Colors.red,
//                                                       );
//                                                   }
//                                                 },
//                                                 onRatingUpdate: (rating) {
//                                                   print(rating);
//                                                 },
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         // favorite button
//                                         ClipPath(
//                                           clipper: PricerCliper(),
//                                           child: Container(
//                                             alignment: Alignment.topCenter,
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal:
//                                                     getProportionateScreenHeight(
//                                                         2),
//                                                 vertical:
//                                                     getProportionateScreenHeight(
//                                                         5)),
//                                             height:
//                                                 getProportionateScreenHeight(
//                                                     60),
//                                             width:
//                                                 getProportionateScreenWidth(80),
//                                             color: kPrimaryColor,
//                                             //   SIKINTI
//                                             //icon sayfadan çıkıp geri girildiğinde değişiyor!!!!!
//                                             child: LikeButtonWidget(),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Çay Hakkında',
//                                           style: TextStyle(
//                                             fontSize:
//                                                 getProportionateScreenHeight(
//                                                     15),
//                                             color: Colors.pinkAccent,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                             height:
//                                                 getProportionateScreenHeight(
//                                                     2)),
//                                         Text(
//                                           (tea[index].data() as Map)['info'] ??
//                                               ' ',
//                                           style: TextStyle(
//                                             fontSize:
//                                                 getProportionateScreenHeight(
//                                                     15),
//                                             fontFamily: 'muli',
//                                           ),
//                                         ),
//                                         SizedBox(
//                                             height:
//                                                 getProportionateScreenHeight(
//                                                     15)),
//                                         Text(
//                                           'Çay Tarifi',
//                                           style: TextStyle(
//                                             fontSize:
//                                                 getProportionateScreenHeight(
//                                                     15),
//                                             color: Colors.pinkAccent,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                             height:
//                                                 getProportionateScreenHeight(
//                                                     2)),
//                                         Text(
//                                           (tea[index].data()
//                                                   as Map)['recipe'] ??
//                                               ' ',
//                                           style: TextStyle(
//                                             fontSize:
//                                                 getProportionateScreenHeight(
//                                                     15),
//                                             fontFamily: 'muli',
//                                           ),
//                                         ),
//                                         SizedBox(
//                                             height:
//                                                 getProportionateScreenHeight(
//                                                     15)),
//                                         Text(
//                                           'Okumadan Geçmeyin!',
//                                           style: TextStyle(
//                                             fontSize:
//                                                 getProportionateScreenHeight(
//                                                     15),
//                                             color: Colors.pinkAccent,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                             height:
//                                                 getProportionateScreenHeight(
//                                                     2)),
//                                         Text(
//                                           (tea[index].data()
//                                                   as Map)['warning'] ??
//                                               ' ',
//                                           style: TextStyle(
//                                             fontSize:
//                                                 getProportionateScreenHeight(
//                                                     15),
//                                             fontFamily: 'muli',
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
