import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/services/teas_database.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SleepList extends StatefulWidget {
  @override
  _SleepListState createState() => _SleepListState();
}

class _SleepListState extends State<SleepList> {
  TeasDatabase teasDatabase = TeasDatabase();

  navigateToDetail(List<DocumentSnapshot> cure, int index) {
    Get.to(() => sleepTeaDetail(cure, index));
    //CureDetailScreen(cure: cure,index: index,));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: teasDatabase.getTeasList('Sleep'),
        builder: (context, snapshot) {
          List<DocumentSnapshot> listOfDocumentSnapshot = snapshot.data!.docs;
          return Flexible(
              child: ListView.builder(
                  itemCount: listOfDocumentSnapshot.length,
                  itemBuilder: (context, index){
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
                                color: sleepColor,
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

  Scaffold sleepTeaDetail(List<DocumentSnapshot> cure, int index){
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
          color: sleepColor,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(width: getProportionateScreenWidth(10)),
                Container(
                  height: getProportionateScreenHeight(200),
                  width: getProportionateScreenWidth(180),
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

          ],
        ),
      ),

    );
  }

}
