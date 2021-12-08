import 'package:fitterapi/main_page/profile/user_and_datas.dart';
import 'package:fitterapi/services/auth.dart';
import 'package:fitterapi/sign_in/google_sign_in.dart';
import 'package:fitterapi/theme.dart';
import 'package:fitterapi/wrapper.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        StreamProvider<Users?>.value(
            value: AuthService().user, initialData: null),
        ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        home: Wrapper(),
      ),
    );

    // return ChangeNotifierProvider(
    //   create: (context) => GoogleSignInProvider(),
    //   child: MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       theme: theme(),
    //       home: Wrapper(),
    //     ),
    // );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//
//     return StreamProvider<Users?>.value(
//       value: AuthService().user,
//       initialData: null,
//       catchError: (User,theUser) => null,
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: theme(),
//         home: Wrapper(),
//       ),
//     );
//   }
// }
