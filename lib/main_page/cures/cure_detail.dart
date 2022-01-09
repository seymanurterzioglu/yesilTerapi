import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/prepared/idb_icons.dart';
import 'package:fitterapi/main_page/prepared/like_button.dart';
import 'package:fitterapi/main_page/prepared/pricer_cliper.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class CureDetail extends StatelessWidget {
  final List<DocumentSnapshot> cure;
  final int index;

  CureDetail({
    required this.cure,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
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
      body: LayoutBuilder(
        builder: (context,constraints){
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
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
              ),
            ),
          );
        },
      ),
    );
  }
}

