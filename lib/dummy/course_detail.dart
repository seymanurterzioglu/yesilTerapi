import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';

class CourseDetail extends StatelessWidget {
  final List<DocumentSnapshot> course;
  final int index;
  //CourseDatabase _courseDatabase=CourseDatabase();

  CourseDetail({
    required this.course,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    int rate=(course[index].data() as Map)['rate'] ?? ' ';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          (course[index].data() as Map)['courseName'] ?? ' ',
          style: TextStyle(
            color: Colors.black26,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context,constraints){
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // image and favorite button
                    Container(
                      height: 300,
                      child: Stack(children: [
                        Container(
                          height: getProportionateScreenHeight(280),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(50)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  (course[index].data() as Map)['image'] ?? ' '),
                            ),
                          ),
                        ),
                        // favorite button position
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            // it will cover 90% of our total width
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                topLeft: Radius.circular(50),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 7),
                                  blurRadius: 20,
                                  color: Colors.black38.withOpacity(0.7),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                LikeButtonCourse(),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                    // course name, teacher, rating bar
                    Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(30),
                        right: getProportionateScreenWidth(35),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      (course[index].data() as Map)['courseName'] ?? ' ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        //fontStyle: FontStyle.italic,
                                        fontSize: getProportionateScreenHeight(20),
                                        fontFamily: 'muli',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getProportionateScreenHeight(5),
                                    ),
                                    child: Text(
                                      (course[index].data() as Map)['teacher'] ?? ' ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontSize: getProportionateScreenHeight(16),
                                        fontFamily: 'muli',
                                      ),
                                    ),
                                  ),
                                ],
                              )),

                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(35),
                          ),
                          child: RatingBar.builder(
                            minRating: 1,
                            itemPadding: EdgeInsets.all(2.0),
                            itemSize: getProportionateScreenHeight(23),
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  return Icon(
                                    Icons.computer,
                                    color: Colors.red,
                                  );
                                case 1:
                                  return Icon(
                                    Icons.computer,
                                    color: Colors.deepOrangeAccent,
                                  );
                                case 2:
                                  return Icon(
                                    Icons.computer,
                                    color: Colors.amberAccent,
                                  );
                                case 3:
                                  return Icon(
                                    Icons.computer,
                                    color: Colors.lightGreen,
                                  );
                                case 4:
                                  return Icon(
                                    Icons.computer,
                                    color: kPrimaryColor,
                                  );
                                default:
                                  return Icon(
                                    Icons.computer,
                                    color: Colors.red,
                                  );
                              }
                            },
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
                        SizedBox(width: getProportionateScreenWidth(9)),
                        Text(
                          '${rate}',
                          style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenHeight(18),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenWidth(15)),
                    Expanded(
                      child: Container(
                        //height: getProportionateScreenHeight(200),
                        //width: getProportionateScreenWidth(740),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // hakkında
                            Padding(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(20),
                                  left: getProportionateScreenWidth(30)),
                              child: Text(
                                'Hakkında',
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(17),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                '     ${(course[index].data() as Map)['about'] ?? ' '}',
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(16),
                                  fontFamily: 'muli',
                                ),
                              ),
                            ),

                            //touch
                            Padding(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(10),
                                  left: getProportionateScreenWidth(30)),
                              child: Text(
                                'İletişim',
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(17),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                '     ${(course[index].data() as Map)['touch'] ?? ' '}',
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(16),
                                  fontFamily: 'muli',
                                ),
                              ),
                            ),

                            //price
                            Padding(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenHeight(10),
                                  left: getProportionateScreenWidth(30)),
                              child: Text(
                                'Fiyat',
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(17),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                '     ${(course[index].data() as Map)['price'] ?? ' '}',
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(16),
                                  fontFamily: 'muli',
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
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class LikeButtonCourse extends StatelessWidget {
  double buttonSize = 40;
  bool isLiked = false;
  int likeCount = 0;

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: buttonSize,
      isLiked: isLiked,
      //likeCount: likeCount,
      bubblesColor: BubblesColor(
        dotPrimaryColor: Colors.red,
        dotSecondaryColor: Colors.deepOrangeAccent,
      ),
      likeBuilder: (isLiked) {
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            Icons.favorite,
            color: isLiked ? Colors.redAccent : Colors.grey,
            size: buttonSize,
          ),
        );
      },
      // likeCountPadding: EdgeInsets.only(left: getProportionateScreenHeight(8)),
      // countBuilder: (count, isLiked, txt) {
      //   return Text(
      //     txt,
      //     style: TextStyle(
      //       color: isLiked ? Colors.red : Colors.grey,
      //       fontSize: getProportionateScreenHeight(20),
      //       fontWeight: FontWeight.bold,
      //     ),
      //   );
      // },
      onTap: (isLiked) async {
        this.isLiked = !isLiked;
        likeCount += this.isLiked ? 1 : -1;
        return !isLiked;
      },
    );
  }
}
