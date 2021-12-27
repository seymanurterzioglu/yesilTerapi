import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/prepared/search.dart';
import 'sleep/teas_sleep_page.dart';
import 'pregnancy/teas_pregnancy_page.dart';
import 'stomach/teas_stomach_page.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Search(),
            //sık incelenenler
            ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeasPregnancyList()),
                  //MaterialPageRoute(builder: (context) => ProfileEdit()),
                );
              },
              title: Tag(
                color: pregnancyColor,
                image: 'https://i4.hurimg.com/i/hurriyet/75/750x422/5efd155a45d2a04258b7634e.jpg',
                text: 'Hamilelik',
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeasStomachPage()),
                  //MaterialPageRoute(builder: (context) => ProfileEdit()),
                );
              },
              title: Tag(
                  color: stomachColor,
                  image: 'https://static.daktilo.com/sites/449/uploads/2021/04/01/large/mide-agrisi.jpg',
                  text: 'Mide',
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeasSleepPage()),
                  //MaterialPageRoute(builder: (context) => ProfileEdit()),
                );
              },
              title: Tag(
                color: sleepColor,
                image: 'https://i.tmgrup.com.tr/gq/original/15-08/23/uykusuzhergece_0_0.jpg',
                text: 'Uyku',
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: getProportionateScreenHeight(18),
            //     vertical: getProportionateScreenWidth(2),
            //   ),
            //   child: Column(
            //     children: <Widget>[
            //       SizedBox(height: getProportionateScreenHeight(10)),
            //       Title(
            //         text: 'Sık İncelenenler',
            //         press: () {},
            //       ),
            //       SizedBox(height: getProportionateScreenHeight(10)),
            //       // sık incelenenler yana doğru kaydırmalı
            //       SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: Row(
            //           children: [
            //             BestCards(
            //               name: 'Papatya',
            //               image: 'assets/images/papatya.jpg',
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final Color color;
  final String image;
  final String text;

  Tag({
    required this.color,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
//
// class Title extends StatelessWidget {
//   final String? text;
//   final GestureTapCallback? press;
//
//   const Title({
//     Key? key,
//     this.text,
//     this.press,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Text(
//             text!,
//             style: TextStyle(
//               fontSize: getProportionateScreenWidth(18),
//               color: Colors.black,
//             ),
//           ),
//           GestureDetector(
//             child: Text('Daha Fazla'),
//             onTap: press,
//           ),
//         ],
//       ),
//     );
//   }
// }
