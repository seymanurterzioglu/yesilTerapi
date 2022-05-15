import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitterapi/main_page/teas/teas.dart';

class TeasDatabase {
  String? useful;
  TeasDatabase({
    this.useful,
 });

  final DocumentReference teasCollection = FirebaseFirestore.instance.collection('teas').doc('yS1NMBa4dULBEPdpipV8');

  final CollectionReference teasPregnancyCollection = FirebaseFirestore.instance
      .collection('teas')
      .doc('yS1NMBa4dULBEPdpipV8')
      .collection('Pregnancy');

  final CollectionReference teasSleepCollection =
  FirebaseFirestore.instance.collection('teas').doc(
      'yS1NMBa4dULBEPdpipV8').collection('Sleep');

  final CollectionReference teasStomachCollection =
  FirebaseFirestore.instance.collection('teas').doc(
      'yS1NMBa4dULBEPdpipV8').collection('Stomach');


  //   add kısmı düzenlenecek daha sonradan
  Future<Teas?> addTea(String _teaName, String? _useful, String? _info, String _warning,
      String _recipe, String _image) async {

    //Bunu bu dosyyayı çağracağım yere yapacağım.Orada useful pregnancy ise bu fonk pregnancy göndericek.hiçbiri olmaz ise ekran hata yazıcak
    // Tabi ben yeni çay eklemede sadece 3 seçenek koyacağım(pregnacy,stomach,sleep)
    if(_useful == 'Hamilelik'){
      var documentRef = await teasPregnancyCollection.add({
        'teaName': _teaName,
        'useful': _useful,
        'info':_info,
        'warning':_warning,
        'recipe':_recipe,
        'image':_image,
      });
    }else if(_useful=='Uyku'){
      var documentRef = await teasSleepCollection.add({
        'teaName': _teaName,
        'useful': _useful,
        'info':_info,
        'warning':_warning,
        'recipe':_recipe,
        'image':_image,
      });

    }else if(_useful == 'Mide'){
      var documentRef = await teasStomachCollection.add({
        'teaName': _teaName,
        'useful': _useful,
        'info':_info,
        'warning':_warning,
        'recipe':_recipe,
        'image':_image,
      });

    }else{
      return null;
    }
    return null;
  }

  Stream<QuerySnapshot> getPregnancyList(){
    return teasPregnancyCollection.snapshots();
  }

  Stream<QuerySnapshot> getTeasList(String useful) {
    if(useful=='Pregnancy'){
      return teasPregnancyCollection.orderBy('teaName').snapshots();
    }else if(useful=='Sleep'){
      return teasSleepCollection.orderBy('teaName').snapshots();
    }else if (useful== 'Stomach'){
      return teasStomachCollection.orderBy('teaName').snapshots();
    }else{
      return teasPregnancyCollection.snapshots();  // burasının nasıl yapılacağına tam emin olamadım
    }
  }

  List<Teas> _teasListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Teas(
        teaName: doc.get('teaName') ?? '',
        info: doc.get('info') ?? '',
        useful: doc.get('useful') ?? '',
        recipe: doc.get('recipe') ?? '',
        warning: doc.get('warning') ?? '',
        image: doc.get('image') ?? '',
      );
    }).toList();
  }

  Stream<List<Teas>> get teasPregnancyData {
    return teasPregnancyCollection.snapshots().map(_teasListFromSnapshot);
  }

  Stream<List<Teas>> get teasStomachData {
    return teasStomachCollection.snapshots().map(_teasListFromSnapshot);
  }

  Stream<List<Teas>> get teasSleepData {
    return teasSleepCollection.snapshots().map(_teasListFromSnapshot);
  }


}
