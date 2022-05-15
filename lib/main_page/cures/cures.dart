
import 'package:cloud_firestore/cloud_firestore.dart';

class Cures {
  //String? id;
  String? curesName;
  String? curesId;
  String? about;
  String? recipe;
  String? image;

  Cures({
    //required this.id,
    required this.curesName,
    required this.curesId,
    required this.about,
    required this.recipe,
    required this.image,
  });

  Cures.fromSnapshot(DocumentSnapshot snap)
    :
      curesName= snap['curesName'],
        curesId= snap['curesId'],
      about= snap['about'],
      recipe= snap['recipe'],
      image= snap['image']

  ;

}
