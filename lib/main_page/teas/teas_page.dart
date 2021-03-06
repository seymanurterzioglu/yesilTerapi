import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/teas/tea_detail.dart';
import 'package:fitterapi/main_page/teas/teas.dart';
import 'sleep/teas_sleep_page.dart';
import 'pregnancy/teas_pregnancy_page.dart';
import 'stomach/teas_stomach_page.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';

class TeaPage extends StatefulWidget {
  @override
  State<TeaPage> createState() => _TeaPageState();
}

class _TeaPageState extends State<TeaPage> {
  TextEditingController _searchController = TextEditingController();
  bool isSearchOn = false;
  bool _isSearching = false;

  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getTeasSnapshot();
  }

  getTeasSnapshot() async {
    var dataPregnancy = await FirebaseFirestore.instance
        .collection('teas')
        .doc('yS1NMBa4dULBEPdpipV8')
        .collection('Pregnancy')
        .orderBy('teaName')
        .get();
    var dataSleep = await FirebaseFirestore.instance
        .collection('teas')
        .doc('yS1NMBa4dULBEPdpipV8')
        .collection('Sleep')
        .orderBy('teaName')
        .get();
    var dataStomach = await FirebaseFirestore.instance
        .collection('teas')
        .doc('yS1NMBa4dULBEPdpipV8')
        .collection('Stomach')
        .orderBy('teaName')
        .get();
    setState(() {
      _allResults = dataPregnancy.docs + dataSleep.docs + dataStomach.docs;
      // _allResults=dataPregnancy.docs;
      // _allResults = dataSleep.docs;
      // _allResults = dataStomach.docs;
    });
    searchResultsList();
    return 'complete';
  }

  _onSearchChanged() {
    if (_searchController.text != "") {
      isSearchOn = true;
    } else {
      isSearchOn = false;
    }
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var teasSnapshot in _allResults) {
        var title = Teas.fromSnapshot(teasSnapshot).teaName!.toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(teasSnapshot);
        }
      }
    } else {
      Container(
        child: Text(
          'Arad??????n??z?? bulamad??k. ??zg??n??z',
          style: TextStyle(fontSize: getProportionateScreenHeight(30)),
        ),
      );
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // for to keyboard renderflex problem
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: getProportionateScreenHeight(95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        backgroundColor: kPrimaryColor,
        title: !_isSearching
            ? Text(
                'Bitkisel ??aylar',
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(25),
                    fontWeight: FontWeight.bold),
              )
            : TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Sen sor biz arayal??m',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
        actions: [
          //search
          _isSearching
              ? Padding(
                  padding: EdgeInsets.only(top: 3, right: 45),
                  child: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      setState(() {
                        this._isSearching = false;
                        _searchController.clear();
                      });
                    },
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 3, right: 45),
                  child: IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        this._isSearching = true;
                      });
                    },
                  ),
                ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          children: <Widget>[
            SizedBox(height: getProportionateScreenHeight(20)),
            // tags
            isSearchOn
                ? _resultsList.length > 0
                    ? Flexible(
                        child: ListView.builder(
                          itemCount: _resultsList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              listSearch(context, _resultsList[index]),
                        ),
                      )
                    : Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.error,
                                color: Colors.grey[700],
                                size: 64,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  'Arad??????n??z konuda ??ay bulunamad??',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[700]),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                : listDisease(),
          ],
        ),
      ),
    );
  }

  Widget listDisease() {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeasPregnancyList(),
              ),
              //MaterialPageRoute(builder: (context) => ProfileEdit()),
            );
          },
          title: Tag(
            color: pregnancyColor,
            image:
                'https://i4.hurimg.com/i/hurriyet/75/750x422/5efd155a45d2a04258b7634e.jpg',
            text: 'Hamilelik',
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TeasStomachPage()),
              //MaterialPageRoute(builder: (context) => ProfileEdit()),
            );
          },
          title: Tag(
            color: stomachColor,
            image:
                'https://cdn.yemek.com/mncrop/940/625/uploads/2018/05/mide-siskinligi-neden-olur-yeni.jpg',
            text: 'Mide',
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TeasSleepPage()),
              //MaterialPageRoute(builder: (context) => ProfileEdit()),
            );
          },
          title: Tag(
            color: sleepColor,
            image:
                'https://i.tmgrup.com.tr/gq/original/15-08/23/uykusuzhergece_0_0.jpg',
            text: 'Uyku',
          ),
        ),
      ],
    );
  }

  Widget listSearch(BuildContext context, DocumentSnapshot document) {
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
            padding: EdgeInsets.all(getProportionateScreenHeight(10)),
            child: Container(
              decoration: BoxDecoration(
                color: tea.useful == 'Hamilelik'
                    ? pregnancyColor
                    : tea.useful == 'Uyku'
                        ? sleepColor
                        : stomachColor,
                borderRadius:
                    BorderRadius.circular(getProportionateScreenHeight(50)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 3,
                    color: kPrimaryColor.withOpacity(0.6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(getProportionateScreenHeight(20)),
                      child: Column(
                        children: [
                          SizedBox(height: getProportionateScreenHeight(30)),
                          Text(
                            tea.teaName!,
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(20),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
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
                  SizedBox(width: getProportionateScreenWidth(20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final Color color;
  final String image;
  final String text;

  Tag({
    required this.color,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: getProportionateScreenHeight(15),
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20)),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(getProportionateScreenHeight(10)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(getProportionateScreenHeight(10)),
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(30),
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 110,
                width: 110,
                child: Image.network(
                  image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: getProportionateScreenWidth(20)),
          ],
        ),
      ),
    );
  }
}
//
// class Title extends StatelessWidget {
//   final String? text;
//   final GestureTapCallback? press;
//
//   const Title({
//     Key? key,
//     this.text,
//     this.press,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Text(
//             text!,
//             style: TextStyle(
//               fontSize: getProportionateScreenWidth(18),
//               color: Colors.black,
//             ),
//           ),
//           GestureDetector(
//             child: Text('Daha Fazla'),
//             onTap: press,
//           ),
//         ],
//       ),
//     );
//   }
// }
