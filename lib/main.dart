import 'package:fitterapi/services/auth.dart';
import 'package:fitterapi/theme.dart';
import 'package:fitterapi/wrapper.dart';
import 'package:provider/provider.dart';
import 'modules/user.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

//
// void main() {
//   runApp(MyApp());
// }

Future main()  async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<theUser?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (User,theUser) => null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FitTerapi',
        theme: theme(),
        home: Wrapper(),
      ),
    );
  }
}
