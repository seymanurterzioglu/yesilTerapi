import 'package:fitterapi/sign_in/sign_in_body.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Giriş",
        ),
      ),
      body: SignInBody(),
    );
  }
}
