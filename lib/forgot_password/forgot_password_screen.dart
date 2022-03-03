import 'package:flutter/material.dart';

import 'forgot_password_body.dart';



class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        elevation: 0,
        title: Text(
          "Şifremi Unuttum",
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: ForgotPasswordBody(),
    );
  }
}
