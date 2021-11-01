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
  String? discomfort; // rahatsızlık

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
          buildDiscomfortFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          //Error kısımları
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(10)),
          Button(
            text: "İleri",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // eğer her şey doğruysa giriş ekranına git
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                //Gideceği sayfa daha yapılmadı
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen()),
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
          keyboardType: TextInputType.emailAddress,
          onSaved: (newValue) => firstName = newValue,
          onChanged: (value) {
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
            border: InputBorder.none,
            hintText: "İsminizi Giriniz.",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: Colors.black45),
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: Colors.black45),
              gapPadding: 10,
            ),
          ),
        );
  }

      //Lastname Form
  TextFormField buildLastNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
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
        border: InputBorder.none,
        hintText: "Soyisminizi Giriniz.",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,
        ),
      ),
    );
  }

      // Age form
  TextFormField buildAgeFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => age = newValue,
      onChanged: (value) {
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
        border: InputBorder.none,
        hintText: "Yaşınızı Giriniz.",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,
        ),
      ),
    );
  }

     // height form
  TextFormField buildHeightFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => height = newValue,
      onChanged: (value) {
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
        border: InputBorder.none,
        hintText: "Boyunuzu Giriniz.",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,
        ),
      ),
    );
  }

  // weight form
  TextFormField buildWeightFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => height = newValue,
      onChanged: (value) {
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
        border: InputBorder.none,
        hintText: "Kilonuzu Giriniz.",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,
        ),
      ),
    );
  }

     //Disease form
  TextFormField buildDiseaseFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => disease = newValue,
      onChanged: (value) {
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
        border: InputBorder.none,
        hintText: "Hastalığınızı Giriniz.",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,
        ),
      ),
    );
  }

    //Discomfort form
  TextFormField buildDiscomfortFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => discomfort = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kDiscomfortNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kDiscomfortNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Son Zamanlardaki Rahatsızlık",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        border: InputBorder.none,
        hintText: "Rahatsızlığınızı Giriniz.",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 10,   // bunu ne işe yaradığına bak
        ),
      ),
    );
  }
}



