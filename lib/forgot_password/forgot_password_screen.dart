import 'package:flutter/material.dart';

import 'forgot_password_body.dart';



class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Şifremi Unuttum",
        ),
      ),
      body: ForgotPasswordBody(),
    );
  }
}
