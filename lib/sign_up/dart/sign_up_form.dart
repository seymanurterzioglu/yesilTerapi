import 'package:fitterapi/complete_profile/complete_profile_screen.dart';
import 'package:flutter/material.dart';

import '../../button.dart';
import '../../const.dart';
import '../../error.dart';
import '../../size_config.dart';


class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;
  final List<String> errors = [];

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
        border: InputBorder.none,
        hintText: "Şifrenizi yeniden Giriniz.",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 2,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 2,
        ),
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
        border: InputBorder.none,
        hintText: "Şifrenizi Giriniz.",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 2,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 2,
        ),
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
        border: InputBorder.none,
        hintText: "Emailinizi Giriniz.",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 2,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.black45),
          gapPadding: 2,
        ),
      ),
    );
  }
}
