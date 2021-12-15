import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CuresModel extends Equatable {
  final String curesName;
  final String about;
  final String recipe;
  final String image;

  CuresModel({
    required this.curesName,
    required this.about,
    required this.recipe,
    required this.image,
  });

  @override
  List<Object?> get props {
    //props equatable da şart
    return [
      curesName,
      about,
      recipe,
      image,
    ];
  }

  CuresModel copyWith({
    String? curesName,
    String? about,
    String? recipe,
    String? image,
  }) {
    return CuresModel(

      curesName: curesName ?? this.curesName,
      about: about ?? this.about,
      recipe: recipe ?? this.recipe,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'curesName': curesName,
      'about': about,
      'recipe': recipe,
      'image': image,
    };
  }

  factory CuresModel.fromSnapshot(DocumentSnapshot snap){
    return CuresModel(
      curesName: snap['curesName'],
      about: snap['about'],
      recipe: snap['recipe'],
      image: snap['image'],
    );
  }

  factory CuresModel.fromMap(Map _map){
    return CuresModel(
      curesName: _map['curesName'],
      about: _map['about'],
      recipe: _map['recipe'],
      image: _map['image'],
    );
  }

  String toJson() => json.encode(toMap());

}
