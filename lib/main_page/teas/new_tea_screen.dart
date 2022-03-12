import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitterapi/button.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/error.dart';
import 'package:fitterapi/services/teas_database.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class NewTeaScreen extends StatefulWidget {
  @override
  _NewTeaScreenState createState() => _NewTeaScreenState();
}

class _NewTeaScreenState extends State<NewTeaScreen> {
  File? _image;
  String? _teaName;
  String? _info;
  String? _useful;
  String? _recipe;
  String? _warning;

  String _pickImage='https://coflex.com.tr/wp-content/uploads/2021/01/resim-yok.jpg';
  int _selectedIndex = 0;
  Color? color;

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  final FirebaseStorage storage = FirebaseStorage.instance;
  TeasDatabase teasDatabase = TeasDatabase();

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
        .ref('teasPhoto/${pickedFile!.name}')
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
          "Çay Ekle",
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
                // image
                Padding(
                  padding: EdgeInsets.only(
                      right: getProportionateScreenWidth(20),
                      left: getProportionateScreenHeight(20)),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Dilerseniz çay için resim ekleyebilirsiniz',
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
                //  Çay teaName
                Padding(
                  padding: EdgeInsets.only(
                      right: getProportionateScreenWidth(13),
                      left: getProportionateScreenHeight(13)),
                  child: TextFormField(
                    onSaved: (newValue) => _teaName = newValue,
                    onChanged: (value) {
                      setState(() => _teaName = value);
                      if (value.isNotEmpty) {
                        removeError(error: 'Çayın ismini giriniz');
                      }
                      return null;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        addError(error: 'Çayın ismini giriniz');
                        return "";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Çay\'ın ismi nedir?',
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

                // option - pregnany-stomach-sleep
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customRadio('Hamilelik', 0, pregnancyColor),
                      customRadio('Mide', 1, stomachColor),
                      customRadio('Uyku', 2, sleepColor),
                    ],
                  ),
                ),

                SizedBox(height: getProportionateScreenHeight(15)),
                //  Çay info
                Padding(
                  padding: EdgeInsets.only(
                      right: getProportionateScreenWidth(13),
                      left: getProportionateScreenHeight(13)),
                  child: TextFormField(
                    onSaved: (newValue) => _info = newValue,
                    onChanged: (value) {
                      setState(() => _info = value);
                      if (value.isNotEmpty) {
                        removeError(error: 'Çay nelere iyi geldiğini yazınız');
                      }
                      return null;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        addError(error: 'Çay nelere iyi geldiğini yazınız');
                        return "";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Çay nelere iyi gelir?',
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
                //  recipe
                Padding(
                  padding: EdgeInsets.only(
                      right: getProportionateScreenWidth(13),
                      left: getProportionateScreenHeight(13)),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    onSaved: (newValue) => _recipe = newValue,
                    onChanged: (value) {
                      setState(() => _recipe = value);

                      if (value.isNotEmpty) {
                        removeError(error: 'Çay\'ın tarifini giriniz');
                      }
                      return null;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        addError(error: 'Çay\'ın tarifini giriniz');
                        return "";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Çay\'ın tarifi nedir?',
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
                // Çay warning
                Padding(
                  padding: EdgeInsets.only(
                      right: getProportionateScreenWidth(13),
                      left: getProportionateScreenHeight(13)),
                  child: TextFormField(
                    onSaved: (newValue) => _warning = newValue,
                    onChanged: (value) {
                      setState(() => _warning = value);
                      if (value.isNotEmpty) {
                        removeError(error: 'Çay içen neye dikkat etmelidir');
                      }
                      return null;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        addError(error: 'Çay içen neye dikkat etmelidir');
                        return "";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.all(20),
                      hintText: 'Çay içen neye dikkat etmelidir?',
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
                //  errors
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                // buton ekle
                Padding(
                  padding: EdgeInsets.only(
                      right: getProportionateScreenWidth(30),
                      left: getProportionateScreenHeight(30)),
                  child: Button(
                    text: 'Ekle',
                    press: () async {
                      if (_formKey.currentState!.validate()) {
                        teasDatabase
                            .addTea(_teaName!, _useful, _info, _warning!,
                                _recipe!, _pickImage)
                            .then((value) {
                          Fluttertoast.showToast(
                              msg: "Durum eklendi!",
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
                        Navigator.pop(context); // geri dön
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

  void changeIndex(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        setState(() {
          _useful = 'Hamilelik';
        });
      } else if (_selectedIndex == 1) {
        setState(() {
          _useful = 'Mide';
        });
      } else if (_selectedIndex == 2) {
        setState(() {
          _useful = 'Uyku';
        });
      }
    });
  }

  Widget customRadio(String txt, int index, Color color) {
    return OutlinedButton(
      onPressed: () => changeIndex(index),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
        side: BorderSide(color: _selectedIndex == index ? color : Colors.grey),
      ),
      child: Text(
        txt,
        style: TextStyle(color: _selectedIndex == index ? color : Colors.grey),
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
              _image != null // _image=File(PickedImage.path)
                  ? CircleAvatar(
                      radius: getProportionateScreenWidth(80),
                      backgroundImage: FileImage(_image!),
                    )
                  : CircleAvatar(
                      radius: getProportionateScreenWidth(80),
                      backgroundImage: NetworkImage('https://coflex.com.tr/wp-content/uploads/2021/01/resim-yok.jpg'),
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
