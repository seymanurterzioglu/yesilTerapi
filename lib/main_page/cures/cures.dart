
import 'package:cloud_firestore/cloud_firestore.dart';

class Cures {
  //String? id;
  String? curesName;
  String? about;
  String? recipe;
  String? image;

  Cures({
    //required this.id,
    required this.curesName,
    required this.about,
    required this.recipe,
    required this.image,
  });

  Cures.fromSnapshot(DocumentSnapshot snap)
    :
      curesName= snap['curesName'],
      about= snap['about'],
      recipe= snap['recipe'],
      image= snap['image']

  ;

}
