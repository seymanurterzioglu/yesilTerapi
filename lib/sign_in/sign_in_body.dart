import 'package:fitterapi/button.dart';
import 'package:fitterapi/const.dart';
import 'package:fitterapi/error.dart';
import 'package:fitterapi/main_page/home/home_screen.dart';
import 'package:fitterapi/modules/user.dart';
import 'package:fitterapi/services/auth.dart';
import 'package:fitterapi/sign_in/google_sign_in.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:fitterapi/sign_up/dart/sign_up_screen.dart';
import 'package:fitterapi/size_config.dart';
import 'package:flutter/material.dart';
import '../forgot_password/forgot_password_screen.dart';

class SignInBody extends StatefulWidget {
  @override
  State<SignInBody> createState() => _SignInBodyState();
}



class _SignInBodyState extends State<SignInBody> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? error;
  bool remember = false;
  bool isPasswordVisible = true;
  List<String> errors = [];

  final AuthService _auth = AuthService();

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<theUser?>(context);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenHeight(20)),
              child: Column(
                children: <Widget>[
                  SizedBox(height: getProportionateScreenHeight(20)),
                  // Resim ayarlaması
                  Container(
                    height: 280,
                    child: Image.asset("assets/images/iconYazılı2.jpeg"),
                  ),
                  SizedBox(height: getProportionateScreenHeight(2)),
                  Text(
                    "'ye Hoşgeldiniz!",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: getProportionateScreenWidth(20),
                    ),
                  ),
                  Text(
                    "Lütfen email ve şifreniz ile giriş yapınız.",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getProportionateScreenHeight(7)),
                  //Email form
                  formEmail(),
                  SizedBox(height: getProportionateScreenHeight(7)),
                  //Password form
                  formPassword(),
                  //Şifremi unuttum
                  Row(
                    children: [
                      Checkbox(
                        value: remember,
                        activeColor: kPrimaryColor,
                        onChanged: (value) {
                          setState(() {
                            remember = value!;
                          });
                        },
                      ),
                      Text("Hatırla Beni"),
                      SizedBox(width: getProportionateScreenWidth(100)),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen()),
                        ),
                        child: Text(
                          "Şifremi Unuttum",
                          style: TextStyle(
                            color: kPrimaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),

                  //  Error kısımları
                  FormError(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  //Button
                  Button(
                    text: "İleri",
                    press: () async {
                      print(email);
                      print(password);
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // User? _currentUser = FirebaseAuth.instance.currentUser;
                        // String id = _currentUser!.uid;
                        // eğer her şey doğruysa giriş ekranına git
                        //FocusScopeNode currentFocus = FocusScope.of(context);
                        dynamic result = await _auth.signInWithEmailPassword(
                            email!, password!);
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        }

                        // // google giriş için bir şey yapmaya çalışıyorum
                        // bool barrier = false;
                        // var userList = [];

                        // getUserSnapshot() async {
                        //   var data = await FirebaseFirestore.instance.collection('users').get();
                        //     userList = data.docs;
                        //   for(var userName in userList){
                        //     var search= UserData.fromSnapshot(userName).uid;
                        //     if (search!.contains(id)){
                        //       barrier=false;
                        //       print('barrier is false');
                        //     }else{
                        //       barrier=true;
                        //       print('barrier is true');
                        //     }
                        //   }
                        //
                        //   return 'complete';
                        // }
                        // getUserSnapshot();

                        if (result == null) {
                          setState(
                              () => error = 'Eposta ya da şifreniz hatalıdır');
                        }
                        // else if (barrier == true) {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => CompleteProfileScreen()),
                        //   );
                        // }
                        else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        }
                        // if (!currentFocus.hasPrimaryFocus) {
                        //   currentFocus.unfocus();
                        // }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => HomeScreen()),
                        // );
                      }
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  if (error != null)
                    Container(
                      color: kPrimaryColor,
                      child: ListTile(
                        title: Text(error!),
                        leading: Icon(Icons.error),
                        // trailing: IconButton(
                        //   icon: Icon(Icons.close),
                        //   onPressed: () {},
                        // ),
                      ),
                    ),

                  //anonlymosy sign in buton
                  // Button(
                  //   text: "Sign In Anon",
                  //   press: () async {
                  //     dynamic result = await _auth.signInAnon();
                  //     if(result == null){
                  //       print('error sign ın');
                  //     }else{
                  //       print('sign in succesfully');
                  //       print(result.uid);
                  //     }
                  //   },
                  // ),

                  // google sign in
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      minimumSize: Size(getProportionateScreenHeight(40),
                          getProportionateScreenWidth(35)),
                    ),
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    label: Text('Google ile giriş yap'),
                    onPressed: () async {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin();
                      // String googleUid=provider.getId();
                    },
                  ),

                  //Hesabın yok mu? Kayıt ol
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hesabınız yok mu? O zaman ",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
                          );
                        },
                        child: Text(
                          "kayıt olabilirsiniz:)",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(12),
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //SignINBody de ki değişkenleri kullanabilmeleri için bu metotları(email form, password form) SıgnIn Body içine yerleştirdik
  //   Buna dikkat et burada kafan karıştı!!!!!!!!

  // Şifre Form
  TextFormField formPassword() {
    return TextFormField(
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        setState(() => password = value);
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Şifre",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        hintText: "Şifrenizi Giriniz.",
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(28),
        //   borderSide: BorderSide(color: Colors.black45),
        //   gapPadding: 10,
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(28),
        //   borderSide: BorderSide(color: Colors.black45),
        //   gapPadding: 10,
        // ),
        suffixIcon: IconButton(
          icon: isPasswordVisible
              ? Icon(
                  Icons.visibility,
                  color: Colors.black45,
                )
              : Icon(Icons.visibility),
          onPressed: () =>
              setState(() => isPasswordVisible = !isPasswordVisible),
        ),
      ),
      obscureText: isPasswordVisible,
      obscuringCharacter: "*",
    );
  }

