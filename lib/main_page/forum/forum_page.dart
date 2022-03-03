import 'package:fitterapi/main_page/forum/forum_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ForumPage extends StatefulWidget {
  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ForumMain(),
    );
  }
}
