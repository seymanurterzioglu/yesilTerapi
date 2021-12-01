import 'package:fitterapi/services/auth.dart';
import 'package:fitterapi/theme.dart';
import 'package:fitterapi/wrapper.dart';
import 'package:provider/provider.dart';
import 'modules/user.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


// void main() {
//   runApp(MyApp());
// }

Future main() async {
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
        theme: theme(),
        home: Wrapper(),
      ),
    );
  }
}


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final _init = Firebase.initializeApp();
//     return FutureBuilder(
//         future: _init,
//         builder: (context, snapshoot) {
//           if (snapshoot.hasError) {
//             return ErrorWidget();
//           } else if (snapshoot.hasData) {
//             return MultiProvider(
//               providers: [
//                 ChangeNotifierProvider<AuthServices>.value(
//                     value: AuthServices()),
//                 StreamProvider<User?>.value(
//                   value: AuthServices().user,
//                   initialData: null,
//                 )
//               ],
//               child: MaterialApp(
//                 theme: theme(),
//                 debugShowCheckedModeBanner: false,
//                 home: Wrapper(),
//               ),
//             );
//           } else {
//             return Loading();
//           }
//         });
//   }
// }
//
// class ErrorWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Column(
//         children: [
//           Icon(Icons.error),
//           Text('Bİr şeyler yanlış gitti'),
//         ],
//       ),
//     ));
//   }
// }
//
// class Loading extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }