import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/prepared/best_cards.dart';
import 'package:fitterapi/main_page/teas/tea_detail.dart';
import 'package:fitterapi/main_page/teas/teas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../size_config.dart';

class TeasPregnancyList extends StatefulWidget {
  @override
  _TeasPregnancyListState createState() => _TeasPregnancyListState();
}

class _TeasPregnancyListState extends State<TeasPregnancyList> {
  List _allResults = [];
  var showResults = [];
  late Future resultsLoaded;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getCourseSnapshot();
  }

  getCourseSnapshot() async {
    var data = await FirebaseFirestore.instance
        .collection('teas')
        .doc('yS1NMBa4dULBEPdpipV8')
        .collection('Pregnancy')
        .orderBy('teaName')
        .get();
    setState(() {
      _allResults = data.docs;

    });
    showResults = List.from(_allResults);
    _allResults=showResults;
    return 'complete';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            // Title
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenWidth(20),
                  horizontal: getProportionateScreenHeight(20)
              ),
              decoration: BoxDecoration(
                color: pregnancyColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenWidth(10),
                    horizontal: getProportionateScreenHeight(15)
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: ()=>Navigator.pop(context),
                        icon: Icon(Icons.keyboard_return),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                            'Hamilelik',
                            style: TextStyle(
                              decorationThickness: 2.5,
                              fontSize: getProportionateScreenHeight(40),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                    ),
                    SizedBox(width: getProportionateScreenWidth(1)),
                    // Container(
                    //   padding: EdgeInsets.all(getProportionateScreenWidth(7)),
                    //   height: getProportionateScreenHeight(45),
                    //   width: getProportionateScreenWidth(45),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: SvgPicture.asset("assets/icons/bell5.svg"),
                    // ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(18),
                vertical: getProportionateScreenWidth(2),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Title(
                      text: '??nerilenler',
                      press: () {},
                    ),
                    SizedBox(height: getProportionateScreenHeight(8)),
                    // s??k incelenenler yana do??ru kayd??rmal??
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          BestCards(
                            name: 'Ahududu Yapra????',
                            image:
                                'https://imgrosetta.mynet.com.tr/file/12155033/12155033-1200x675.jpg',
                          ),
                          BestCards(
                            name: 'Ihlamur',
                            image:
                                'https://img.fanatik.com.tr/img/78/740x418/5dd45091ae298b36efd31f51.jpg',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: _allResults.length,
                itemBuilder: (BuildContext context, int index) =>
                    listPregnancy(context, _allResults[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listPregnancy(BuildContext context, DocumentSnapshot document){
    final tea = Teas.fromSnapshot(document);
    return SizedBox(
      height: getProportionateScreenHeight(200),
      width: getProportionateScreenWidth(50),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => teaDetail(context, document)),
          );
        },
        title: ClipRRect(
          child: Padding(
            padding:
            EdgeInsets.all(getProportionateScreenHeight(10)),
            child: Container(
              decoration: BoxDecoration(
                color: pregnancyColor,
                borderRadius: BorderRadius.circular(
                    getProportionateScreenHeight(50)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(
                          getProportionateScreenHeight(20)),
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                              getProportionateScreenHeight(
                                  30)),
                          Text(
                            tea.teaName!,
                            style: TextStyle(
                              fontSize:
                              getProportionateScreenHeight(
                                  20),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                              height:
                              getProportionateScreenHeight(
                                  20)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      tea.image!,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                      width: getProportionateScreenWidth(20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}

class Title extends StatelessWidget {
  final String? text;
  final GestureTapCallback? press;

  const Title({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text!,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: Colors.black,
            ),
          ),
          GestureDetector(
            child: Text('Daha Fazla'),
            onTap: press,
          ),
        ],
      ),
    );
  }
}
