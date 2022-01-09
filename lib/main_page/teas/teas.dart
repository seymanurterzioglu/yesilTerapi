import 'package:cloud_firestore/cloud_firestore.dart';

class Teas {
  //String? id;
  String? teaName;
  String? useful;
  String? info;
  String? recipe;
  String? warning;
  String? image;

  Teas({
    required this.teaName,
    required this.useful,
    required this.info,
    required this.recipe,
    required this.warning,
    required this.image,
  });

  Teas.fromSnapshot(DocumentSnapshot snapshot)
      : teaName = snapshot['teaName'],
        useful = snapshot['useful'],
        info = snapshot['info'],
        recipe = snapshot['recipe'],
        warning = snapshot['warning'],
        image = snapshot['image'];
}
