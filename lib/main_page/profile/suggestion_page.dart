import 'package:fitterapi/main_page/profile/const/suggestion_background.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';

import '../../button.dart';

class SuggestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Öneri Yaz",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SuggestionBackground(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenHeight(25)),
              child: Column(
                children: <Widget>[
                  SizedBox(height: getProportionateScreenHeight(210)),
                  TextFormField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenHeight(15),
                        vertical: getProportionateScreenWidth(10),
                      ),
                      border: InputBorder.none,
                      hintText:
                          'Bize yardımcı olmak için, uygulama ile ilgili önerilerinizi yazabilirsiniz',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                        gapPadding: 10,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                        gapPadding: 10,
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(40)),
                  Button(
                    text: "Gönder",
                    press: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
