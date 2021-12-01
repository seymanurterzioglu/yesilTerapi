import 'package:fitterapi/authenticate/authenticate.dart';
import 'package:fitterapi/main_page/home/home_screen.dart';
import 'package:fitterapi/modules/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Provider.of<theUser?> we add ? because we say this can be null or not null

    final user = Provider.of<theUser?>(context);
    print(user);

    //return Authenticate();

    if (user != null){
      return HomeScreen();
    }else{
      return Authenticate();
    }
  }
}

// class Wrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<User?>(context);
//     if (user != null){
//       return HomeScreen();
//     }else{
//       return SignInScreen();
//     }
//   }
// }
