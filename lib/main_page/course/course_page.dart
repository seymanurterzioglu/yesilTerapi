import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/main_page/course/course.dart';
import 'package:fitterapi/main_page/course/detail_course.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  TextEditingController _searchController = TextEditingController();

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
    resultsLoaded = getCourseSnapshot();
  }

  getCourseSnapshot() async {
    var data = await FirebaseFirestore.instance
        .collection('course')
        .orderBy('courseName')
        .get();
    setState(() {
      _allResults = data.docs;
    });
    searchResultsList();
    return 'complete';
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var courseSnapshot in _allResults) {
        var title =
            Course.fromSnapshot(courseSnapshot).courseName.toLowerCase();
        var title2 = Course.fromSnapshot(courseSnapshot).teacher.toLowerCase();

        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(courseSnapshot);
        } else if (title2.contains(_searchController.text.toLowerCase())) {
          showResults.add(courseSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Tavsiye Kurslar',
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
                  hintText: 'Sen sor biz arayalım',
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
            // search real
            // Container(
            //   padding: EdgeInsets.symmetric(
            //       vertical: getProportionateScreenWidth(20),
            //       horizontal: getProportionateScreenHeight(20)),
            //   decoration: BoxDecoration(
            //     color: kPrimaryColor,
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(50),
            //       bottomRight: Radius.circular(50),
            //     ),
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(
            //         vertical: getProportionateScreenWidth(10),
            //         horizontal: getProportionateScreenHeight(30)),
            //     child: Row(
            //       children: <Widget>[
            //         Container(
            //           width: getProportionateScreenWidth(250),
            //           height: 50,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(15),
            //           ),
            //           child: TextField(
            //             controller: _searchController,
            //             decoration: InputDecoration(
            //               enabledBorder: InputBorder.none,
            //               focusedBorder: InputBorder.none,
            //               hintText: "Sen sor biz arayalım",
            //               hintStyle: TextStyle(color: Colors.black38),
            //               prefixIcon: Icon(
            //                 Icons.search_sharp,
            //                 color: Colors.black,
            //               ),
            //               contentPadding: EdgeInsets.symmetric(
            //                 horizontal: getProportionateScreenHeight(5),
            //                 vertical: getProportionateScreenWidth(15),
            //               ),
            //             ),
            //             style: TextStyle(color: Colors.black54),
            //           ),
            //         ),
            //         SizedBox(width: getProportionateScreenWidth(10)),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: getProportionateScreenHeight(20)),
            _resultsList.length>0
            ? Expanded(
              child: GridView.builder(
                itemCount: _resultsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (BuildContext context, int index) =>
                    listCourse(context, _resultsList[index]),
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
                          'Aradığınız konuda kurs bulunamadı',
                          style:
                          TextStyle(fontSize: 16, color: Colors.grey[700]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget listCourse(BuildContext context, DocumentSnapshot document) {
    final course = Course.fromSnapshot(document);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => detailCourse(context, document)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(getProportionateScreenHeight(2)),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  //borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(course.image, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenHeight(15),
                  vertical: getProportionateScreenWidth(10)),
              child: Text(
                course.courseName,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  //fontStyle: FontStyle.italic,
                  fontSize: getProportionateScreenHeight(16),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(17),
                //vertical: getProportionateScreenWidth(10),
              ),
              child: Text(
                course.teacher,
                style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontSize: getProportionateScreenHeight(13),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//   Widget build(BuildContext context) {
//     return StreamProvider<List<Course>>.value(
//       value: CourseDatabase().courseData,
//       initialData: [],
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Padding(
//           padding: EdgeInsets.only(bottom: 10),
//           child: Column(
//             children: <Widget>[
//               //Search(),
//               // search real
//               Container(
//                 padding: EdgeInsets.symmetric(
//                     vertical: getProportionateScreenWidth(20),
//                     horizontal: getProportionateScreenHeight(20)
//                 ),
//                 decoration: BoxDecoration(
//                   color: kPrimaryColor,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(50),
//                     bottomRight: Radius.circular(50),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                       vertical: getProportionateScreenWidth(10),
//                       horizontal: getProportionateScreenHeight(30)
//                   ),
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                         width: getProportionateScreenWidth(250),
//                         height: 50,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: TextField(
//                           onChanged: (value) {
//
//                           },
//                           controller: _searchController,
//                           decoration: InputDecoration(
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             hintText: "Sen sor biz arayalım",
//                             hintStyle: TextStyle(color: Colors.black38),
//                             prefixIcon: Icon(
//                               Icons.search_sharp,
//                               color: Colors.black,
//                             ),
//                             contentPadding: EdgeInsets.symmetric(
//                               horizontal: getProportionateScreenHeight(5),
//                               vertical: getProportionateScreenWidth(15),
//                             ),
//                           ),
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                       ),
//                       SizedBox(width: getProportionateScreenWidth(10)),
//
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: getProportionateScreenHeight(20)),
//               CourseList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
