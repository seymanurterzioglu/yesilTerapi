import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitterapi/main_page/home/home_screen.dart';
import 'package:fitterapi/sign_in/sign_in_body.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   title: Text(
      //     "Giriş",
      //     style: TextStyle(
      //       color: Colors.black12,
      //     ),
      //   ),
      // ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Text('Birşeyler Ters Gitti.Tekrar Deneyiniz'));
          }else if(snapshot.hasData){
            return HomeScreen();
          }else{
            return SignInBody();
          }
        },
      ),
    );
  }
}
