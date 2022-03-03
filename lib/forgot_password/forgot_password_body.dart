import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'forgot_password_background.dart';
import '../error.dart';
import '../const.dart';

class ForgotPasswordBody extends StatefulWidget {
  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ForgotPasswordBackground(
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Geçerli e-posta giriniz'
                              : null,
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
                    SizedBox(height: getProportionateScreenHeight(10)),
                    SizedBox(
                      width: getProportionateScreenWidth(230),
                      height: getProportionateScreenHeight(65),
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          label: Text(
                            'Şifreyi Sıfırla',
                            style: TextStyle(
                                fontSize: getProportionateScreenHeight(25)),
                          ),
                          icon: Icon(Icons.mark_email_read),
                          onPressed: () => {
                                resetPassword()
                              }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      duration: Duration(seconds:2),
      content: Text(message),
      action: SnackBarAction(
        label: 'X',
        onPressed: (){
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
        showSnackBar(context, 'Eposta gönderildi');
        Navigator.of(context).popUntil((route) => route.isFirst);

    } on FirebaseAuthException catch (e) {
      print(e);
      showSnackBar(context, 'Eposta gönderimi başarısız oldu');
      Navigator.of(context).pop();
    }
  }
}
