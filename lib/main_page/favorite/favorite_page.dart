import 'package:fitterapi/main_page/favorite/categories.dart';
import 'package:flutter/material.dart';


class FavoritePage extends StatelessWidget {
  Categories _categories=Categories();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Categories(),
        ],
      ),
    );
  }
}
