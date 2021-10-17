import 'complete_profil_body.dart';
import 'package:flutter/material.dart';

class CompleteProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Tamamlama"),
      ),
      body: CompleteProfileBody(),
    );
  }
}
