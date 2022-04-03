import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/services/auth.dart';
import 'package:fitterapi/services/user_database.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
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
    currentUser!.updatePhotoURL('${_image}');
    FirebaseStorage storage = FirebaseStorage.instance;
    UploadTask ref = storage
        .ref('userPhoto/${currentUser!.email}')
        .putFile(File(pickedFile!.path));
    _currentImage = await (await ref).ref.getDownloadURL();

    // add user firebas information

    User? user =
        FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({
      'uid': user.uid,
      'image':_currentImage,
    });
  }

  final _formKey = GlobalKey<FormState>();

  String? _currentNickname;

  String? _currentfirstName;

  String? _currentlastName;

  String? _currentage;

  String? _currentheight;

  String? _currentweight;

  String? _currentdisease;

  String? _currentImage;

  TextEditingController _changeNameTextController = TextEditingController();

  // Future<void> _updateMyData(String newName) async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('myName',newName);
  //   setState(() {
  //     _currentNickname = newName;
  //   });
  //   MyProfileData newMyData = MyProfileData(
  //       myName: newName,
  //   );
  //   widget.updateMyData(newMyData);
  // }
  //
  // @override
  // void initState() {
  //   _currentNickname = widget.myData.myName;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
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
                    String? _firstName = _userData!.firstName;
                    String? _lastName = _userData.lastName;
                    String? _age = _userData.age;
                    String? _height = _userData.height;
                    String? _weight = _userData.weight;
                    String? _disease = _userData.disease;
                    String? _nickname=_userData.nickname;
                    String? _profil=_userData.image;
                    if(_profil==null){
                      _profil='https://coflex.com.tr/wp-content/uploads/2021/01/resim-yok.jpg';
                    }

                    return Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          // ImageProfile(context),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: getProportionateScreenHeight(160),
                                width: getProportionateScreenWidth(140),
                                margin: EdgeInsets.only(top: getProportionateScreenHeight(5)),
                                child: Stack(
                                  children: <Widget>[
                                    _image != null
                                        ? CircleAvatar(
                                      radius: getProportionateScreenWidth(80),
                                      backgroundImage: FileImage(_image!),
                                    )
                                        : CircleAvatar(
                                      radius: getProportionateScreenWidth(80),
                                      backgroundImage:
                                      NetworkImage(_profil),
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
                                            Icons.edit_outlined,
                                            color: Colors.grey,
                                            size: getProportionateScreenHeight(25),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          //user nickname
                          TextFormField(
                            onChanged: (val) {
                              setState(() => _currentNickname = val);
                              if (val.isEmpty) {
                                setState(() {
                                  _currentNickname = _nickname;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Kullanıcı ismi",
                              floatingLabelBehavior:
                              FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(20),
                              hintText:_userData.nickname,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.edit_outlined),
                                onPressed: () async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
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
                                    'image':_profil,
                                    'nickname':_currentNickname,
                                  });
                                },
                              ),
                            ),
                          ),

                          SizedBox(height: getProportionateScreenHeight(20)),
                          //firstName Form
                          TextFormField(
                            onChanged: (val) {
                              setState(() => _currentfirstName = val);
                              if (val.isEmpty) {
                                setState(() {
                                  _currentfirstName = _firstName;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "İsim",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(20),
                              hintText: _userData.firstName,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.edit_outlined),
                                onPressed: () async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user!.uid)
                                      .set({
                                    'uid': user.uid,
                                    'firstName': _currentfirstName,
                                    'lastName': _lastName,
                                    'age': _age,
                                    'height': _height,
                                    'weight': _weight,
                                    'disease': _disease,
                                    'image':_profil,
                                    'nickname':_nickname
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          //lastName Form
                          TextFormField(
                            onChanged: (val) {
                              setState(() => _currentlastName = val);
                              if (val.isEmpty) {
                                setState(() {
                                  _currentlastName = _lastName;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Soyisim",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(20),
                              hintText: _userData.lastName,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.edit_outlined),
                                onPressed: () async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user!.uid)
                                      .set({
                                    'uid': user.uid,
                                    'firstName': _firstName,
                                    'lastName': _currentlastName,
                                    'age': _age,
                                    'height': _height,
                                    'weight': _weight,
                                    'disease': _disease,
                                    'image':_profil,
                                    'nickname':_nickname,
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          // Age form
                          TextFormField(
                            onChanged: (val) {
                              setState(() => _currentage = val);
                              if (val.isEmpty) {
                                setState(() {
                                  _currentage = _age;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Yaş",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(20),
                              hintText: _userData.age,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.edit_outlined),
                                onPressed: () async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user!.uid)
                                      .set({
                                    'uid': user.uid,
                                    'firstName': _firstName,
                                    'lastName': _lastName,
                                    'age': _currentage,
                                    'height': _height,
                                    'weight': _weight,
                                    'disease': _disease,
                                    'image':_profil,
                                    'nickname':_nickname,
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          // height form
                          TextFormField(
                            onChanged: (val) {
                              setState(() => _currentheight = val);
                              if (val.isEmpty) {
                                setState(() {
                                  _currentheight = _height;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Boy",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(20),
                              hintText: _userData.height,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.edit_outlined),
                                onPressed: () async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user!.uid)
                                      .set({
                                    'uid': user.uid,
                                    'firstName': _firstName,
                                    'lastName': _lastName,
                                    'age': _age,
                                    'height': _currentheight,
                                    'weight': _weight,
                                    'disease': _disease,
                                    'image':_profil,
                                    'nickname':_nickname,
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          // weight form
                          TextFormField(
                            onChanged: (val) {
                              setState(() => _currentweight = val);
                              if (val.isEmpty) {
                                setState(() {
                                  _currentweight = _weight;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Kilo",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(20),
                              hintText: _userData.weight,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.edit_outlined),
                                onPressed: () async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user!.uid)
                                      .set({
                                    'uid': user.uid,
                                    'firstName': _firstName,
                                    'lastName': _lastName,
                                    'age': _age,
                                    'height': _height,
                                    'weight': _currentweight,
                                    'disease': _disease,
                                    'image':_profil,
                                    'nickname':_nickname,
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          //Disease form
                          TextFormField(
                            onChanged: (val) {
                              setState(() => _currentdisease = val);
                              if (val.isEmpty) {
                                setState(() {
                                  _currentdisease = _disease;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Hastalık",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: EdgeInsets.all(20),
                              hintText: _userData.disease,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.edit_outlined),
                                onPressed: () async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
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
                                    'disease': _currentdisease,
                                    'image':_profil,
                                    'nickname':_nickname,
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: getProportionateScreenHeight(50),
                          //       vertical: getProportionateScreenWidth(10)),
                          //   child: Button(
                          //     text: "Düzenle",
                          //     press: () async {
                          //       User? user = FirebaseAuth.instance.currentUser;
                          //       await FirebaseFirestore.instance
                          //           .collection('users')
                          //           .doc(user!.uid)
                          //           .set({
                          //         'uid': user.uid,
                          //         'firstName': _firstName,
                          //         'lastName': _lastName,
                          //         'age': _age,
                          //         'height': _height,
                          //         'weight': _weight,
                          //         'disease': _disease,
                          //       });
                          //     },
                          //   ),
                          // ),
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
        Container(
          height: getProportionateScreenHeight(160),
          width: getProportionateScreenWidth(140),
          margin: EdgeInsets.only(top: getProportionateScreenHeight(5)),
          child: Stack(
            children: <Widget>[
              _image != null
                  ? CircleAvatar(
                radius: getProportionateScreenWidth(80),
                backgroundImage: FileImage(_image!),
              )
                  : CircleAvatar(
                radius: getProportionateScreenWidth(80),
                backgroundImage:
                NetworkImage('${_currentImage}'),
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
                      Icons.edit_outlined,
                      color: Colors.grey,
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
