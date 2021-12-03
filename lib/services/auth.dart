import "package:firebase_auth/firebase_auth.dart";
import 'package:fitterapi/modules/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? nowUID;
  String? nowUser;
  //AuthService(this._auth);


  void sendNowUID(String now){
    nowUID=now;
  }



  Future<String> getCurrentUID() async {
    return (await _auth.currentUser)!.uid;
  }

  Future getCurrentUser() async {
    //
    return await _auth.currentUser;
  }

  theUser? _userFromFirebase(User? user){
    if (user != null) {
      return theUser(uid:user.uid);
    } else {
      return null;
    }
  }

  //auth change user stream
  Stream<theUser?> get user {
    return _auth.authStateChanges()
        .map((User? user) => _userFromFirebase(user!));
        // .map(_userFromFirebase); same as up line
  }



  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailPassword(String email,String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch(e){
      print(e.toString());
      return null;
    }

  }


  //register (sign up) with email & password
  Future signUpWithEmailPassword(String email,String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //create a new document  for the user with the uid
      // await UserDatabase(uid: user!.uid).terapiCollection(''); içindeki kısımları dolduracağız sonra

      return _userFromFirebase(user!);
    } catch(e){
      print(e.toString());
      return null;
    }

  }


  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }


}
