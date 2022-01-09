import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/course/course_detail.dart';
import 'package:fitterapi/services/courseDatabase.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseList extends StatefulWidget {
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  CourseDatabase _courseDatabase = CourseDatabase();

  navigateToDetail(List<DocumentSnapshot> course, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CourseDetail(course: course, index: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _courseDatabase.getCourseList(),
        builder: (context, snapshot) {
          List<DocumentSnapshot> listOfDocumentSnapshot = snapshot.data!.docs;
          return Expanded(
            child: GridView.builder(
                itemCount: listOfDocumentSnapshot.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () =>
                        navigateToDetail(listOfDocumentSnapshot, index),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(
                                  getProportionateScreenHeight(4)),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                //borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.network(
                                  (listOfDocumentSnapshot[index].data()
                                          as Map)['image'] ??
                                      ' ',
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenHeight(15),
                                vertical: getProportionateScreenWidth(10)),
                            child: Text(
                              (listOfDocumentSnapshot[index].data()
                                      as Map)['courseName'] ??
                                  ' ',
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
                              (listOfDocumentSnapshot[index].data()
                                      as Map)['teacher'] ??
                                  ' ',
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
                }),
          );
        });
  }
}
