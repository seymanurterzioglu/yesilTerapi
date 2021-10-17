import 'package:flutter/material.dart';

import '../../size_config.dart';

class SignUpBackground extends StatelessWidget {
  final Widget child;

  const SignUpBackground({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: 5,
              left: 10,
              child: Image.asset(
                "assets/images/ivy.png",
                width: getProportionateScreenWidth(250),
              )),
          child,
        ],
      ),
    );
  }
}
