import 'package:fitterapi/main_page/course/course.dart';
import 'package:fitterapi/main_page/course/course_list.dart';
import 'package:fitterapi/main_page/prepared/search.dart';
import 'package:fitterapi/services/courseDatabase.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Course>>.value(
      value: CourseDatabase().courseData,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            children: <Widget>[
              Search(),
              SizedBox(height: getProportionateScreenHeight(20)),
              CourseList(),
            ],
          ),
        ),
      ),
    );
  }
}
