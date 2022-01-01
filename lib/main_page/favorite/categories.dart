import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/prepared/search.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ['Çaylar', 'Kürler', 'Kurslar'];
  int selectedIndex = 0;

  int getIndex(int index){
    return selectedIndex;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenHeight(20),
            vertical: getProportionateScreenWidth(30)),
      
      child: SizedBox(
        height: getProportionateScreenHeight(35),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context,index)=> buildCategoriItem(index),
        ),
      ),
    );
  }

  Widget buildCategoriItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: getProportionateScreenWidth(15)),
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20), //20
          vertical: getProportionateScreenHeight(2), //5
        ),
        decoration: BoxDecoration(
            color:
            selectedIndex == index ? Color(0xFFEFF3EE) : Colors.transparent,
            borderRadius: BorderRadius.circular(
              getProportionateScreenHeight(10), // 16
            )),
        child: Text(
          categories[index],
          style: TextStyle(
            fontSize: getProportionateScreenHeight(20),
            fontWeight: FontWeight.bold,
            color: selectedIndex == index ? kPrimaryColor : Colors.black38,
          ),
        ),
      ),
    );
  }

  // int getIndex(int index){
  //   return selectedIndex;
  // }

}
