import 'package:fitterapi/main_page/cures/new_cure_screen.dart';
import 'package:fitterapi/main_page/teas/new_tea_screen.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../const.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ekleme yap',
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
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenHeight(40),
              right: getProportionateScreenHeight(10),
              top: getProportionateScreenHeight(30),
              //bottom: getProportionateScreenHeight(10),
            ),
            child: ClipRRect(
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Get.to(() => NewCureScreen());
                    },
                    child: Image.asset('assets/images/cure2.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenHeight(15),
                        vertical: getProportionateScreenWidth(10)),
                    child: Text.rich(
                      TextSpan(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getProportionateScreenWidth(7)),
                          children: [
                            TextSpan(
                              // değişkenleri string içinde yazabilmek için ($)
                              text: 'Yeni Kür Ekle',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenHeight(40),
              right: getProportionateScreenHeight(10),
              //top: getProportionateScreenHeight(10),
              bottom: getProportionateScreenHeight(20),
            ),
            child: ClipRRect(
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Get.to(() => NewTeaScreen());
                    },
                    child: Image.asset('assets/images/tea2.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenHeight(15),
                        vertical: getProportionateScreenWidth(10)),
                    child: Text.rich(
                      TextSpan(
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getProportionateScreenWidth(7)),
                          children: [
                            TextSpan(
                              // değişkenleri string içinde yazabilmek için ($)
                              text: 'Yeni Çay Ekle',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}

class cliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double ignoreHeight = 10;
    path.lineTo(0, size.height - ignoreHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - ignoreHeight);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}


class Tag extends StatelessWidget {
  final Color color;
  final String image;
  final String text;
  final Function press;

  Tag({
    required this.color,
    required this.image,
    required this.text,
    required this.press
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ()=>press,
      title: Padding(
        padding: EdgeInsets.only(top:getProportionateScreenHeight(15) ,left:getProportionateScreenWidth(20),right: getProportionateScreenWidth(20)),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(getProportionateScreenHeight(10)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenHeight(10)),
                  child: Column(
                    children: [
                      SizedBox(height: getProportionateScreenHeight(20)),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: getProportionateScreenHeight(30),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: getProportionateScreenHeight(20)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 110,
                  width: 110,
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ),
    );
  }
}
