
import 'package:fitterapi/login/login_screen.dart';
import 'package:fitterapi/sign_in/sign_in_screen.dart';
import 'package:fitterapi/splash/splash_screen.dart';

import 'package:flutter/widgets.dart';

final Map<String,WidgetBuilder> routes={
  SplashScreen.routeName:(context)=> SplashScreen(),
  SignInScreen.routeName:(context)=> SignInScreen(),
  LoginScreen.routeName:(context)=> LoginScreen(),
};

