import 'package:flutter/material.dart';

const kPrimaryColor=Color(0xFF339000);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Lütfen Emailini gir";
const String kInvalidEmailError = "Lütfen geçerli Emailini gir";
const String kPassNullError = "Lütfen şifreni gir";
const String kShortPassError = "Şifreniz çok kısa";
const String kMatchPassError = "Şifreniz doğru değil";

// Complete Profile
const String kFirstNameNullError = "Lütfen adınızı giriniz";
const String kLastNameNullError = "Lütfen soyisminizi giriniz";
const String kAgeNullError ="Lütfen yaşınızı giriniz";
const String kHeightNullError="Lütfen boyunuzu giriniz";
const String kWeightNullError="Lütfen kilonuzu giriniz";
const String kDiseaseNullError ="Lütfen hastalığınızı giriniz";
const String kDiscomfortNullError ="Lütfen rahatsızlığınızı giriniz";








    