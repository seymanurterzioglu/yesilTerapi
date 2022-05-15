import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/course/course.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';

Widget listFavoriteCourse() {
  return Scaffold(
    body: Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users-favorites')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection( 'courses')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return CircularProgressIndicator();
              }
              return Expanded(
                child: GridView.builder(
                  itemCount:
                      snapshot.data == null ? 0 : snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (_, index) {
                    DocumentSnapshot _documentSnapshot =
                        snapshot.data!.docs[index];
                    return listCourse(context, _documentSnapshot);
                  },
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

Widget listCourse(BuildContext context, DocumentSnapshot document) {
  final course = Course.fromSnapshot(document);
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => detailCourse(context, document)),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenHeight(2)),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                //borderRadius: BorderRadius.circular(20),
              ),
              child: Image.network(course.image, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(15),
                vertical: getProportionateScreenWidth(10)),
            child: Text(
              course.courseName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                //fontStyle: FontStyle.italic,
                fontSize: getProportionateScreenHeight(16),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(17),
              //vertical: getProportionateScreenWidth(10),
            ),
            child: Text(
              course.teacher,
              style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontSize: getProportionateScreenHeight(13),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget detailCourse(BuildContext context, DocumentSnapshot document) {
  final course = Course.fromSnapshot(document);

  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      title: Text(
        course.courseName,
        style: TextStyle(
          color: Colors.black26,
        ),
      ),
    ),
    body: LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
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
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              course.image,
                            ),
                          ),
                        ),
                      ),
                      // favorite button position
                      Positioned(
                        bottom: 10,
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
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users-favorites')
                                .doc(FirebaseAuth
                                    .instance.currentUser!.email)
                                .collection('courses')
                                .where('courseName',
                                    isEqualTo: course.courseName)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return Text(' ');
                              }
                              return IconButton(
                                onPressed: () {
                                  if (snapshot.data.docs.length != 0) {
                                    // delete
                                    FirebaseFirestore.instance
                                        .collection('users-favorites')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                        .collection('courses')
                                        .doc(document
                                            .id)
                                        .delete();
                                    print('Favorilerden silindi');
                                  }
                                  Navigator.of(context).pop();
                                },
                                icon: snapshot.data.docs.length == 0
                                    ? Icon(Icons.star_border_outlined,
                                        size: getProportionateScreenHeight(
                                            45))
                                    : Icon(Icons.star,
                                        size: getProportionateScreenHeight(
                                            45),
                                        color: Colors.red),
                              );
                            },
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
                                course.courseName,
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
                                course.teacher,
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
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //     left: getProportionateScreenWidth(35),
                      //   ),
                      //   child: RatingBar.builder(
                      //     minRating: 1,
                      //     itemPadding: EdgeInsets.all(2.0),
                      //     itemSize: getProportionateScreenHeight(23),
                      //     itemCount: 5,
                      //     itemBuilder: (context, index) {
                      //       switch (index) {
                      //         case 0:
                      //           return Icon(
                      //             Icons.computer,
                      //             color: Colors.red,
                      //           );
                      //         case 1:
                      //           return Icon(
                      //             Icons.computer,
                      //             color: Colors.deepOrangeAccent,
                      //           );
                      //         case 2:
                      //           return Icon(
                      //             Icons.computer,
                      //             color: Colors.amberAccent,
                      //           );
                      //         case 3:
                      //           return Icon(
                      //             Icons.computer,
                      //             color: Colors.lightGreen,
                      //           );
                      //         case 4:
                      //           return Icon(
                      //             Icons.computer,
                      //             color: kPrimaryColor,
                      //           );
                      //         default:
                      //           return Icon(
                      //             Icons.computer,
                      //             color: Colors.red,
                      //           );
                      //       }
                      //     },
                      //     onRatingUpdate: (rating) {
                      //       print(rating);
                      //     },
                      //   ),
                      // ),
                      SizedBox(width: getProportionateScreenWidth(9)),
                      // Text(
                      //   '${rate}',
                      //   style: TextStyle(
                      //     color: Colors.black38,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: getProportionateScreenHeight(18),
                      //   ),
                      // ),
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
                              '     ${course.about}',
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
                              '     ${course.touch}',
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
                              '     ${course.price}',
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
