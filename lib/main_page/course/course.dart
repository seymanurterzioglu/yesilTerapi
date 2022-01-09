import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  //String? id;
  String courseName;
  String about;
  String image;
  String price;
  String teacher;
  String touch;

  Course({
    //required this.id,
    required this.courseName,
    required this.about,
    required this.image,
    required this.price,
    required this.teacher,
    required this.touch
  });

  Course.fromSnapshot(DocumentSnapshot snapshot)
      : courseName = snapshot['courseName'],
        touch = snapshot['touch'],
        teacher = snapshot['teacher'],
        price = snapshot['price'],
        image = snapshot['image'],
        about = snapshot['about'];
}
