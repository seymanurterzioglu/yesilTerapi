import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/cures/cures.dart';
import 'package:fitterapi/main_page/cures/cures_list.dart';
import 'package:fitterapi/main_page/cures/new_cure_screen.dart';
import 'package:fitterapi/main_page/prepared/search.dart';
import 'package:fitterapi/services/cures_database.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class CuresPage extends StatefulWidget {
  @override
  State<CuresPage> createState() => _CuresPageState();
}

class _CuresPageState extends State<CuresPage> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Cures>>.value(
      value: CuresDatabase().curesData,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            children: <Widget>[
              Search(),
              SizedBox(
                height: getProportionateScreenHeight(50),
                child: Card(
                  color: kPrimaryColor,
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => NewCureScreen());
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
              ),
              CuresList(),
            ],
          ),
        ),
      ),
    );
  }
}

