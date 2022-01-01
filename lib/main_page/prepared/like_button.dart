import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

// ignore: must_be_immutable
class LikeButtonWidget extends StatelessWidget {
  double buttonSize = 40;
  bool isLiked=false;
  int likeCount=0;
  // LikeButtonWidget({
  //   Key? key,
  //   required this.press,
  //   required this.isLiked,
  //   required this.likeCount,
  // }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: buttonSize,
      isLiked: isLiked,
      likeCount: likeCount,
      bubblesColor: BubblesColor(
        dotPrimaryColor: Colors.red,
        dotSecondaryColor: Colors.deepOrangeAccent,
      ),
      likeBuilder: (isLiked) {
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(
            Icons.favorite,
            color: isLiked ? Colors.redAccent : Colors.white,
            size: buttonSize,
          ),
        );
      },
      likeCountPadding: EdgeInsets.only(left: getProportionateScreenHeight(8)),
      countBuilder: (count, isLiked, txt) {
        return Text(
          txt,
          style: TextStyle(
            color: isLiked? Colors.red : Colors.white,
            fontSize: getProportionateScreenHeight(20),
            fontWeight: FontWeight.bold,
          ),
        );
      },
      onTap: (isLiked) async{
        this.isLiked=!isLiked;
        likeCount+=this.isLiked? 1:-1;
        return !isLiked;
      } ,
    );
  }
}
