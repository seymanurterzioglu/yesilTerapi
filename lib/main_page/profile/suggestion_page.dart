import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/main_page/profile/const/suggestion_background.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import '../../button.dart';
import '../../const.dart';

class SuggestionPage extends StatefulWidget {
  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  final _formKey = GlobalKey<FormState>();
  String? suggestion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Öneri',
          style: TextStyle(
              fontSize: getProportionateScreenHeight(25),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: getProportionateScreenHeight(95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: SuggestionBackground(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenHeight(25)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: getProportionateScreenHeight(210)),
                    TextFormField(
                      onSaved: (newValue) => suggestion = newValue,
                      onChanged: (value) {
                        setState(() => suggestion = value);
                        return null;
                      },
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
                      press: () async {
                        if (_formKey.currentState!.validate()) {
                          await FirebaseFirestore.instance
                              .collection('suggestion')
                              .add({
                            'suggestion': suggestion,
                          });
                          _formKey.currentState!.save();
                          // eğer her şey doğruysa giriş ekranına git
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
