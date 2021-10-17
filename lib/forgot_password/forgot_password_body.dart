import 'package:fitterapi/button.dart';
import 'package:fitterapi/login/login_screen.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';

import 'forgot_password_background.dart';
import '../error.dart';
import '../const.dart';

class ForgotPasswordBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ForgotPasswordBackground(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(200)),
              Text(
                "Şifremi Unuttum",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(32),
                  color: Colors.black45,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                "Lütfen kayıt olduğunuz email adresinizi \ngiriniz.Şifre sıfırlamak için size mesaj \ngöndereceğiz.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              ForgotPassForm(),
              SizedBox(height: getProportionateScreenHeight(15)),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.all(20),
              border: InputBorder.none,
              hintText: "Lütfen Emailinizi giriniz",
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
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          Button(
            text: "Gönder",
            press: () {

              //burada hatalar çıksada loginsayfasına gidiyor
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // eğer her şey doğruysa giriş ekranına git
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
