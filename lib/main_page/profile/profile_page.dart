import 'package:fitterapi/const.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: getProportionateScreenHeight(60)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: getProportionateScreenWidth(10)),
              Container(
                height: getProportionateScreenHeight(170),
                width: getProportionateScreenWidth(130),
                margin: EdgeInsets.only(top: getProportionateScreenHeight(10)),
                child: Stack(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/images/back4.jpg'),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: getProportionateScreenHeight(40),
                        width: getProportionateScreenWidth(40),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: getProportionateScreenHeight(25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ProfileListItem(
                  icon: Icons.settings,
                  text: 'Ayarlar',
                ),
                ProfileListItem(
                  icon: Icons.note_add,
                  text: 'Öneri',
                ),
                ProfileListItem(
                  icon: Icons.outbond,
                  text: 'Çıkış Yap',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData? icon;
  final text;
  final bool? hasNavigation;

  const ProfileListItem({
    Key? key,
    this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(55),
      margin: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(35))
          .copyWith(bottom: getProportionateScreenHeight(20)),
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(30)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getProportionateScreenWidth(20)),
        color: kPrimaryColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: getProportionateScreenWidth(20),
          ),
          SizedBox(width: getProportionateScreenWidth(15)),
          Text(
            this.text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          if (this.hasNavigation!)
            Icon(
              Icons.chevron_right,
              size: getProportionateScreenWidth(20),
            ),
        ],
      ),
    );
  }
}
