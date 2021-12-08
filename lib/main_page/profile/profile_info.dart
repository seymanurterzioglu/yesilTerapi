import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitterapi/button.dart';

import 'package:fitterapi/main_page/profile/profile_edit.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';

import 'package:fitterapi/services/auth.dart';
import 'package:fitterapi/services/user_database.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';

class ProfileInfo extends StatefulWidget {
  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final currentUser = FirebaseAuth.instance.currentUser;

  final AuthService auth = AuthService();

  UserData userData = UserData();

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

  final _formKey = GlobalKey<FormState>();

  String? _firstName;

  String? _lastName;

  String? _age;

  String? _height;

  String? _weight;

  String? _disease;

  @override
  Widget build(BuildContext context) {
    Users user = Provider.of<Users>(context);
    UserDatabase userDatabase = UserDatabase(uid: currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Profil ",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(15),
              vertical: getProportionateScreenWidth(40)),
          child: Column(
            children: <Widget>[
              SizedBox(height: getProportionateScreenHeight(20)),

              StreamBuilder<UserData>(
                //stream: UserDatabase(uid: user.uid).userData,
                stream: userDatabase.userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserData? _userData = snapshot.data;
                    //firstnami diğerlerinede uygulayınca sıkıntı çıkıyor nedense
                    _firstName=_userData!.firstName!;
                    // return Text(
                    //   'İsim:' + _userData!.firstName!,
                    //   style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: getProportionateScreenHeight(20),
                    //       fontWeight: FontWeight.bold
                    //   ),
                    // );

                    return Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: getProportionateScreenHeight(10)),
                          ImageProfile(context),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          //firstName Form
                          TextFormField(
                            onChanged: (val) =>
                                setState(() => _firstName = val),
                            decoration: InputDecoration(
                              labelText: "İsim",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(20),
                              hintText: _firstName,
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          //lastName Form
                          TextFormField(
                            onChanged: (val) => setState(() => _lastName = val),
                            decoration: InputDecoration(
                              labelText: "Soyisim",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(20),
                              hintText: "Soyisminizi Giriniz.",
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          // Age form
                          TextFormField(
                            onChanged: (val) => setState(() => _age = val),
                            decoration: InputDecoration(
                              labelText: "Yaş",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(20),
                              hintText: "Yaşınızı Giriniz.",
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          // height form
                          TextFormField(
                            onChanged: (val) => setState(() => _height = val),
                            decoration: InputDecoration(
                              labelText: "Boy",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(20),
                              hintText: "Boyunuzu Giriniz.",
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          // weight form
                          TextFormField(
                            onChanged: (val) => setState(() => _weight = val),
                            decoration: InputDecoration(
                              labelText: "Kilo",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(20),
                              hintText: "Kilonuzu Giriniz.",
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          //Disease form
                          TextFormField(
                            onChanged: (val) => setState(() => _disease = val),
                            decoration: InputDecoration(
                              labelText: "Hastalık",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(20),
                              hintText: "Hastalığınızı Giriniz.",
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenHeight(50),
                                vertical: getProportionateScreenWidth(10)),
                            child: Button(
                              text: "Düzenle",
                              press: () async {
                                User? user = FirebaseAuth.instance.currentUser;
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user!.uid)
                                    .set({
                                  'uid': user.uid,
                                  'firstName': _firstName,
                                  'lastName': _lastName,
                                  'age': _age,
                                  'height': _height,
                                  'weight': _weight,
                                  'disease': _disease,
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Text('Something wrong');
                  }
                },
              ),
              // Button(
              //   text: 'Profili Düzenle',
              //   press: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => ProfileEdit()),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ImageProfile(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: getProportionateScreenWidth(10)),
        Container(
          height: getProportionateScreenHeight(160),
          width: getProportionateScreenWidth(140),
          margin: EdgeInsets.only(top: getProportionateScreenHeight(20)),
          child: Stack(
            children: <Widget>[
              _image != null
                  ? CircleAvatar(
                      radius: getProportionateScreenWidth(80),
                      backgroundImage: FileImage(_image!),
                    )
                  : CircleAvatar(
                      radius: getProportionateScreenWidth(80),
                      backgroundImage: AssetImage('assets/images/back4.jpg'),
                    ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: getProportionateScreenHeight(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        builder: ((builder) => bottomSheet()),
                        context: context,
                      );
                    },
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: getProportionateScreenHeight(25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: getProportionateScreenHeight(100),
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenHeight(30),
          vertical: getProportionateScreenWidth(20)),
      child: Column(
        children: <Widget>[
          Text(
            'Profil Resmini Seçiniz',
            style: TextStyle(fontSize: getProportionateScreenWidth(17)),
          ),
          SizedBox(height: getProportionateScreenHeight(16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                onPressed: () {
                  _getPhoto(ImageSource.camera);
                  //takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera_alt),
                label: Text('Kamera',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                    )),
              ),
              TextButton.icon(
                style: TextButton.styleFrom(primary: Colors.black),
                onPressed: () async {
                  _getPhoto(ImageSource.gallery);

                  //  resim firebase upload etmek için ama önce hesapla giriş yapmak lazım

                  // final results = await FilePicker.platform.pickFiles(
                  //   allowMultiple: false,
                  //   type: FileType.custom,
                  //   allowedExtensions: ['png','jpg',],
                  // );
                  //
                  // final path = results!.files.single.path!;
                  // final fileName = results.files.single.name;
                  //
                  // print(path);
                  // print(fileName);
                },
                icon: Icon(Icons.image),
                label: Text('Galeri',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}