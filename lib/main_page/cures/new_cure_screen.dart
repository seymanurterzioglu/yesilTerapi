import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitterapi/button.dart';
import 'package:fitterapi/error.dart';
import 'package:fitterapi/services/cures_database.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';

class NewCureScreen extends StatefulWidget {
  @override
  State<NewCureScreen> createState() => _NewCureScreenState();
}

class _NewCureScreenState extends State<NewCureScreen> {
  File? _image; //
  String? _curesName;
  String? _about;
  String? _recipe;
  String _pickImage=('https://coflex.com.tr/wp-content/uploads/2021/01/resim-yok.jpg');

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  final FirebaseStorage storage = FirebaseStorage.instance;
  CuresDatabase curesDatabase =CuresDatabase();

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void _getPhoto(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      _image = File(pickedFile!.path);
    });
    // burada hala sorun var
    UploadTask ref = storage
        .ref('curesPhoto/${pickedFile!.name}')
        .putFile(File(pickedFile.path));
    _pickImage = await (await ref).ref.getDownloadURL();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Kür Ekle",
          style: TextStyle(
            color: Colors.black38,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: getProportionateScreenWidth(20),
                      left: getProportionateScreenHeight(20)),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'İsterseniz kür için resim yükleyebilirsiniz',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ImageProfile(context),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                //  Kür ismi
                Padding(
                  padding: EdgeInsets.only(
                      right: getProportionateScreenWidth(13),
                      left: getProportionateScreenHeight(13)),
                  child: TextFormField(
                    onSaved: (newValue) => _curesName = newValue,
                    onChanged: (value) {
                      setState(() => _curesName = value);
                      if (value.isNotEmpty) {
                        removeError(error: 'Kür ismini giriniz');
                      }
                      return null;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        addError(error: 'Kür ismini giriniz');
                        return "";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Kür\'ün ismi nedir?',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                        gapPadding: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                // kür hangi rahatsızlıklar için kullanılmalıdır
                Padding(
                  padding: EdgeInsets.only(
                      right: getProportionateScreenWidth(13),
                      left: getProportionateScreenHeight(13)),
                  child: TextFormField(
                    onSaved: (newValue) => _about = newValue,
                    onChanged: (value) {
                      setState(() => _about = value);
                      if (value.isNotEmpty) {
                        removeError(
                            error:
                                'Kür\'ün faydalı olduğu rahatsızlıkları giriniz');
                      }
                      return null;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        addError(
                            error:
                                'Kür\'ün faydalı olduğu rahatsızlıkları giriniz');
                        return "";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Kür hangi rahatsızlıklar için faydalıdır?',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                        gapPadding: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Padding(
                  padding: EdgeInsets.only(
                      right: getProportionateScreenWidth(13),
                      left: getProportionateScreenHeight(13)),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    maxLines: 8,
                    onSaved: (newValue) => _recipe = newValue,
                    onChanged: (value) {
                      setState(() => _recipe = value);

                      if (value.isNotEmpty) {
                        removeError(error: 'Kür\'ün tarifini giriniz');
                      }
                      return null;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        addError(error: 'Kür\'ün tarifini giriniz');
                        return "";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Kür\'ün tarifi nedir?',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                        gapPadding: 10,
                      ),
                    ),
                  ),
                ),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                Padding(
                  padding: EdgeInsets.only(
                      right: getProportionateScreenWidth(30),
                      left: getProportionateScreenHeight(30)),
                  child: Button(
                    text: 'Ekle',
                    press: () async {
                      if (_formKey.currentState!.validate()) {
                        curesDatabase.addCure(_curesName!,_about!,_recipe!,_pickImage)
                        .then((value) {
                          Fluttertoast.showToast(
                              msg: "Kür eklendi!",
                              timeInSecForIosWeb: 2,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.grey[600],
                              textColor: Colors.white,
                              fontSize: 14);
                        });

                        _formKey.currentState!.save();
                        // eğer her şey doğruysa giriş ekranına git
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        //Gideceği sayfa daha yapılmadı
                        Navigator.pop(context);  // geri dön
                      }
                    },
                  ),
                ),
              ],
            ),
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
              _image != null  // _image=File(PickedImage.path)
                  ? CircleAvatar(
                      radius: getProportionateScreenWidth(80),
                      backgroundImage: FileImage(_image!),
                    )
                  : CircleAvatar(
                      radius: getProportionateScreenWidth(80),
                      backgroundImage:
                      NetworkImage('https://coflex.com.tr/wp-content/uploads/2021/01/resim-yok.jpg'),
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
