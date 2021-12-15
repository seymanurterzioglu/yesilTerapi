import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/main_page/home/home_screen.dart';

import '../main_page/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../button.dart';
import '../const.dart';
import '../error.dart';
import '../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String? firstName;

  // late modifier anlamı: ben daha sonra bu değişkene bir şey tamamlayacağım demekmiş
  String? lastName;
  String? age;
  String? height;
  String? weight;
  String? disease; // hastalık

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: getProportionateScreenHeight(10)),
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildAgeFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildHeightFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildWeightFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildDiseaseFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          //Error kısımları
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(10)),
          Button(
            text: "İleri",
            press: () async {
              if (_formKey.currentState!.validate()) {
                User? user = FirebaseAuth.instance.currentUser;
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid)
                    .set({
                  'uid':user.uid,
                  'firstName': firstName,
                  'lastName': lastName,
                  'age': age,
                  'height': height,
                  'weight': weight,
                  'disease': disease,
                });
                _formKey.currentState!.save();
                // eğer her şey doğruysa giriş ekranına git
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                //Gideceği sayfa daha yapılmadı
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }

  // Firstname form
  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        setState(() => firstName = value);
        if (value.isNotEmpty) {
          removeError(error: kFirstNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kFirstNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "İsim",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        hintText: "İsminizi Giriniz.",
      ),
    );
  }

  //Lastname Form
  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
        setState(() => lastName = value);
        if (value.isNotEmpty) {
          removeError(error: kLastNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kLastNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Soyisim",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        hintText: "Soyisminizi Giriniz.",
      ),
    );
  }

  // Age form
  TextFormField buildAgeFormField() {
    return TextFormField(
      onSaved: (newValue) => age = newValue,
      onChanged: (value) {
        setState(() => age = value);
        if (value.isNotEmpty) {
          removeError(error: kAgeNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAgeNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Yaş",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        hintText: "Yaşınızı Giriniz.",
      ),
    );
  }

  // height form
  TextFormField buildHeightFormField() {
    return TextFormField(
      onSaved: (newValue) => height = newValue,
      onChanged: (value) {
        setState(() => height = value);
        if (value.isNotEmpty) {
          removeError(error: kHeightNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kHeightNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Boy",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        hintText: "Boyunuzu Giriniz.",
      ),
    );
  }

  // weight form
  TextFormField buildWeightFormField() {
    return TextFormField(
      onSaved: (newValue) => weight = newValue,
      onChanged: (value) {
        setState(() => weight = value);
        if (value.isNotEmpty) {
          removeError(error: kWeightNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kWeightNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Kilo",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        hintText: "Kilonuzu Giriniz.",
      ),
    );
  }

  //Disease form
  TextFormField buildDiseaseFormField() {
    return TextFormField(
      onSaved: (newValue) => disease = newValue,
      onChanged: (value) {
        setState(() => disease = value);
        if (value.isNotEmpty) {
          removeError(error: kDiseaseNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kDiseaseNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Hastalık",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        hintText: "Hastalığınızı Giriniz.",
      ),
    );
  }
}
