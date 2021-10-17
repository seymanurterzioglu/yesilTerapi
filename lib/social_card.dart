import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialCArd extends StatelessWidget {
  const SocialCArd({
    Key? key,
    this.icon,
    this.press,
  }) : super(key: key);
  final String? icon;  // can be null
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
        padding: EdgeInsets.all(getProportionateScreenWidth(5)),
        height: getProportionateScreenHeight(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
          color: Colors.white60,
          shape: BoxShape.rectangle,
        ),
        child: SvgPicture.asset(icon!),
      ),
    );
  }
}
