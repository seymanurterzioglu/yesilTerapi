import 'package:flutter/material.dart';
import '../prepared/bottom_nav_bar.dart';


class HomeScreen extends StatelessWidget {
  static String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      //backgroundColor: kPrimaryColor,
      home: BottomNavBar(),
      // body: CustomScrollView(
      //   slivers: <Widget>[
      //     SliverAppBar(
      //           // back butonunu kaldırır /aynı zamada sidebarıda kaldırıyor
      //       //automaticallyImplyLeading: false,
      //       //backgroundColor: kPrimaryColor,
      //       floating: true,
      //       // sayfa aşağılara ininca slidebar yukarıda kalır
      //       expandedHeight: getProportionateScreenHeight(200),
      //       title: Text("Yeşil Terapi"),
      //       titleTextStyle: TextStyle(
      //           color: Colors.white, fontSize: getProportionateScreenWidth(30)),
      //       flexibleSpace: FlexibleSpaceBar(
      //         background: Image.asset(
      //           "assets/images/back5.jpg",   //back4 ya da back5
      //           fit: BoxFit.fill,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
