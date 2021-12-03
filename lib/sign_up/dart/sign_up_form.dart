import 'package:fitterapi/complete_profile/complete_profile_screen.dart';
import 'package:fitterapi/services/auth.dart';
import 'package:flutter/material.dart';

import '../../button.dart';
import '../../const.dart';
import '../../error.dart';
import '../../size_config.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;
  String? error;
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  final List<String> errors = [];

  final AuthService _auth = AuthService();

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
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: getProportionateScreenHeight(50)),
            // Email kısmı
            buildEmailForm(),
            SizedBox(height: getProportionateScreenHeight(15)),
            //Şifre kısmı
            buildPasswordForm(),
            SizedBox(height: getProportionateScreenHeight(15)),
            //Tekrar-Şifre kısmı
            buildConfirmPasswordForm(),
            SizedBox(height: getProportionateScreenHeight(15)),
            //Error kısımları
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(10)),
            Button(
              text: "İleri",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  dynamic result =
                      await _auth.signUpWithEmailPassword(email!, password!);
                  // User? user = FirebaseAuth.instance.currentUser;
                  // //AuthService use=AuthService();
                  // // I will look at here later
                  // await FirebaseFirestore.instance
                  //     .collection('users')
                  //     .doc(user!.uid)
                  //     .set({
                  //   'uid':user.uid,
                  //   'email':email,
                  //   'password':password,
                  // });
                  // //use.sendNowUID(user.uid);
                  if (result == null) {
                    setState(() => error = 'Lütfen var olan bir email giriniz');
                  }
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
                        builder: (context) => CompleteProfileScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildConfirmPasswordForm() {
    return TextFormField(
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        setState(() => confirmPassword = value);
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirmPassword) {
          removeError(error: kMatchPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (password != confirmPassword) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Yeniden Şifre",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        hintText: "Şifrenizi yeniden Giriniz.",
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(28),
        //   borderSide: BorderSide(color: Colors.black45),
        //   gapPadding: 2,
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(28),
        //   borderSide: BorderSide(color: Colors.black45),
        //   gapPadding: 2,
        // ),
        suffixIcon: IconButton(
          icon: isConfirmPasswordVisible
              ? Icon(
                  Icons.visibility,
                  color: Colors.black45,
                )
              : Icon(Icons.visibility),
          onPressed: () => setState(
              () => isConfirmPasswordVisible = !isConfirmPasswordVisible),
        ),
      ),
      obscureText: isConfirmPasswordVisible,
      obscuringCharacter: "*",
    );
  }

  TextFormField buildPasswordForm() {
    return TextFormField(
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        setState(() => password = value);
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Şifre",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        hintText: "Şifrenizi Giriniz.",
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(28),
        //   borderSide: BorderSide(color: Colors.black45),
        //   gapPadding: 2,
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(28),
        //   borderSide: BorderSide(color: Colors.black45),
        //   gapPadding: 2,
        // ),
        suffixIcon: IconButton(
          icon: isPasswordVisible
              ? Icon(
                  Icons.visibility,
                  color: Colors.black45,
                )
              : Icon(Icons.visibility),
          onPressed: () =>
              setState(() => isPasswordVisible = !isPasswordVisible),
        ),
      ),
      obscureText: isPasswordVisible,
      obscuringCharacter: "*",
    );
  }

  TextFormField buildEmailForm() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        setState(() => email = value);
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        hintText: "Emailinizi Giriniz.",
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(28),
        //   borderSide: BorderSide(color: Colors.black45),
        //   gapPadding: 2,
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(28),
        //   borderSide: BorderSide(color: Colors.black45),
        //   gapPadding: 2,
        // ),
      ),
    );
  }
}
