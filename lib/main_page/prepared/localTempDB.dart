import 'package:shared_preferences/shared_preferences.dart';

class LocalTempDB{
  static Future<List<String>> saveLikeList(String shareId,List<String>? myLikeList,bool isLikeShare) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? newLikeList = myLikeList;
    if(myLikeList == null) {
      newLikeList = <String>[];
      newLikeList.add(shareId);
    }else {
      if (isLikeShare) {
        myLikeList.remove(shareId);
      }else {
        myLikeList.add(shareId);
      }
    }
    prefs.setStringList('likeList', newLikeList!);
    print(newLikeList);
    return newLikeList;
  }
}