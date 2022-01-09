import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/teas/tea_detail.dart';
import 'package:fitterapi/services/teas_database.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';



class PregnancyList extends StatefulWidget {
  @override
  _PregnancyListState createState() => _PregnancyListState();
}

class _PregnancyListState extends State<PregnancyList> {
  TeasDatabase teasDatabase = TeasDatabase();
  navigateToDetail(List<DocumentSnapshot> tea, int index) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => TeaDetail(tea: tea, index: index)),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: teasDatabase.getTeasList('Pregnancy'), 
        builder: (context, snapshot) {
          List<DocumentSnapshot> listOfDocumentSnapshot = snapshot.data!.docs;
          return Flexible(
            child: ListView.builder(
              shrinkWrap: true,
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
                          EdgeInsets.all(getProportionateScreenHeight(10)),
                          child: Container(
                            decoration: BoxDecoration(
                              color: pregnancyColor,
                              borderRadius: BorderRadius.circular(
                                  getProportionateScreenHeight(50)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        getProportionateScreenHeight(20)),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            height:
                                            getProportionateScreenHeight(
                                                30)),
                                        Text(
                                          (listOfDocumentSnapshot[index].data()
                                          as Map)['teaName'] ??
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
                                        // Text(
                                        //   (listOfDocumentSnapshot[index].data()
                                        //   as Map)['about'] ??
                                        //       ' ',
                                        //   style: TextStyle(
                                        //     fontSize:
                                        //     getProportionateScreenHeight(
                                        //         16),
                                        //     fontWeight: FontWeight.bold,
                                        //   ),
                                        // ),
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
                  ),
                );
              }
          ),
          );
        }
    );
  }
}


  // Scaffold pregnancyTeaDetail(List<DocumentSnapshot> tea, int index){
  //   return Scaffold(
  //     appBar: AppBar(
  //       centerTitle: true,
  //       iconTheme: IconThemeData(color: Colors.black),
  //       backgroundColor: Colors.white,
  //       title: Text(
  //         (tea[index].data() as Map)['curesName'] ?? ' ',
  //         style: TextStyle(
  //           color: Colors.black26,
  //         ),
  //       ),
  //       actions: [
  //         IconButton(
  //           icon: Icon(Icons.share),
  //           onPressed: () {},
  //         ),
  //         IconButton(
  //           icon: Icon(Icons.more_vert),
  //           onPressed: () {},
  //         ),
  //       ],
  //     ),
  //     body: Container(
  //       decoration: BoxDecoration(
  //         color: pregnancyColor,
  //       ),
  //       child: Column(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               SizedBox(width: getProportionateScreenWidth(10)),
  //               Container(
  //                 height: getProportionateScreenHeight(200),
  //                 width: getProportionateScreenWidth(180),
  //                 margin:
  //                 EdgeInsets.only(top: getProportionateScreenHeight(30)),
  //                 child: Stack(
  //                   children: <Widget>[
  //                     CircleAvatar(
  //                       radius: getProportionateScreenWidth(100),
  //                       backgroundImage: NetworkImage(
  //                         (tea[index].data() as Map)['image'] ?? ' ',
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: getProportionateScreenHeight(30)),
  //           Expanded(
  //             child: Container(
  //               padding: EdgeInsets.all(10),
  //               width: double.infinity,
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(getProportionateScreenHeight(40)),
  //                   topRight: Radius.circular(getProportionateScreenHeight(40)),
  //                 ),
  //               ),
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   children: [
  //                     SizedBox(height: getProportionateScreenHeight(20)),
  //                     Padding(
  //                       padding: const EdgeInsets.all(12.0),
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(10.0),
  //                         child: Row(
  //                           children: [
  //                             Expanded(
  //                               child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Text(
  //                                   '${(tea[index].data() as Map)['useful'] ?? ' '} için ',
  //                                   style: TextStyle(
  //                                       fontSize: getProportionateScreenHeight(17),
  //                                       color: kPrimaryColor
  //                                   ),
  //                                 ),
  //                                   SizedBox(
  //                                       height: getProportionateScreenHeight(3)),
  //                                   Text(
  //                                     (tea[index].data() as Map)['teaName'] ??
  //                                         ' ',
  //                                     style: TextStyle(
  //                                       color: Colors.black,
  //                                       fontSize:
  //                                       getProportionateScreenHeight(18),
  //                                       fontWeight: FontWeight.bold,
  //                                     ),
  //                                   ),
  //                                   SizedBox(
  //                                       height: getProportionateScreenHeight(5)),
  //                                   //reting bar
  //                                   RatingBar.builder(
  //                                     initialRating: 3,
  //                                     itemSize: getProportionateScreenHeight(28),
  //                                     itemCount: 5,
  //                                     itemBuilder: (context, index) {
  //                                       switch (index) {
  //                                         case 0:
  //                                           return Icon(
  //                                             DBIcons.tea,
  //                                             color: Colors.red,
  //                                           );
  //                                         case 1:
  //                                           return Icon(
  //                                             DBIcons.tea,
  //                                             color: Colors.deepOrangeAccent,
  //                                           );
  //                                         case 2:
  //                                           return Icon(
  //                                             DBIcons.tea,
  //                                             color: Colors.amberAccent,
  //                                           );
  //                                         case 3:
  //                                           return Icon(
  //                                             DBIcons.tea,
  //                                             color: Colors.lightGreen,
  //                                           );
  //                                         case 4:
  //                                           return Icon(
  //                                             DBIcons.tea,
  //                                             color: kPrimaryColor,
  //                                           );
  //                                         default:
  //                                           return Icon(
  //                                             DBIcons.tea,
  //                                             color: Colors.red,
  //                                           );
  //                                       }
  //                                     },
  //                                     onRatingUpdate: (rating) {
  //                                       print(rating);
  //                                     },
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             // favorite button
  //                             ClipPath(
  //                               clipper: PricerCliper(),
  //                               child: Container(
  //                                 alignment: Alignment.topCenter,
  //                                 padding: EdgeInsets.symmetric(
  //                                     horizontal: getProportionateScreenHeight(2),
  //                                     vertical: getProportionateScreenHeight(5)),
  //                                 height: getProportionateScreenHeight(60),
  //                                 width: getProportionateScreenWidth(80),
  //                                 color: kPrimaryColor,
  //                                 //   SIKINTI
  //                                 //icon sayfadan çıkıp geri girildiğinde değişiyor!!!!!
  //                                 child: LikeButtonWidget(),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Expanded(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               'Çay Hakkında',
  //                               style: TextStyle(
  //                                 fontSize: getProportionateScreenHeight(15),
  //                                 color: Colors.pinkAccent,
  //                               ),
  //                             ),
  //                             SizedBox(height: getProportionateScreenHeight(2)),
  //                             Text(
  //                               (tea[index].data() as Map)['info'] ?? ' ',
  //                               style: TextStyle(
  //                                 fontSize: getProportionateScreenHeight(15),
  //                                 fontFamily: 'muli',
  //                               ),
  //                             ),
  //                             SizedBox(height: getProportionateScreenHeight(15)),
  //                             Text(
  //                               'Çay Tarifi',
  //                               style: TextStyle(
  //                                 fontSize: getProportionateScreenHeight(15),
  //                                 color: Colors.pinkAccent,
  //                               ),
  //                             ),
  //                             SizedBox(height: getProportionateScreenHeight(2)),
  //                             Text(
  //                               (tea[index].data() as Map)['recipe'] ?? ' ',
  //                               style: TextStyle(
  //                                 fontSize: getProportionateScreenHeight(15),
  //                                 fontFamily: 'muli',
  //                               ),
  //                             ),
  //                             SizedBox(height: getProportionateScreenHeight(15)),
  //                             Text(
  //                               'Okumadan Geçmeyin!',
  //                               style: TextStyle(
  //                                 fontSize: getProportionateScreenHeight(15),
  //                                 color: Colors.pinkAccent,
  //                               ),
  //                             ),
  //                             SizedBox(height: getProportionateScreenHeight(2)),
  //                             Text(
  //                               (tea[index].data() as Map)['warning'] ?? ' ',
  //                               style: TextStyle(
  //                                 fontSize: getProportionateScreenHeight(15),
  //                                 fontFamily: 'muli',
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //
  //   );
  // }





