import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';

class ForgotPasswordBackground extends StatelessWidget {
  final Widget child;

  const ForgotPasswordBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 10,
              left: 2,
              child: Image.asset(
                "assets/images/g2.png",
                width: getProportionateScreenWidth(370),
              )),
          child,
        ],
      ),
    );
  }
}
