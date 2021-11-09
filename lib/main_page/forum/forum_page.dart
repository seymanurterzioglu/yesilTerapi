import 'package:fitterapi/main_page/prepared/search.dart';
import 'package:flutter/material.dart';

class ForumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Search(),
          ],
        ),
      ),
    );
  }
}
