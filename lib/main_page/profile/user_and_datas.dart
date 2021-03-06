import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  final String? uid;

  Users({this.uid});
}

class UserData {
  String? uid;
  String? firstName;
  String? lastName;
  String? age;
  String? height;
  String? weight;
  String? disease;
  String? image;
  String? nickname;
  //List<String>? isLikeList;

  UserData({
    this.uid,
    this.firstName,
    this.lastName,
    this.age,
    this.height,
    this.weight,
    this.disease,
    this.image,
    this.nickname,
   //this.isLikeList
  });


  UserData.fromSnapshot(DocumentSnapshot snap)
      :
        firstName= snap['firstName'],
        lastName= snap['lastName'],
        age= snap['age'],
        height= snap['height'],
        weight= snap['weight'],
        disease= snap['disease'],
        image= snap['image'],
        nickname= snap['nickname']
        //isLikeList= snap['isLikeList']
  ;

}
