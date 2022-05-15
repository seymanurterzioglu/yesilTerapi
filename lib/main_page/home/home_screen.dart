import 'package:flutter/material.dart';
import '../prepared/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/login";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    //UserDatabase userDatabase = UserDatabase(uid: currentUser!.uid);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}
