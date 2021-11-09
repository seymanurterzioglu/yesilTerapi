import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../const.dart';
import '../../size_config.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(20),
          horizontal: getProportionateScreenHeight(20)
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(10),
            horizontal: getProportionateScreenHeight(20)
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: getProportionateScreenWidth(230),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                onChanged: (value) {
                  // search value si değiştiğinde..
                },
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "Sen sor biz arayalım",
                  hintStyle: TextStyle(color: Colors.black38),
                  prefixIcon: Icon(
                    Icons.search_sharp,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenHeight(20),
                    vertical: getProportionateScreenWidth(15),
                  ),
                ),
                style: TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(10)),
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
    );
  }
}
