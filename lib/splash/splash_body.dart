import 'package:fitterapi/button.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/sign_in/sign_in_screen.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';


class SplashBody extends StatefulWidget {
  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Yeşil Terapi'ye Hoşgeldiniz!",
      "image": "assets/images/alternatif.jpg",
    },
    {
      "text":
      "Memleketimizde büyüyen doğal \nilaçları öğrenelim ve iyileşelim.",
      "image": "assets/images/papatya.jpg",
    },
    {
      "text":
      "Bildiklerimizi birbirimizle paylaşalım. \nKürler, bitki çayları ve seminerlerle \nbilgilerimizi genişletelim.",
      "image": "assets/images/bitki.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) =>
                    SplashContent(
                      text: splashData[index]["text"],
                      image: splashData[index]["image"],
                    ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                            (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(),
                    Button(
                      text: "İleri",
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)
                        =>
                            SignInScreen()),
                        );
                        // Navigator.pushNamed(context, SignInScreen.routeName);
                      },

                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}


class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 25),
        Text(
          'YEŞİL TERAPİ',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(40),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: getProportionateScreenWidth(15)),
        ),
        SizedBox(height: 40),
        Image.asset(
          image!,
          height: getProportionateScreenHeight(300),
          width: getProportionateScreenWidth(300),
        ),
      ],
    );
  }
}
