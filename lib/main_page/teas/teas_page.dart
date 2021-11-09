import 'package:fitterapi/main_page/prepared/best_cards.dart';
import 'package:fitterapi/main_page/prepared/search.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';

class TeaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Search(),
            //sık incelenenler
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(18),
                vertical: getProportionateScreenWidth(2),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Title(
                    text: 'Sık İncelenenler',
                    press: () {},
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  // sık incelenenler yana doğru kaydırmalı
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BestCards(
                          name: 'Papatya',
                          image: 'assets/images/papatya.jpg',
                          press: () {},
                        ),
                        BestCards(
                          name: 'Papatya',
                          image: 'assets/images/papatya.jpg',
                          press: () {},
                        ),
                        BestCards(
                          name: 'Papatya',
                          image: 'assets/images/papatya.jpg',
                          press: () {},
                        ),
                        BestCards(
                          name: 'Papatya',
                          image: 'assets/images/papatya.jpg',
                          press: () {},
                        ),
                        BestCards(
                          name: 'Papatya',
                          image: 'assets/images/papatya.jpg',
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //uyku
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(18),
                vertical: getProportionateScreenWidth(2),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Title(
                    text: 'Uyku',
                    press: () {},
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BestCards(
                          name: 'Papatya',
                          image: 'assets/images/papatya.jpg',
                          press: () {},
                        ),
                        BestCards(
                          name: 'Papatya',
                          image: 'assets/images/papatya.jpg',
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //mide
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(18),
                vertical: getProportionateScreenWidth(2),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Title(
                    text: 'Mide',
                    press: () {},
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  // sık incelenenler yana doğru kaydırmalı
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BestCards(
                          name: 'Papatya',
                          image: 'assets/images/papatya.jpg',
                          press: () {},
                        ),
                        BestCards(
                          name: 'Papatya',
                          image: 'assets/images/papatya.jpg',
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //metabolizma
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(18),
                vertical: getProportionateScreenWidth(2),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Title(
                    text: 'Metabolizma',
                    press: () {},
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  // sık incelenenler yana doğru kaydırmalı
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BestCards(
                          name: 'Papatya',
                          image: 'assets/images/papatya.jpg',
                          press: () {},
                        ),
                        BestCards(
                          name: 'Papatya',
                          image: 'assets/images/papatya.jpg',
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String? text;
  final GestureTapCallback? press;

  const Title({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text!,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.black,
            ),
          ),
          GestureDetector(
            child: Text('Daha Fazla'),
            onTap: press,
          ),
        ],
      ),
    );
  }
}
