import 'package:fitterapi/sign_in/sign_in_screen.dart';
import 'package:fitterapi/sign_up/dart/sign_up_background.dart';
import 'package:fitterapi/size_config.dart';
import 'package:fitterapi/social_card.dart';
import 'package:flutter/material.dart';

import '../../const.dart';
import 'sign_up_form.dart';

class SignUpBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SignUpBackground(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(10)),
            child: Column(
              children: <Widget>[
                SizedBox(height: getProportionateScreenHeight(120)),
                Text(
                  "Kayıt Ol",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: getProportionateScreenWidth(30),
                  ),
                ),
                SignUpForm(),
                SizedBox(height: getProportionateScreenHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Çoktan kayıtlı mısınız? O zaman ",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                        );
                      },
                      child: Text(
                        "giriş yapalım:)",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                 //google-facebook - twitter ile kayıt olma
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SocialCArd(
                //       icon: "assets/icons/google.svg",
                //       press: () {},
                //     ),
                //     SocialCArd(
                //       icon: "assets/icons/facebook.svg",
                //       press: () {},
                //     ),
                //     SocialCArd(
                //       icon: "assets/icons/twitter.svg",
                //       press: () {},
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
