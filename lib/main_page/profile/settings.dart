import 'package:fitterapi/const.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsProfile extends StatefulWidget {
  @override
  _SettingsProfileState createState() => _SettingsProfileState();
}

class _SettingsProfileState extends State<SettingsProfile> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;

  onChangeFunction1(bool newValue1) {
    setState(() {
      valNotify1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      valNotify2 = newValue2;
    });
  }

  onChangeFunction3(bool newValue3) {
    setState(() {
      valNotify3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ayarlar',
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
      body: Container(
        padding: EdgeInsets.all(getProportionateScreenHeight(10)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: getProportionateScreenHeight(60)),
            Row(
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                SizedBox(width: getProportionateScreenWidth(10)),
                Text(
                  'Hesap',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(height: getProportionateScreenHeight(25), thickness: 2),
            SizedBox(height: getProportionateScreenHeight(10)),
            buildAccountOption(context, 'Şifre Değiştirme'),
            buildAccountOption(context, 'Şifre Değiştirme'),
            buildAccountOption(context, 'Şifre Değiştirme'),
            SizedBox(height: getProportionateScreenHeight(40)),
            Row(
              children: <Widget>[
                Icon(
                  Icons.volume_up,
                  color: Colors.black,
                ),
                SizedBox(width: getProportionateScreenWidth(10)),
                Text(
                  'Bildirimler',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(height: getProportionateScreenHeight(25), thickness: 2),
            SizedBox(height: getProportionateScreenHeight(15)),
            buildNotificationOption('Tema', valNotify1, onChangeFunction1),
            buildNotificationOption('Tema', valNotify2, onChangeFunction2),
            buildNotificationOption('Tema', valNotify3, onChangeFunction3),
          ],
        ),
      ),
    );
  }

  Padding buildNotificationOption(
      String title, bool value, Function onchangedMethod) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenHeight(20),
          vertical: getProportionateScreenWidth(1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black38,
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: kPrimaryColor,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onchangedMethod(newValue);
              },
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Seçenek1'),
                    Text('Seçenek2'),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Kapat'))
                ],
              );
            });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(25),
            vertical: getProportionateScreenWidth(9)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black38,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}
