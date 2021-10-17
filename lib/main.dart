import 'package:fitterapi/theme.dart';

import 'splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitTerapi',
      theme: theme(),
      home: SplashScreen(),
    );
  }
}



/*

class MyHomePage extends StatelessWidget {
  var title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
*/
