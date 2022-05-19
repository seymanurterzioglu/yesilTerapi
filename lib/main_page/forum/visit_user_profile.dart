import 'package:flutter/material.dart';

import '../../const.dart';
import '../../size_config.dart';


class VisitUserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '-------  Profil',
          style: TextStyle(
              fontSize: getProportionateScreenHeight(25),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: getProportionateScreenHeight(95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          // image
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: getProportionateScreenHeight(250),
                width: getProportionateScreenWidth(230),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/circle.jpg"),
                      fit: BoxFit.cover),
                ),
                margin: EdgeInsets.only(top: getProportionateScreenHeight(5)),
                child: Stack(

                  children: <Widget>[
                    Positioned(
                      top: 19,
                      left: 53,
                      child: CircleAvatar(
                        radius: getProportionateScreenWidth(80),
                        backgroundImage:
                        AssetImage("assets/images/g5.png"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //user name -surname
          SizedBox(height: getProportionateScreenHeight(20)),
          Container(
            color: Colors.white10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('nickname', style: TextStyle(color: Colors.grey[800], fontFamily: "Roboto",
                        fontSize: getProportionateScreenHeight(35), fontWeight: FontWeight.w700
                    ),),
                    Text("name surname", style: TextStyle(color: Colors.grey[500], fontFamily: "Roboto",
                        fontSize:getProportionateScreenHeight(18), fontWeight: FontWeight.w400
                    ),),
                  ],
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
                IconButton(
                  icon: Icon(Icons.sms,color: kPrimaryColor,size: getProportionateScreenHeight(40)),
                  onPressed: (){},
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
