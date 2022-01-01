import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:fitterapi/main_page/profile/edit_form.dart';

import 'package:flutter/material.dart';




class ProfileEdit extends StatefulWidget {
  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  File? _image;

  void _getPhoto(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      _image = File(pickedFile!.path);
    });

    //add profile photo to Firebase Storage
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
    storage.ref().child("user").child("admin").child("profil.png");

    //UploadTask uploadTask = ref.putFile(_image!);
    // var imageUrl = await (await uploadTask).ref.getDownloadURL(); we will use
  }

  // final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Users user = Provider.of<Users>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Profil Düzenle",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: EditForm(),
          ),
        ),
      );
  }
}
