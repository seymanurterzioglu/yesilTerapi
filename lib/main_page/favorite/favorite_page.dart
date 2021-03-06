import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/favorite/list_favorite_course.dart';
import 'package:fitterapi/main_page/favorite/list_favorite_cures.dart';
import 'package:fitterapi/main_page/favorite/list_favorites_teas.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  final List<String> choice = ['Çaylar', 'Kürler', 'Kurslar'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choice.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Favoriler',style: TextStyle(fontWeight: FontWeight.bold,fontSize: getProportionateScreenHeight(25)),),
          backgroundColor: kPrimaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
          ),
          centerTitle: true,
          bottom: TabBar(
            unselectedLabelColor: Colors.white70,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              gradient:
                  LinearGradient(colors: [kPrimaryColor, Colors.greenAccent,Colors.tealAccent]),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 10,
                  color: Colors.black38.withOpacity(0.6),
                ),
              ],
              color: Colors.white70,
              //border: Border.all(color: kPrimaryColor,width: 170)
            ),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(choice[0]),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(choice[1]),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(choice[2]),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            listFavoriteTeas(),
            listFavoritesCures(),
            listFavoriteCourse(),
          ],
        ),
      ),
    );
  }
}