// Email Form

  TextFormField formEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        setState(() => email = value);
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        hintText: "Emailinizi Giriniz.",
      ),
    );
  }
}

// class _SignInBodyState extends State<SignInBody> {
//   final _formKey = GlobalKey<FormState>();
//   String? email;
//   String? password;
//   String? error;
//   bool remember = false;
//   bool isPasswordVisible = true;
//   List<String> errors = [];
//
//   final AuthService _auth = AuthService();
//
//   void addError({String? error}) {
//     if (!errors.contains(error))
//       setState(() {
//         errors.add(error!);
//       });
//   }
//
//   void removeError({String? error}) {
//     if (errors.contains(error))
//       setState(() {
//         errors.remove(error);
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final loginProvider = Provider.of<AuthServices>(context);
//     return SingleChildScrollView(
//       child: Form(
//         key: _formKey,
//         child: SafeArea(
//           child: SizedBox(
//             width: double.infinity,
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: getProportionateScreenHeight(20)),
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(height: getProportionateScreenHeight(20)),
//                   // Resim ayarlaması
//                   Container(
//                     height: 280,
//                     child: Image.asset("assets/images/iconYazılı2.jpeg"),
//                   ),
//                   SizedBox(height: getProportionateScreenHeight(2)),
//                   Text(
//                     "'ye Hoşgeldiniz!",
//                     style: TextStyle(
//                       color: Colors.black45,
//                       fontSize: getProportionateScreenWidth(20),
//                     ),
//                   ),
//                   Text(
//                     "Lütfen email ve şifreniz ile giriş yapınız.",
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: getProportionateScreenHeight(7)),
//                   //Email form
//                   formEmail(),
//                   SizedBox(height: getProportionateScreenHeight(7)),
//                   //Password form
//                   formPassword(),
//                   //Şifremi unuttum
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: remember,
//                         activeColor: kPrimaryColor,
//                         onChanged: (value) {
//                           setState(() {
//                             remember = value!;
//                           });
//                         },
//                       ),
//                       Text("Hatırla Beni"),
//                       SizedBox(width: getProportionateScreenWidth(100)),
//                       GestureDetector(
//                         onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ForgotPasswordScreen()),
//                         ),
//                         child: Text(
//                           "Şifremi Unuttum",
//                           style: TextStyle(
//                             color: kPrimaryColor,
//                             decoration: TextDecoration.underline,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   //  Error kısımları
//                   FormError(errors: errors),
//                   SizedBox(height: getProportionateScreenHeight(10)),
//                   //Button
//                   ElevatedButton(
//                     child: loginProvider.isLoading
//                         ? CircularProgressIndicator()
//                         : Text('Giriş Yap'),
//                     onPressed: () async {
//                       print(email);
//                       print(password);
//                       if (_formKey.currentState!.validate()) {
//                         _formKey.currentState!.save();
//                         // eğer her şey doğruysa giriş ekranına git
//                         FocusScopeNode currentFocus = FocusScope.of(context);
//                         dynamic result = await _auth.signUpWithEmailPassword(
//                             email!, password!);
//                         if (result == null) {
//                           setState(
//                               () => error = 'Email ya da şifreniz hatalıdır');
//                           AlertDialog(title: Text(error!));
//                         }
//                         if (!currentFocus.hasPrimaryFocus) {
//                           currentFocus.unfocus();
//                         }
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => HomeScreen()),
//                         );
//                       }
//                     },
//                   ),
//                   SizedBox(height: getProportionateScreenHeight(10)),
//                   // google-facebook-twitter
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SocialCArd(
//                         icon: "assets/icons/google.svg",
//                         press: () {},
//                       ),
//                       SocialCArd(
//                         icon: "assets/icons/facebook.svg",
//                         press: () {},
//                       ),
//                       SocialCArd(
//                         icon: "assets/icons/twitter.svg",
//                         press: () {},
//                       ),
//                     ],
//                   ),
//                   //Hesabın yok mu? Kayıt ol
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Hesabınız yok mu? O zaman ",
//                         style: TextStyle(
//                           fontSize: getProportionateScreenWidth(12),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => SignUpScreen()),
//                           );
//                         },
//                         child: Text(
//                           "kayıt olabilirsiniz:)",
//                           style: TextStyle(
//                             fontSize: getProportionateScreenWidth(12),
//                             color: kPrimaryColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: getProportionateScreenHeight(10)),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   //SignINBody de ki değişkenleri kullanabilmeleri için bu metotları(email form, password form) SıgnIn Body içine yerleştirdik
//   //   Buna dikkat et burada kafan karıştı!!!!!!!!
//
//   // Şifre Form
//   TextFormField formPassword() {
//     return TextFormField(
//       onSaved: (newValue) => password = newValue,
//       onChanged: (value) {
//         setState(() => password = value);
//         if (value.isNotEmpty) {
//           removeError(error: kPassNullError);
//         } else if (value.length >= 8) {
//           removeError(error: kShortPassError);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kPassNullError);
//           return "";
//         } else if (value.length < 8) {
//           addError(error: kShortPassError);
//           return "";
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "Şifre",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         contentPadding: EdgeInsets.all(20),
//         hintText: "Şifrenizi Giriniz.",
//         // enabledBorder: OutlineInputBorder(
//         //   borderRadius: BorderRadius.circular(28),
//         //   borderSide: BorderSide(color: Colors.black45),
//         //   gapPadding: 10,
//         // ),
//         // focusedBorder: OutlineInputBorder(
//         //   borderRadius: BorderRadius.circular(28),
//         //   borderSide: BorderSide(color: Colors.black45),
//         //   gapPadding: 10,
//         // ),
//         suffixIcon: IconButton(
//           icon: isPasswordVisible
//               ? Icon(
//                   Icons.visibility,
//                   color: Colors.black45,
//                 )
//               : Icon(Icons.visibility),
//           onPressed: () =>
//               setState(() => isPasswordVisible = !isPasswordVisible),
//         ),
//       ),
//       obscureText: isPasswordVisible,
//       obscuringCharacter: "*",
//     );
//   }
//
// // Email Form
//
//   TextFormField formEmail() {
//     return TextFormField(
//       keyboardType: TextInputType.emailAddress,
//       onSaved: (newValue) => email = newValue,
//       onChanged: (value) {
//         setState(() => email = value);
//         if (value.isNotEmpty) {
//           removeError(error: kEmailNullError);
//         } else if (emailValidatorRegExp.hasMatch(value)) {
//           removeError(error: kInvalidEmailError);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kEmailNullError);
//           return "";
//         } else if (!emailValidatorRegExp.hasMatch(value)) {
//           addError(error: kInvalidEmailError);
//           return "";
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "Email",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         contentPadding: EdgeInsets.all(20),
//         hintText: "Emailinizi Giriniz.",
//         // enabledBorder: OutlineInputBorder(
//         //   borderRadius: BorderRadius.circular(28),
//         //   borderSide: BorderSide(color: Colors.black45),
//         //   gapPadding: 10,
//         // ),
//         // focusedBorder: OutlineInputBorder(
//         //   borderRadius: BorderRadius.circular(28),
//         //   borderSide: BorderSide(color: Colors.black45),
//         //   gapPadding: 10,
//         // ),
//       ),
//     );
//   }
// }

//
// StreamBuilder<Object>(
// stream: userDatabase.userData,
// builder: (context, snapshot) {
// return ElevatedButton.icon(
// style: ElevatedButton.styleFrom(
// primary: Colors.white,
// onPrimary: Colors.black,
// minimumSize: Size(getProportionateScreenHeight(40),
// getProportionateScreenWidth(35)),
// ),
// icon: FaIcon(
// FontAwesomeIcons.google,
// color: Colors.red,
// ),
// label: Text('Google ile giriş yap'),
// onPressed: () async {
// final provider = Provider.of<GoogleSignInProvider>(
// context,
// listen: false);
// provider.googleLogin();
// if(snapshot.hasData){
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => HomeScreen()),
// );
// }else{
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => CompleteProfileScreen()),
// );
// }
// },
// );
// }
// ),
