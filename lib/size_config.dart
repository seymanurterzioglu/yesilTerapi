import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;


  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Sayfa boyutuna göre boyut ayarlama

double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 812.0) * screenHeight;
}

// 812.0 ve 375.0 sayfa boyutlandırma ayarlarına göre değiştirilebilinir

double getProportionateScreenWidth(double inputHeight) {
  double screenWidth = SizeConfig.screenWidth;
  return (inputHeight / 375.0) * screenWidth;
}



