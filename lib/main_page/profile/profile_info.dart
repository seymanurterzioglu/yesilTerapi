import 'package:fitterapi/button.dart';
import 'package:fitterapi/main_page/profile/profile_edit.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Profil ",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(50),
              vertical: getProportionateScreenWidth(40)),
          child: Column(
            children: [
              //Burada Bilgiler ve resim falan gözükücek(aynı zamanda resim ekleem işini de hallet)
              SizedBox(height: getProportionateScreenHeight(20)),
              Button(
                text: 'Profili Düzenle',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileEdit()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
