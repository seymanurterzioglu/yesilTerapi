import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/services/teas_database.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';

class StomachList extends StatefulWidget {
  @override
  _StomachListState createState() => _StomachListState();
}

class _StomachListState extends State<StomachList> {
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
      stream: teasDatabase.getTeasList('Stomach'),
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
                        EdgeInsets.all(getProportionateScreenHeight(10)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: stomachColor,
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
      },
    );
  }
}

         ///////////////////////Forum tabBar dummy code

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
         ///////////////////////