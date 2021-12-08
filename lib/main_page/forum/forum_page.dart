
import 'package:flutter/material.dart';

class ForumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("Forum ",style: TextStyle(fontSize: 100),),
            //Search(),
            // ElevatedButton(onPressed: (){
            //   _auth.signOut();
            // }, child: Text('Çıkış'))
          ],
        ),
      ),
    );
  }
}
