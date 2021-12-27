import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/prepared/best_cards.dart';
import 'package:fitterapi/main_page/teas/sleep/sleep_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';


class TeasSleepPage extends StatefulWidget {
  @override
  _TeasSleepPageState createState() => _TeasSleepPageState();
}

class _TeasSleepPageState extends State<TeasSleepPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   iconTheme: IconThemeData(color: Colors.black),
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     'Hamilelik',
      //     style: TextStyle(
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          // Title
          Container(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenWidth(20),
                horizontal: getProportionateScreenHeight(20)
            ),
            decoration: BoxDecoration(
              color: sleepColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenWidth(10),
                  horizontal: getProportionateScreenHeight(15)
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: ()=>Navigator.pop(context),
                    icon: Icon(Icons.keyboard_return),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Uyku',
                        style: TextStyle(
                          decorationThickness: 2.5,
                          fontSize: getProportionateScreenHeight(40),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: getProportionateScreenWidth(1)),
                  Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(7)),
                    height: getProportionateScreenHeight(45),
                    width: getProportionateScreenWidth(45),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset("assets/icons/bell5.svg"),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(18),
              vertical: getProportionateScreenWidth(2),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Title(
                    text: 'Önerilenler',
                    press: () {},
                  ),
                  SizedBox(height: getProportionateScreenHeight(8)),
                  // sık incelenenler yana doğru kaydırmalı
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BestCards(
                          name: 'Melisa',
                          image:
                          'https://www.kadinonline.net/wp-content/uploads/2021/05/melisa-cayi-2.jpg',
                        ),
                        BestCards(
                          name: 'Lavanta',
                          image:
                          'https://www.aysetolga.com/wp-content/uploads/2018/02/lavanta-cayi-3.jpg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          SleepList(),
        ],
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
