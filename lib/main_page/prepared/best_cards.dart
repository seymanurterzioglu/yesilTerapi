import 'package:flutter/material.dart';
import '../../size_config.dart';


// burada resimleri tıklanabilir yapmam lazım daha sonra

class BestCards extends StatelessWidget {
  final String? name, image;

  const BestCards({
    Key? key,
    this.name,
    this.image,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:getProportionateScreenWidth(10)),
      child: SizedBox(
        height: getProportionateScreenHeight(130),
        width: getProportionateScreenWidth(190),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Image.network(
                image!,
                fit: BoxFit.fill,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        //withOpacity(..) saydamlıkta bu rengi resme ekledi
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenHeight(15),
                    vertical: getProportionateScreenWidth(10)),
                child: Text.rich(
                  TextSpan(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: getProportionateScreenWidth(7)),
                      children: [
                        TextSpan(
                          // değişkenleri string içinde yazabilmek için ($)
                          text: '$name\n',
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
