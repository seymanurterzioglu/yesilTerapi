import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/main_page/course/course.dart';


class CourseDatabase{

final CollectionReference courseCollection =
FirebaseFirestore.instance.collection('course');



Stream<QuerySnapshot> getCourseList() {
  return courseCollection.orderBy('courseName').snapshots();
}

List<Course> _courseListFromSnapshot(QuerySnapshot snapshot) {
  return snapshot.docs.map((doc) {
    return Course(
      courseName: doc.get('courseName') ?? '',
      about: doc.get('about') ?? '',
      teacher: doc.get('teacher') ?? '',
      image: doc.get('image') ?? '',
      price: doc.get('price') ?? '',
      touch: doc.get('touch') ?? '',
    );
  }).toList();
}



Stream<List<Course>> get courseData {
  return courseCollection.snapshots().map(_courseListFromSnapshot);
}

}