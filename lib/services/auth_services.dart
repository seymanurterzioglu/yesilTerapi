import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/widgets.dart';

class AuthServices with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool get isLoading => _isLoading;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future signUp(String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user;
      setLoading(false);
      return user;
    } catch (e) {
      setLoading(false);
      setMessage(e.toString());
    }
    notifyListeners();
  }

  Future signIn(String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user;
      setLoading(false);
      return user;
    } catch (e) {
      setLoading(false);
      setMessage(e.toString());
    }
    notifyListeners();
  }

  Future logOut() async {
    await firebaseAuth.signOut();
  }


  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  Stream<User?> get user => firebaseAuth.authStateChanges().map((event) => event);

}
