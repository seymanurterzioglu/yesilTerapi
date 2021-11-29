import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/main_page/prepared/search.dart';
import 'package:flutter/material.dart';
import 'package:fitterapi/services/auth.dart';

class ForumPage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Search(),
            // ElevatedButton(onPressed: (){
            //   _auth.signOut();
            // }, child: Text('Çıkış'))
          ],
        ),
      ),
    );
  }
}
